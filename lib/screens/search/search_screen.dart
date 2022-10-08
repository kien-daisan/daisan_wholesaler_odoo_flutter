import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/helper/alert_message.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/helper/app_shared_pref.dart';
import 'package:flutter_project_structure/models/SearchScreenModel.dart';
import 'package:flutter_project_structure/screens/search/bloc/search_bloc.dart';
import 'package:flutter_project_structure/screens/search/bloc/search_events.dart';
import 'package:flutter_project_structure/screens/search/bloc/search_state.dart';
import 'package:flutter_project_structure/screens/search/views/search_suggestion.dart';
import 'package:flutter_project_structure/utils/helper.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import '../../customWidgtes/dialog_helper.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool isLoading = false;
  bool isFirst = true;
  SearchScreenModel? searchModel;
  TextEditingController textEditingController = TextEditingController();
  SearchScreenBloc? searchScreenBloc;
  AppLocalizations? _localizations;
  SpeechToText _speechToText = SpeechToText();
  bool _isListening = false;
  String transcription = '';
  String selectedLang = "en_US";

  @override
  void initState() {
    activateSpeechRecognizer();
    selectedLang = AppSharedPref().getAppLanguage() ?? 'en_US';
    searchScreenBloc = context.read<SearchScreenBloc>();
    searchScreenBloc?.add(InitialSearchSuggestionEvent());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
    super.didChangeDependencies();
  }

  void activateSpeechRecognizer() async {
    await _speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult,
        // localeId: selectedLang
    );
    _isListening = true;
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await _speechToText.stop();
    _isListening = false;
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      transcription = result.recognizedWords;
      textEditingController.text = transcription;
      searchScreenBloc?.add(SearchSuggestionEvent(transcription));
      _stopListening();
    });
  }

  void errorHandler() => activateSpeechRecognizer();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchScreenBloc, SearchState>(
        builder: (context, currentState) {
      print(currentState);
      if (currentState is SearchInitialState) {
        if (!isFirst) {
          isLoading = true;
        }
        isFirst = false;
      } else if (currentState is SearchScreenSuccess) {
        isLoading = false;
        searchModel = currentState.searchSuggestionModel;
        isLoading = false;
        searchScreenBloc?.emit(SearchActionState());
      } else if (currentState is SearchScreenError) {
        isLoading = false;
        WidgetsBinding.instance?.addPostFrameCallback((_) {
          AlertMessage.showError(currentState.message, context);
        });
      }
      return _buildUI();
    });
  }

  Widget _buildUI() {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Helper.hideSoftKeyBoard();
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
            ),
          ),
          title: TextField(
            readOnly: _isListening,
            controller: textEditingController,
            onChanged: (searchKey) {
              print("Search key ---> " + searchKey);
              searchScreenBloc?.add(SearchSuggestionEvent(searchKey));
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText:
                  _localizations?.translate(AppStringConstant.search) ?? '',
              hintStyle: Theme.of(context).textTheme.subtitle2?.copyWith(
                    fontWeight: FontWeight.normal,
                color: Theme.of(context).colorScheme.secondaryContainer
                  ),
            ),
            style: Theme.of(context).textTheme.subtitle2?.copyWith(color: Theme.of(context).colorScheme.secondaryContainer),
            cursorColor: Theme.of(context).colorScheme.secondaryContainer,
          ),
          actions: [
            (_isListening)
                ? Center(
                    child: Text(
                        _localizations
                                ?.translate(AppStringConstant.listening) ??
                            '',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2
                            ?.copyWith(fontWeight: FontWeight.normal)))
                : IconButton(
                    onPressed: () {
                      DialogHelper.searchDialog(context, _localizations, () {
                        startImageRecognition(searchImage);
                      }, () {
                        startImageRecognition(searchText);
                      });
                    },
                    icon: const Icon(
                      Icons.camera_alt,
                    ),
                  ),
            textEditingController.text.isNotEmpty
                ? IconButton(
                    onPressed: () {
                      Helper.hideSoftKeyBoard();
                      textEditingController.text = "";
                      searchModel = null;
                      searchScreenBloc?.add(InitialSearchSuggestionEvent());
                    },
                    icon: const Icon(
                      Icons.close,
                    ),
                  )
                : IconButton(
                    onPressed:
                        // If not yet listening for speech start, otherwise stop
                        _speechToText.isNotListening
                            ? _startListening
                            : _stopListening,
                    icon: Icon(
                      (_isListening) ? Icons.mic_off : Icons.mic,
                    ),
                  )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Visibility(
                visible: isLoading,
                child:  LinearProgressIndicator(
                  backgroundColor: Theme.of(context).colorScheme.onPrimary,
                  valueColor: AlwaysStoppedAnimation(AppColors.white),
                ),
              ),
              Visibility(
                visible: !isLoading,
                child: (searchModel?.products?.isNotEmpty ?? false)
                    ? suggestionList(searchModel, context, _localizations)
                    : Padding(
                        padding: const EdgeInsets.all(AppSizes.imageRadius),
                        child: Center(
                          child: Text(_localizations
                                  ?.translate(AppStringConstant.noResult) ??
                              ''),
                        ),
                      ),
              )
            ],
          ),
        ));
  }

  String searchImage = "imageSearch";
  String searchText = "textSearch";
  var methodChannel = const MethodChannel(AppConstant.channelName);

  Future<String> startImageRecognition(String type) async {
    try {
      String data = "";
      if (Platform.isAndroid) {
        data = await methodChannel.invokeMethod(type);
      } else if (Platform.isIOS) {
        data = await methodChannel.invokeMethod("mlKit", type);
      }
      Navigator.pop(context);
      textEditingController.text = data;
      searchScreenBloc?.add(SearchSuggestionEvent(data));
      searchScreenBloc?.emit(SearchInitialState());
      return data;
    } on PlatformException catch (e) {
      return "Failed to Invoke: '${e.message}'.";
    }
  }
}

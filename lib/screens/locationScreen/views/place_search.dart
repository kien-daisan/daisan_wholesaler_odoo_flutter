import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/helper/alert_message.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/models/GooglePlaceModel.dart';
import 'package:flutter_project_structure/screens/locationScreen/bloc/location_bloc.dart';
import 'package:flutter_project_structure/screens/locationScreen/bloc/location_event.dart';
import 'package:flutter_project_structure/screens/locationScreen/bloc/location_state.dart';
import 'package:flutter_project_structure/utils/helper.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceSearch extends StatefulWidget {
  const PlaceSearch({Key? key}) : super(key: key);

  @override
  _PlaceSearchState createState() => _PlaceSearchState();
}

class _PlaceSearchState extends State<PlaceSearch> {
  TextEditingController searchController = TextEditingController();
  AppLocalizations? _localizations;
  GooglePlaceModel? placeModel;
  bool isLoading = false;
  LocationScreenBloc? _locationScreenBloc;

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _locationScreenBloc = context.read<LocationScreenBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationScreenBloc, LocationScreenState>(
      builder: (context, state) {
        if (state is LocationScreenLoadingState) {
          isLoading = true;
        } else if (state is SearchPlaceSuccessState) {
          isLoading = false;
          placeModel = state.data;
          print("length -------${placeModel?.results?.length}");
        } else if (state is SearchPlaceErrorState) {
          isLoading = false;
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            AlertMessage.showError(state.message, context);
          });
        } else if (state is LocationScreenInitialState) {
           isLoading = false;
          placeModel = null;
        }
        return _buildUI();
      },
    );
  }

  Widget _buildUI() {
    return Scaffold(
        appBar: AppBar(
          // backgroundColor: Theme.of(context).cardColor,
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
            autofocus: true,
            controller: searchController,
            onChanged: (searchKey) {
              print(searchKey);
              if(searchKey.isNotEmpty){
                _locationScreenBloc?.add(SearchPlaceEvent(searchKey));
              }
              else{
                _locationScreenBloc?.add(SearchPlaceInitialEvent());
              }
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText:
                  _localizations?.translate(AppStringConstant.search) ?? '',
              hintStyle: Theme.of(context).textTheme.subtitle2?.copyWith(
                    fontWeight: FontWeight.normal,
                  ),
            ),
            style: Theme.of(context).textTheme.subtitle2,
            cursorColor: Theme.of(context).colorScheme.onPrimary,
          ),
          actions: [
            searchController.text.isNotEmpty
                ? IconButton(
                    onPressed: () {
                      Helper.hideSoftKeyBoard();
                      searchController.text = "";
                      placeModel = null;
                      _locationScreenBloc?.add(SearchPlaceInitialEvent());
                    },
                    icon: const Icon(
                      Icons.close,

                    ),
                  )
                : Container()
          ],
        ),
        body: Column(
          children: [
            ((placeModel != null))
                ? (placeModel?.results?.isNotEmpty ?? false)
                ? Expanded(
                  child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: placeModel?.results?.length ?? 0,
                  itemBuilder: (context, index) => Container(
                      padding: const EdgeInsets.all(AppSizes.imageRadius),
                      margin: const EdgeInsets.all(AppSizes.imageRadius),
                      child: ListTile(
                        onTap: (){
                          Navigator.pop(context, LatLng(placeModel?.results?[index].geometry?.location?.lat ?? 0.0, placeModel?.results?[index].geometry?.location?.lng ?? 0.0));
                        },
                        title: Text(
                          placeModel?.results?[index].name ?? '',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        subtitle: Text(
                          placeModel?.results?[index].formattedAddress ?? '',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      )
                  )),
                )
                : Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSizes.imageRadius),
                child: Text(
                  _localizations?.translate(AppStringConstant.noResult) ??
                      '',
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ),
            )
                :
            Expanded(
              child: GestureDetector(
                onTap: (){Navigator.pop(context);},
              ),
            )
          ],
        )
    );
  }
}

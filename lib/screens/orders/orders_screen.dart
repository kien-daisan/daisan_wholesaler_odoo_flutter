import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/constants/route_constant.dart';
import 'package:flutter_project_structure/customWidgtes/common_tool_bar.dart';
import 'package:flutter_project_structure/customWidgtes/lottie_animation.dart';
import 'package:flutter_project_structure/helper/alert_message.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/helper/loader.dart';
import 'package:flutter_project_structure/helper/open_bottom_model_sheet.dart';
import 'package:flutter_project_structure/models/OrderModel.dart';
import 'package:flutter_project_structure/screens/orders/bloc/order_screen_bloc.dart';
import 'package:flutter_project_structure/screens/orders/bloc/order_screen_events.dart';
import 'package:flutter_project_structure/screens/orders/bloc/order_screen_state.dart';
import 'package:flutter_project_structure/screens/orders/views/order_item_list.dart';
import 'package:flutter_project_structure/screens/orders/views/order_main_view.dart';

class OrderScreen extends StatefulWidget {
  OrderScreen(this.isFromDashboard, {Key? key}) : super(key: key);
  bool isFromDashboard = false;

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final ScrollController _scrollController = ScrollController();
  AppLocalizations? _localizations;
  OrderScreenBloc? _orderScreenBloc;
  bool isLoading = false;
  bool isFromPagination = false;
  OrderModel? orderList;
  List<RecentOrders> recentOrders = [];
  int offset = 0;

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _orderScreenBloc = context.read<OrderScreenBloc>();
    _orderScreenBloc
        ?.add(OrderScreenDataFetchEvent(0, (widget.isFromDashboard) ? 5 : 10));
    _scrollController.addListener(() {
      if (!widget.isFromDashboard) paginationFunction();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (widget.isFromDashboard)
          ? null
          : commonToolBar(
              _localizations?.translate(AppStringConstant.myOrder) ?? '',
              context),
      body: BlocBuilder<OrderScreenBloc, OrderScreenState>(
          builder: (context, currentState) {
        if (currentState is OrderScreenInitial) {
          if (!isFromPagination) {
            isLoading = true;
          }
        } else if (currentState is OrderScreenSuccess) {
          isLoading = false;
          isFromPagination = false;
          orderList = currentState.orders;
          if (offset == 0) {
            recentOrders = orderList?.recentOrders ?? [];
          } else {
            recentOrders.addAll(orderList?.recentOrders ?? []);
          }
        } else if (currentState is OrderScreenError) {
          isLoading = false;
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            AlertMessage.showError(currentState.message, context);
          });
        } else if (currentState is OrderDetailsSuccess) {
          isLoading = false;
          Future.delayed(Duration.zero, () {
            if ((currentState.data.items?.length ?? 0) > 1) {
              orderItemList(
                  context, currentState.data.items ?? [], _localizations);
            } else {
              reviewBottomModalSheet(
                  context,
                  currentState.data.items?.first.name ?? '',
                  currentState.data.items?.first.thumbNail ?? '',
                  currentState.data.items?.first.templateId ?? 0);
            }
          });
        }
        return _buildUI();
      }),
    );
  }

  Widget _buildUI() {
    return Stack(
      children: [
        if (recentOrders.isNotEmpty)
          orderMainView(context, recentOrders, _localizations, (url) {
            _orderScreenBloc?.add(OrderDetailsFetchEvent(url));
          }, _scrollController,
              scrollPhysics: widget.isFromDashboard
                  ? const AlwaysScrollableScrollPhysics()
                  : const AlwaysScrollableScrollPhysics()),
        Visibility(
          visible: (recentOrders.isEmpty && (!isLoading)),
          child: Center(
            child: lottieAnimation(
                context,
                "lib/assets/lottie/empty_order_list.json",
                _localizations?.translate(AppStringConstant.noOrder) ?? "",
                _localizations?.translate(AppStringConstant.noOrderMessage) ??
                    "",
                _localizations?.translate(AppStringConstant.continueShopping) ??
                    '', () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(navBar, (route) => false);
            }),
          ),
        ),
        Visibility(visible: isLoading, child: Loader())
      ],
    );
  }

  void paginationFunction() {
    print("sdasdas");
    if (_scrollController.offset ==
            _scrollController.position.maxScrollExtent &&
        (orderList?.tcount ?? 0) != recentOrders.length) {
      setState(() {
        if ((offset + 10) < (orderList?.tcount ?? 0)) {
          offset += 10;
          if (!(widget.isFromDashboard)) {
            _orderScreenBloc?.add(OrderScreenDataFetchEvent(offset, 10));
          }
          isFromPagination = true;
        }
      });
    }
  }
}

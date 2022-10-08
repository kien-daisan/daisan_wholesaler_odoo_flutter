import 'package:flutter/material.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/customWidgtes/common_banner_view.dart';
import 'package:flutter_project_structure/customWidgtes/common_tool_bar.dart';
import 'package:flutter_project_structure/helper/image_view.dart';

Widget collapseAppBar(BuildContext context,Widget background,  Widget body,
    {TabBar? tabBar}) {
  return NestedScrollView(
      floatHeaderSlivers: false,
      physics: const BouncingScrollPhysics(),
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            pinned: true,
            floating: false,
            elevation: 0,
            toolbarHeight: 0,
            collapsedHeight: null,
            automaticallyImplyLeading: false,
            expandedHeight: AppSizes.height * .4,
            flexibleSpace:
            FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                background: background),
            titleSpacing: 0,
            primary: false,
          ),
        ];
      },
      body: Scaffold(appBar: tabBar, body: body));
}


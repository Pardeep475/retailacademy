import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:retail_academy/app/knowledge/knowledge_navigation/knowledge_navigation.dart';
import 'package:retail_academy/app/knowledge/page/knowledge_screen.dart';

import '../page/retail_reels_content_screen.dart';
import '../page/retail_reels_screen.dart';
import 'retail_reels_navigation.dart';



class RetailReelsWrapper extends StatelessWidget {
  const RetailReelsWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('NAVIGATOR_DEBUG:-  build');
    return Navigator(
      key: Get.nestedKey(RetailReelsNavigation.id),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case RetailReelsNavigation.retailsHome:
            {
              return GetPageRoute(
                routeName: RetailReelsNavigation.retailsHome,
                page: () => const RetailReelsScreen(),
              );
            }
          case RetailReelsNavigation.retailReelsContentScreen:
            {
              //arguments
              var arg = settings.arguments as Map;
              return GetPageRoute(
                routeName: RetailReelsNavigation.retailReelsContentScreen,
                page: () => RetailReelsContentScreen(
                  title: arg["title"],
                  categoryId: arg["categoryId"],
                ),
              );
            }

          default:
            {
              return GetPageRoute(
                routeName: RetailReelsNavigation.retailsHome,
                page: () => const KnowledgeScreen(),
              );
            }
        }
      },
    );
  }
}

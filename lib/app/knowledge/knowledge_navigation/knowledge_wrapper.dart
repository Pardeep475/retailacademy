import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:retail_academy/app/knowledge/knowledge_navigation/knowledge_navigation.dart';
import 'package:retail_academy/app/knowledge/page/knowledge_screen.dart';
import '../page/fun_facts_and_master_class_content_screen.dart';
import '../page/fun_facts_and_master_class_detail_screen.dart';
import '../page/fun_facts_and_master_class_screen.dart';
import '../page/pod_cast_content_screen.dart';
import '../page/pod_cast_screen.dart';
import '../page/quiz_master_screen.dart';
import '../page/whats_hot_blog_content_screen.dart';
import '../page/whats_hot_blog_screen.dart';

class KnowledgeWrapper extends StatelessWidget {
  const KnowledgeWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('NAVIGATOR_DEBUG:-  build');
    return Navigator(
      key: Get.nestedKey(KnowledgeNavigation.id),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case KnowledgeNavigation.knowledgeHome:
            {
              return GetPageRoute(
                routeName: KnowledgeNavigation.knowledgeHome,
                page: () => const KnowledgeScreen(),
              );
            }
          case KnowledgeNavigation.funFactsMasterClassScreen:
            {
              //arguments
              var arg = settings.arguments as Map;
              return GetPageRoute(
                routeName: KnowledgeNavigation.funFactsMasterClassScreen,
                page: () => FunFactsAndMasterClassScreen(
                  title: arg["title"],
                  color: arg["color"],
                  fileId: arg["fileId"],
                ),
              );
            }
          case KnowledgeNavigation.funFactsAndMasterClassContentScreen:
            {
              var arg = settings.arguments as Map;
              return GetPageRoute(
                routeName:
                    KnowledgeNavigation.funFactsAndMasterClassContentScreen,
                page: () => FunFactsAndMasterClassContentScreen(
                  fileId: arg['fileId'],
                  fileName: arg['title'],
                ),
              );
            }
          case KnowledgeNavigation.funFactsAndMasterClassDetailScreen:
            {
              var arg = settings.arguments as Map;
              return GetPageRoute(
                routeName:
                    KnowledgeNavigation.funFactsAndMasterClassDetailScreen,
                page: () => FunFactsAndMasterClassDetailScreen(
                  fileId: arg['fileId'],
                  quizId: arg['quizId'],
                  quizName: arg['quizName'],
                ),
              );
            }
          case KnowledgeNavigation.quizMasterScreen:
            {
              var arg = settings.arguments as Map;
              return GetPageRoute(
                routeName: KnowledgeNavigation.quizMasterScreen,
                page: () => QuizMasterScreen(
                  color: arg['color'],
                ),
              );
            }

          case KnowledgeNavigation.whatsHotBlogScreen:
            {
              return GetPageRoute(
                routeName: KnowledgeNavigation.whatsHotBlogScreen,
                page: () => const WhatsHotBlogScreen(),
              );
            }
          case KnowledgeNavigation.whatsHotBlogContentScreen:
            {
              var arg = settings.arguments as Map;
              return GetPageRoute(
                routeName: KnowledgeNavigation.whatsHotBlogContentScreen,
                page: () => WhatsHotBlogContentScreen(
                  title: arg['title'],
                  categoryId: arg['categoryId'],
                  description: arg['description'],
                ),
              );
            }
          case KnowledgeNavigation.podCastScreen:
            {
              return GetPageRoute(
                routeName: KnowledgeNavigation.podCastScreen,
                page: () => const PodCastScreen(),
              );
            }
          case KnowledgeNavigation.podCastContentScreen:
            {
              var arg = settings.arguments as Map;
              return GetPageRoute(
                routeName: KnowledgeNavigation.podCastContentScreen,
                page: () => PodCastContentScreen(
                  item: arg['item'],
                ),
              );
            }

          default:
            {
              return GetPageRoute(
                routeName: KnowledgeNavigation.knowledgeHome,
                page: () => const KnowledgeScreen(),
              );
            }
        }
      },
    );
  }
}

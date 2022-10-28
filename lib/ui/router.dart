import 'package:book_with_cubit/data/model/book/book_model.dart';
import 'package:book_with_cubit/ui/tabs/home_page/sub_screens/patch_screen.dart';
import 'package:book_with_cubit/ui/tabs/tabs.dart';
import 'package:book_with_cubit/utils/constants.dart';
import 'package:flutter/material.dart';

class MyRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case splashPage:
      //   return MaterialPageRoute(builder: (_) => SplashPage());
      case homePage:
        return MaterialPageRoute(builder: (_) => TabsPage());
      case patchPage:
        return MaterialPageRoute(builder: (_) => PatchScreen(bookModel: settings.arguments as BookModel,));
      // case languagesPage:
      //   return MaterialPageRoute(builder: (_) => LanguagesPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
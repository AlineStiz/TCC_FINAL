import 'package:flutter/material.dart';
import 'package:projeto_tcc/models/article.dart';
import 'package:projeto_tcc/pages/add_article/add_article.dart';
import 'package:projeto_tcc/pages/details_page/details_page.dart';
import 'package:projeto_tcc/pages/edit_article/edit_article.dart';
import 'package:projeto_tcc/pages/forgot_password_page/forgot_password_page.dart';
import 'package:projeto_tcc/pages/home_page/home_page.dart';
import 'package:projeto_tcc/pages/login_page/login_page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  final args = settings.arguments;
  switch (settings.name) {
    case '/':
      return _createRoute(const LoginPage());
    case '/home':
      return _createRoute(const HomePage());
    case '/add':
      return _createRoute(const AddArticlePage());
    case '/edit':
      return _createRoute(const EditArticlePage());
    case '/forgot':
      return _createRoute(const ForgotPasswordPage());
    case '/details':
      if (args is Article) {
        return _createRoute(
          DetailsPage(
            article: args,
          ),
        );
      }
      return _errorRoute();
    default:
      return _errorRoute();
  }
}

Route _createRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionDuration: const Duration(milliseconds: 700),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(-1, 0);
      const end = Offset.zero;
      const curve = Curves.ease;
      final tween = Tween(begin: begin, end: end);
      final curvedAnimation = CurvedAnimation(
        parent: animation,
        curve: curve,
      );

      return SlideTransition(
        position: tween.animate(curvedAnimation),
        child: child,
      );
    },
  );
}

Route<dynamic> _errorRoute() {
  return MaterialPageRoute(
    builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    },
  );
}

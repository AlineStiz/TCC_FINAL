import 'package:flutter/material.dart';
import 'package:projeto_tcc/controller/add_article_controller.dart';
import 'package:projeto_tcc/controller/auth_service.dart';
import 'package:projeto_tcc/controller/details_article_controller.dart';
import 'package:projeto_tcc/controller/edit_article_controller.dart';
import 'package:projeto_tcc/helpers/constants.dart';
import 'package:projeto_tcc/helpers/routes.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthService(),
        
        ),
        ChangeNotifierProvider(
          create: (context) => AddController(),
        ),
        ChangeNotifierProvider(
          create: (context) => EditController(),
        ),
        ChangeNotifierProvider(
          create: (context) => DetailsController(),
        ),
        
      ],
      child: MaterialApp(
        title: 'Repositório de TCC',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: kBackGroundColor,
          scaffoldBackgroundColor: kBackGroundColor,
          appBarTheme: const AppBarTheme(
            elevation: 0,
            color: kBackGroundColor,
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          focusColor: kGreyColor,
          textSelectionTheme:
              const TextSelectionThemeData(cursorColor: kGreyColor),
        ),
        initialRoute: '/home',
        onGenerateRoute: generateRoute,
      ),
    );
  }
}

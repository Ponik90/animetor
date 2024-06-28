import 'package:animetor_app/screen/home/provider/home_provider.dart';
import 'package:animetor_app/utils/app_routes.dart';
import 'package:animetor_app/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: HomeProvider(),
        ),
      ],
      child: Consumer<HomeProvider>(
        builder: (context, value, child) {
          value.changeTheme();
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            routes: screen,
            themeMode: value.isTheme == true ? ThemeMode.light : ThemeMode.dark,
          );
        },
      ),
    ),
  );
}

import 'package:animetor_app/screen/detail/view/detail_screen.dart';
import 'package:animetor_app/screen/favorite/view/favorite_screen.dart';
import 'package:animetor_app/screen/home/view/home_screen.dart';
import 'package:animetor_app/screen/splash/view/splash_screen.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> screen = {
  '/': (context) => const SplashScreen(),
  'home': (context) => const HomeScreen(),
  'detail': (context) => const DetailScreen(),
  'fav': (context) => const FavoriteScreen(),
};

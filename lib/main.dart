import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'features/presentation/modules/login/bindings/login_binding.dart';
import 'features/presentation/modules/login/views/login_view.dart';
import 'features/presentation/modules/home/views/home_views.dart';
import 'features/presentation/modules/hall_detail/bindings/hall_detail_binding.dart';
import 'features/presentation/modules/hall_detail/views/hall_detail_view.dart';
import 'features/presentation/modules/place_detail/bindings/place_detail_bindings.dart';
import 'features/presentation/modules/place_detail/views/place_detail_view.dart';
import 'features/presentation/modules/search/bindings/search_bindings.dart';
import 'features/presentation/modules/search/views/search_page.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Login App',
      debugShowCheckedModeBanner: false,
      initialBinding: LoginBinding(),
      getPages: [
        GetPage(
          name: '/home',
          page: () => const HomePage(),
        ),
        GetPage(
          name: '/details',
          page: () => const PlaceDetailPage(),
          binding: PlaceDetailBinding(),
        ),
        GetPage(
          name: '/hall-details',
          page: () => const HallDetailPage(),
          binding: HallDetailBinding(),
        ),
        GetPage(
          name: '/search',
          page: () => const SearchPage(),
          binding: SearchBinding(),
        ),
      ],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        textTheme: GoogleFonts.alexandriaTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: const LoginView(),
    );
  }
}
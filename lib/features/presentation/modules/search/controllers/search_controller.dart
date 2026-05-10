
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/popular_models.dart';

class SearchingController extends GetxController {
  static final SearchController instance = Get.find();
  final searchController = TextEditingController();
  static const List<RecentSearch> recentSearches = [
    RecentSearch(text: 'مساحة عمل مشتركة'),
    RecentSearch(text: 'قاعة اجتماعات'),
    RecentSearch(text: 'دورة التسويق الإلكتروني'),
    RecentSearch(text: 'ورشة تجربة المستخدم'),
  ];


  
  static const List<Map<String, String>> recommendedPlaces = [
    {'name': 'المنصورة', 'image': 'images/computing_thumb.png'},
    {'name': 'المنصورة', 'image': 'images/mekars_thumb.png'},
    {'name': 'المنصورة', 'image': 'images/mekars_thumb.png'},
    {'name': 'المنصورة', 'image': 'images/computing_thumb.png'},
    {'name': 'المنصورة', 'image': 'images/mekars_thumb.png'},
    {'name': 'المنصورة', 'image': 'images/computing_thumb.png'},
  ];
  

     
     static const List<EventYouMightLike> events = [
      EventYouMightLike(
        title: 'تعلم أساسيات تصميم تجربة\nالمستخدم',
        venue: 'المحطة',
        dateText: '6 آذار | 7:00 م',
        imagePath: 'images/Rectangle2.png',
      ),
      EventYouMightLike(
        title: 'كيف تصبح مطور تطبيقات\nموبايل محترف ؟',
        venue: 'كوميونك',
        dateText: '8 آذار | 6:30 م',
        imagePath: 'images/img2.png',
      ),
    ];  

}
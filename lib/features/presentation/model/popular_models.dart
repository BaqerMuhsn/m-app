import 'package:flutter/material.dart';

class PopularCategory {
  final String label;
  final IconData icon;

  const PopularCategory({required this.label, required this.icon});
}

class PopularEvent {
  final String title;
  final String venue;
  final String dateMonth;
  final String dateDay;
  final String? imageUrl;
  final String? venueLogoAsset;

  const PopularEvent({
    required this.title,
    required this.venue,
    required this.dateMonth,
    required this.dateDay,
    this.imageUrl,
    this.venueLogoAsset,
  });
}



class UpcomingEvent {
  final String title;
  final String venue;
  final String dateMonth;
  final String dateDay;
  final String? imageUrl;
  final String? venueLogoAsset;

  const UpcomingEvent({
    required this.title,
    required this.venue,
    required this.dateMonth,
    required this.dateDay,
    this.imageUrl,
    this.venueLogoAsset,
  });
}








 class PopularPlace {
  final String name;
  final String locationLabel;
  final String imagePath;
  final String logoPath;
  final String rating;
  final String halls;
  final String events;

  const PopularPlace({
    required this.name,
    required this.locationLabel,
    required this.imagePath,
    required this.logoPath,
    required this.rating,
    required this.halls,
    required this.events,
  });
}



class HallAmenity {
  final IconData icon;
  final String label;

  const HallAmenity({required this.icon, required this.label});
}

class HallWorkspaceItem {
  final String imagePath;
  final String title;
  final String details;

  const HallWorkspaceItem({
    required this.imagePath,
    required this.title,
    required this.details,
  });
}


class RecentSearch {
  final String text;

  const RecentSearch({required this.text});
}


class EventYouMightLike {
  final String title;
  final String venue;
  final String dateText;
  final String imagePath;

  const EventYouMightLike({required this.title, required this.venue, required this.dateText, required this.imagePath});
}
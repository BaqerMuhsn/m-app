import 'package:flutter/material.dart';
import 'package:login_app/features/presentation/widgets/Recent_searches.dart';
import 'package:login_app/features/presentation/widgets/Recommended_places.dart';
import 'package:login_app/features/presentation/widgets/events_you_might_like.dart';
import 'package:login_app/features/presentation/model/warning_type.dart';
import 'package:login_app/features/presentation/widgets/warning_search.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class SearchContent extends StatelessWidget {
  const SearchContent({super.key});
 
  static const List<WarningType> warningTypes = [
    WarningType(
      title: 'اتصال الإنترنت مفقود', 
      description: 'يبدو أنك غير متصل بالإنترنت. تحقق من اتصالك وحاول مرة أخرى.', 
      imagePath: 'images/Illustrations.svg', // Ensure the path matches pubspec.yaml
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ConnectivityResult>>(
      stream: Connectivity().onConnectivityChanged,
      builder: (context, snapshot) {
        final results = snapshot.data;
        if (results != null && results.contains(ConnectivityResult.none)) {
          return Column(
            children: [
              SizedBox(height: 100,),
             Center(
              child: WarningSearch(warningType: warningTypes.first),
            ),]
          );
        }
        return const Column(
          children: [
            SearchPageContent(),
            RecommendedPlaces(),
            EventsYouMightLike(),
          ],
        );
      },
    );
  }
}
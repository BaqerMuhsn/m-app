import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/gradient_scaffold.dart';
import 'search_view.dart';

/// Full-screen search route (pushed from home via [Get.toNamed]).
class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.paddingOf(context).top;
    final bottomPad = MediaQuery.viewPaddingOf(context).bottom + 24;

    return GradientScaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16, topInset + 16, 16, bottomPad),
        child: const SearchContent(),
      ),
    );
  }
}

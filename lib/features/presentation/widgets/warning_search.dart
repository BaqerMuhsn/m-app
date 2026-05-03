import 'package:flutter/material.dart';
import 'package:login_app/features/presentation/model/warning_type.dart'; // Adjust import path
import 'package:flutter_svg/flutter_svg.dart';
class WarningSearch extends StatelessWidget {
  final WarningType warningType;
  
  const WarningSearch({super.key, required this.warningType});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            warningType.imagePath,
            height: 150, // Constrain the image height instead of the container
          ),
          const SizedBox(height: 20),
          Text(
            warningType.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0D1B3E),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            warningType.description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
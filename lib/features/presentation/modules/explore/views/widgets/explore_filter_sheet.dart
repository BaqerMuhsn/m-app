import 'package:flutter/material.dart';

import '../../../../model/iraq_cities.dart';
import '../../../../widgets/app_action_buttons.dart';

class ExploreFilterSheet extends StatefulWidget {
  const ExploreFilterSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const ExploreFilterSheet(),
    );
  }

  @override
  State<ExploreFilterSheet> createState() => _ExploreFilterSheetState();
}

class _ExploreFilterSheetState extends State<ExploreFilterSheet> {
  String _selectedCity = 'بغداد';
  late final TextEditingController _cityMenuController;

  static const _tags = [
    'غرفة اجتماعاتك',
    'مساحة عمل',
    'قاعة للحجز',
    'مكان للدراسة',
  ];

  static const _cityInputTheme = InputDecorationTheme(
    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
    filled: true,
    fillColor: Color(0xFFF7F9FC),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(14)),
      borderSide: BorderSide(color: Color(0xFFE3E8EE)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(14)),
      borderSide: BorderSide(color: Color(0xFFE3E8EE)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(14)),
      borderSide: BorderSide(color: Color(0xFF3A7BD5), width: 1.5),
    ),
  );

  @override
  void initState() {
    super.initState();
    _cityMenuController = TextEditingController(text: _selectedCity);
  }

  @override
  void dispose() {
    _cityMenuController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 18),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
              Center(
                child: Container(
                  width: 54,
                  height: 5,
                  decoration: BoxDecoration(
                    color: const Color(0xFF9AA5B1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Expanded(
                    child: Center(
                      child: Text(
                        'تصفية الأماكن',
                        style: TextStyle(
                          color: Color(0xFF102A43),
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close, color: Color(0xFF6B7785)),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Align(
                alignment: AlignmentDirectional.centerEnd,
                child: Text(
                  'الموقع',
                  style: TextStyle(
                    color: Color(0xFF102A43),
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              LayoutBuilder(
                builder: (context, constraints) {
                  return Directionality(
                    textDirection: TextDirection.rtl,
                    child: DropdownMenu<String>(
                      width: constraints.maxWidth,
                      menuHeight: 220,
                      controller: _cityMenuController,
                      initialSelection: _selectedCity,
                      enableFilter: false,
                      requestFocusOnTap: true,
                      textAlign: TextAlign.right,
                      dropdownMenuEntries: [
                        for (final city in iraqCities)
                          DropdownMenuEntry<String>(
                            value: city,
                            label: city,
                          ),
                      ],
                      textStyle: const TextStyle(
                        color: Color(0xFF102A43),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      inputDecorationTheme: _cityInputTheme,
                      menuStyle: MenuStyle(
                        alignment: AlignmentDirectional.topStart,
                        minimumSize: WidgetStateProperty.all(
                          Size(constraints.maxWidth, 0),
                        ),
                        maximumSize: WidgetStateProperty.all(
                          Size(constraints.maxWidth, 220),
                        ),
                      ),
                      onSelected: (city) {
                        if (city == null) return;
                        setState(() {
                          _selectedCity = city;
                          _cityMenuController.value = TextEditingValue(
                            text: city,
                            selection: TextSelection.collapsed(offset: city.length),
                          );
                        });
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              const Align(
                alignment: AlignmentDirectional.centerEnd,
                child: Text(
                  'تبحث عن',
                  style: TextStyle(
                    color: Color(0xFF102A43),
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                alignment: WrapAlignment.end,
                children: [
                  for (final tag in _tags)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(color: const Color(0xFFE0E6ED)),
                        color: Colors.white,
                      ),
                      child: Text(
                        tag,
                        style: const TextStyle(
                          color: Color(0xFF7B8CA1),
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: AppOutlineActionButton(
                      label: 'مسح الفلتر',
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AppPrimaryGradientButton(
                      label: 'تطبيق',
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                ],
              ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

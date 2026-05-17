import 'package:flutter/material.dart';

import '../../../../widgets/app_action_buttons.dart';

class LeaveReviewSheet extends StatefulWidget {
  const LeaveReviewSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const LeaveReviewSheet(),
    );
  }

  @override
  State<LeaveReviewSheet> createState() => _LeaveReviewSheetState();
}

class _LeaveReviewSheetState extends State<LeaveReviewSheet> {
  int _rating = 0;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    final canSubmit = _rating > 0;

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
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 18),
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
                      const Expanded(child: SizedBox()),
                      const Expanded(
                        child: Center(
                          child: Text(
                            'شاركنا رأيك',
                            style: TextStyle(
                              color: Color(0xFF102A43),
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: const Icon(
                              Icons.close,
                              color: Color(0xFF6B7785),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'قيّم هذا المكان بناءً على تجربتك أو انطباعك العام،\nوساعد الآخرين في اكتشاف الأفضل.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF7B8CA1),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Directionality(
                  textDirection: TextDirection.rtl,
                  child: Row(
                    
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      final starIndex = index + 1;
                      final selected = starIndex <= _rating;
                      return IconButton(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        constraints: const BoxConstraints(),
                        onPressed: () => setState(() => _rating = starIndex),
                        icon: Icon(
                          selected ? Icons.star_rounded : Icons.star_border_rounded,
                          color: selected
                              ? const Color(0xFFFFB800)
                              : const Color(0xFFB8C4CE),
                          size: 36,
                        ),
                      );
                    }),
                  )),
                  const SizedBox(height: 28),
                  Row(
                    children: [
                      Expanded(
                        child: canSubmit
                            ? AppPrimaryGradientButton(
                                label: 'أرسال',
                                onPressed: () => Navigator.of(context).pop(),
                              )
                            : _DisabledSendButton(onPressed: null),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: AppOutlineActionButton(
                          label: 'ليس الآن',
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

class _DisabledSendButton extends StatelessWidget {
  const _DisabledSendButton({this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: const Color(0xFFE8EDF2),
          disabledBackgroundColor: const Color(0xFFE8EDF2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
        ),
        child: const Text(
          'أرسال',
          style: TextStyle(
            color: Color(0xFFB0BEC5),
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

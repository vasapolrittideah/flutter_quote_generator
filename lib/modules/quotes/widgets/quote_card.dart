import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_quote_generator/data/models/quote_model.dart';
import 'package:flutter_quote_generator/global/themes/app_theme.dart';

class QuoteCard extends StatelessWidget {
  const QuoteCard({super.key, required this.quote});

  final QuoteModel quote;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Quote
        Text(
          '"${quote.quote}"',
          textAlign: TextAlign.center,
          style: context.theme.text.headlineSmall.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 16.h),
        // Author
        Text(
          '- ${quote.author} -',
          textAlign: TextAlign.center,
          style: context.theme.text.bodySmall.copyWith(
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }
}

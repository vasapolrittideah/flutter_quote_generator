import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter_quote_generator/global/themes/app_theme.dart';
import 'package:flutter_quote_generator/global/widgets/icon_button.dart';
import '../../../global/widgets/loading_spinner.dart';
import '../bloc/local/quote_local_bloc.dart';
import '../widgets/quote_card.dart';

@RoutePage()
class FavoriteQuotesPage extends HookWidget {
  const FavoriteQuotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final quoteLocalBloc = BlocProvider.of<QuoteLocalBloc>(context);

    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<QuoteLocalBloc, QuoteLocalState>(
          builder: (context, state) {
            return state.map(
              initial: (_) {
                return const Center(child: LoadingSpinner());
              },
              loading: (_) {
                return const Center(child: LoadingSpinner());
              },
              loaded: (data) {
                return CarouselSlider(
                  items: data.quotes.mapIndexed((i, quote) {
                    return Builder(builder: (context) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${i + 1}.',
                              textAlign: TextAlign.center,
                              style: context.theme.text.displaySmall.copyWith(
                                color: context.theme.color.primary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 6.h),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.r),
                                color: context.theme.color.surface,
                              ),
                              child: Text(
                                'ID: ${quote.id}',
                                textAlign: TextAlign.center,
                                style: context.theme.text.bodySmall,
                              ),
                            ),
                            SizedBox(height: 6.h),
                            QuoteCard(quote: quote),
                            SizedBox(height: 10.h),
                            CustomIconButton(
                              icon: FontAwesomeIcons.trash,
                              color: context.theme.color.onBackground
                                  .withOpacity(.3),
                              onPressed: () {
                                quoteLocalBloc
                                    .add(QuoteLocalEvent.favoriteQuoteDeleted(
                                  quote,
                                ));
                              },
                            ),
                          ],
                        ),
                      );
                    });
                  }).toList(),
                  options: CarouselOptions(
                    autoPlay: false,
                    height: MediaQuery.of(context).size.height,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: false,
                    enlargeFactor: 0,
                    viewportFraction: 1,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

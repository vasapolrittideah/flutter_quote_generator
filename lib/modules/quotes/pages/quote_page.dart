import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter_quote_generator/global/themes/app_theme.dart';
import 'package:flutter_quote_generator/global/widgets/icon_button.dart';
import 'package:flutter_quote_generator/global/widgets/loading_spinner.dart';
import 'package:flutter_quote_generator/modules/quotes/bloc/local/quote_local_bloc.dart';
import 'package:flutter_quote_generator/modules/quotes/widgets/quote_card.dart';
import '../bloc/remote/quote_remote_bloc.dart';

@RoutePage()
class QuotePage extends HookWidget {
  const QuotePage({super.key});

  @override
  Widget build(BuildContext context) {
    final favorite = useState(false);
    final quoteRemoteBloc = BlocProvider.of<QuoteRemoteBloc>(context);
    final quoteLocalBloc = BlocProvider.of<QuoteLocalBloc>(context);

    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<QuoteRemoteBloc, QuoteRemoteState>(
          builder: (context, quoteRemoteState) {
            return quoteRemoteState.map(
              initial: (_) {
                return const Center(
                  child: LoadingSpinner(
                      key: Key('QuoteRemoteStateLoadingSpinner')),
                );
              },
              loading: (_) {
                return const Center(
                  child: LoadingSpinner(
                      key: Key('QuoteRemoteStateLoadingSpinner')),
                );
              },
              failure: (_) {
                return const SizedBox();
              },
              success: (data) {
                final newQuote = data.quote;

                return CardSwiper(
                  padding: EdgeInsets.zero,
                  threshold: 100,
                  cardBuilder: (
                    context,
                    index,
                    percentThresholdX,
                    percentThresholdY,
                  ) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          QuoteCard(quote: newQuote),
                          SizedBox(height: 10.h),
                          BlocConsumer<QuoteLocalBloc, QuoteLocalState>(
                            listener: (context, quoteLocalState) {
                              quoteLocalState.whenOrNull(
                                  loaded: (favoriteQuotes) {
                                for (var favoriteQuote in favoriteQuotes) {
                                  if (favoriteQuote.id == newQuote.id) {
                                    favorite.value = true;
                                    return;
                                  }
                                }

                                favorite.value = false;
                              });
                            },
                            builder: (context, quoteLocalState) {
                              return CustomIconButton(
                                key: const Key('FavoriteQuoteIconButton'),
                                loadingSpinnerKey:
                                    const Key('QuoteLocalStateLoadingSpinner'),
                                icon: favorite.value
                                    ? FontAwesomeIcons.solidHeart
                                    : FontAwesomeIcons.heart,
                                color: favorite.value
                                    ? context.theme.color.success
                                    : context.theme.color.onBackground,
                                onPressed: () {
                                  favorite.value = !favorite.value;
                                  quoteLocalBloc
                                      .add(QuoteLocalEvent.favoriteQuoteSaved(
                                    newQuote,
                                  ));
                                },
                                isLoading: quoteLocalState.maybeWhen(
                                  loaded: (_) => false,
                                  orElse: () => true,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                  cardsCount: 1,
                  numberOfCardsDisplayed: 1,
                  allowedSwipeDirection: const AllowedSwipeDirection.all(),
                  onSwipe: (previousIndex, currentIndex, direction) {
                    favorite.value = false;
                    quoteRemoteBloc
                        .add(const QuoteRemoteEvent.newQuoteRequested());
                    return true;
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}

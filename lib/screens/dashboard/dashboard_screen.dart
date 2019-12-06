import 'package:amplitude_flutter/amplitude_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:remessa_app/app/bloc/bloc.dart';
import 'package:remessa_app/helpers/i18n.dart';
import 'package:remessa_app/helpers/track_events.dart';
import 'package:remessa_app/screens/dashboard/widgets/transaction_card_widget.dart';
import 'package:remessa_app/style/colors.dart';

import 'bloc/bloc.dart';

class DashboardScreen extends StatelessWidget {
  final i18n = GetIt.I<I18n>();
  final _dashboardSreenBloc = DashboardScreenBloc();
  final amplitude = GetIt.I<AmplitudeFlutter>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<DashboardScreenBloc, DashboardScreenState>(
      bloc: _dashboardSreenBloc..add(LoadTransactionsEvent()),
      builder: (context, state) => CustomScrollView(
        slivers: <Widget>[
          _sliverAppBar(theme),
          (state.value.length > 0)
              ? SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index == state.value.length - 5) {
                        final pagination = state?.pagination;

                        if (pagination != null &&
                            pagination.page < pagination.totalPages)
                          _dashboardSreenBloc.add(
                              LoadTransactionsEvent(page: pagination.page + 1));
                      }

                      return TransactionCardWidget(
                        transaction: state.value[index],
                      );
                    },
                    childCount: state.value.length,
                  ),
                )
              : SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 50),
                        child: Text(
                          GetIt.I<I18n>().trans(
                            'dashboard_screen',
                            ['empty_state'],
                          ),
                          style: Theme.of(context).textTheme.subtitle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Image.asset('images/wallet.png'),
                    ],
                  ),
                ),
        ],
      ),
    );
  }

  _logout() {
    amplitude.logEvent(name: TrackEvents.LOGOUT_CLICK);
    GetIt.I<AppBloc>()..add(LogoutEvent());
  }

  SliverAppBar _sliverAppBar(ThemeData theme) {
    return SliverAppBar(
      expandedHeight: 80,
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: IconButton(
            icon: Icon(Icons.exit_to_app),
            iconSize: 35,
            color: Colors.white,
            onPressed: _logout,
          ),
        ),
      ],
      title: Padding(
        padding: const EdgeInsets.only(left: 3),
        child: Text(
          i18n.trans('dashboard'),
          style: TextStyle(
            color: StyleColors.SUPPORT_NEUTRAL_10,
            fontWeight: FontWeight.w200,
            fontSize: 40,
          ),
        ),
      ),
      centerTitle: false,
      pinned: false,
      floating: true,
      elevation: 0.5,
      backgroundColor: theme.scaffoldBackgroundColor,
      // flexibleSpace: FlexibleSpaceBar(
      //   centerTitle: false,
      //   titlePadding:
      //       EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      //   title: Text(
      //     i18n.trans('dashboard'),
      //     style: TextStyle(
      //       color: StyleColors.SUPPORT_NEUTRAL_10,
      //       fontWeight: FontWeight.w200,
      //       fontSize: 30,
      //     ),
      //   ),
      // ),
      // expandedHeight: 80,
    );
  }
}

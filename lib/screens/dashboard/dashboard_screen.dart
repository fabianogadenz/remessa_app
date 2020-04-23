import 'package:amplitude_flutter/amplitude_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:easy_i18n/easy_i18n.dart';
import 'package:remessa_app/helpers/track_events.dart';
import 'package:remessa_app/presentation/remessa_icons_icons.dart';
import 'package:remessa_app/screens/dashboard/widgets/empty_card_widget.dart';
import 'package:remessa_app/screens/dashboard/widgets/historic_list_widget.dart';
import 'package:remessa_app/screens/dashboard/widgets/section_title_widget.dart';
import 'package:remessa_app/screens/dashboard/widgets/skeleton_card_widget.dart';
import 'package:remessa_app/screens/dashboard/widgets/skeleton_list_widget.dart';
import 'package:remessa_app/screens/dashboard/widgets/transactions_carousel_widget.dart';
import 'package:remessa_app/stores/auth_store.dart';
import 'package:remessa_app/stores/transactions_store.dart';
import 'package:remessa_app/style/colors.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final i18n = GetIt.I<I18n>();
  final _transactionsStore = TransactionsStore()..getTransactions();
  final amplitude = GetIt.I<AmplitudeFlutter>();

  bool isEmpty = false;
  ReactionDisposer reactionDisposer;

  @override
  initState() {
    reactionDisposer = reaction(
      (_) =>
          !_transactionsStore.isLoadingTransactions &&
          _transactionsStore.openTransactions.length == 0 &&
          _transactionsStore.closedTransactions.length == 0,
      (bool isEmpty) => (isEmpty != this.isEmpty)
          ? setState(() {
              this.isEmpty = isEmpty;
            })
          : null,
    );
    super.initState();
  }

  @override
  dispose() {
    reactionDisposer();
    super.dispose();
  }

  SliverAppBar _sliverAppBar(ThemeData theme) {
    return SliverAppBar(
      actions: <Widget>[
        Container(
          margin: EdgeInsets.only(right: 10),
          child: IconButton(
            icon: Icon(RemessaIcons.exit),
            iconSize: 22,
            color: StyleColors.SUPPORT_NEUTRAL_10,
            onPressed: _logout,
          ),
        ),
      ],
      title: Icon(
        RemessaIcons.logo,
        size: 24,
        color: StyleColors.SUPPORT_NEUTRAL_10,
      ),
      titleSpacing: 22,
      centerTitle: false,
      pinned: false,
      floating: true,
      elevation: 0.5,
      backgroundColor: theme.scaffoldBackgroundColor,
    );
  }

  _buildOpenTransactionsList(ThemeData theme) => SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SectionTitleWidget(
              text: GetIt.I<I18n>().trans(
                'dashboard_screen',
                ['open_transactions'],
              ),
            ),
            Observer(
              builder: (_) => (_transactionsStore.openTransactions.length > 0)
                  ? TransactionsCarousel(
                      transactionsStore: _transactionsStore,
                    )
                  : _transactionsStore.isLoadingTransactions
                      ? SkeletonCardWidget()
                      : EmptyCardWidget(
                          margin: EdgeInsets.only(
                            left: 20,
                            right: 20,
                            bottom: 30,
                          ),
                          image: Image.asset(
                            'images/wallet.png',
                            width: 100,
                          ),
                          text: GetIt.I<I18n>().trans(
                            'dashboard_screen',
                            ['open_empty_state'],
                          ),
                        ),
            )
          ],
        ),
      );

  _buildCloseTransactionsList(ThemeData theme, BuildContext context) =>
      <Widget>[
        SliverToBoxAdapter(
          child: SectionTitleWidget(
            text: GetIt.I<I18n>().trans(
              'dashboard_screen',
              ['close_transactions'],
            ),
          ),
        ),
        Observer(
          builder: (_) => (_transactionsStore.closedTransactions.length > 0)
              ? HistoricListWidget(transactionsStore: _transactionsStore)
              : _transactionsStore.isLoadingTransactions
                  ? SkeletonListWidget()
                  : SliverToBoxAdapter(
                      child: EmptyCardWidget(
                        image: Image.asset(
                          'images/historic.png',
                          width: 100,
                        ),
                        text: GetIt.I<I18n>().trans(
                          'dashboard_screen',
                          ['closed_empty_state'],
                        ),
                      ),
                    ),
        ),
      ];

  _buildScreenEmptyState(ThemeData theme) => SliverFillRemaining(
        hasScrollBody: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/wallet.png',
              width: 200,
            ),
            Container(
              padding: const EdgeInsets.only(top: 30),
              width: 230,
              child: Text(
                GetIt.I<I18n>().trans(
                  'dashboard_screen',
                  ['open_empty_state'],
                ),
                style: theme.textTheme.subtitle2.copyWith(fontSize: 15),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      );

  _logout() {
    TrackEvents.log(TrackEvents.DASHBOARD_LOGOUT_CLICK);
    GetIt.I<AuthStore>().logout();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final _baseSlivers = <Widget>[
      _sliverAppBar(theme),
      SliverToBoxAdapter(
        child: Container(
          padding: EdgeInsets.only(left: 23, right: 23, top: 30, bottom: 40),
          child: Text(
            GetIt.I<I18n>().trans(
              'dashboard_screen',
              ['title'],
            ),
            style: theme.textTheme.headline6.copyWith(fontSize: 25),
          ),
        ),
      ),
    ];

    var _slivers = _baseSlivers;

    if (isEmpty) {
      _slivers = [
        ..._baseSlivers,
        _buildScreenEmptyState(theme),
      ];
    } else {
      _slivers = [
        ..._baseSlivers,
        _buildOpenTransactionsList(theme),
      ]..addAll(_buildCloseTransactionsList(theme, context));
    }

    return RefreshIndicator(
      color: StyleColors.BRAND_PRIMARY_40,
      onRefresh: () {
        _transactionsStore.clearTransactions();
        _transactionsStore.getTransactions();

        return Future.delayed(Duration(seconds: 1));
      },
      child: CustomScrollView(
        slivers: _slivers,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:remessa_app/app/app_store.dart';
import 'package:easy_i18n/easy_i18n.dart';
import 'package:remessa_app/helpers/chat_helper.dart';
import 'package:remessa_app/helpers/navigator.dart';
import 'package:remessa_app/helpers/track_events.dart';
import 'package:remessa_app/presentation/remessa_icons_icons.dart';
import 'package:remessa_app/router.dart';

import 'package:remessa_app/screens/dashboard/dashboard_screen.dart';
import 'package:remessa_app/screens/transaction_details/transaction_details_screen_args.dart';
import 'package:remessa_app/style/colors.dart';
import 'package:remessa_app/widgets/tab_controller/tab_controller_store.dart';
import 'package:screens/screens.dart';

class TabContent {
  final String title;
  final IconData iconData;
  final Widget widget;
  final Function action;

  TabContent({
    @required this.title,
    @required this.iconData,
    @required this.widget,
    this.action,
  })  : assert(title != null),
        assert(iconData != null),
        assert(widget != null);
}

class TabControllerWidget extends StatefulWidget {
  @override
  _TabControllerWidgetState createState() => _TabControllerWidgetState();
}

class _TabControllerWidgetState extends State<TabControllerWidget> {
  final i18n = GetIt.I<I18n>();
  final _tabControllerStore = GetIt.I<TabControllerStore>()
    ..setErrorMessage(null);
  final _appStore = GetIt.I<AppStore>();
  final navigator = GetIt.I<NavigatorHelper>();

  List<TabContent> _tabs = [];
  ReactionDisposer reactionDisposer;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      reactionDisposer = autorun(openTransactionDetails);
    });

    super.initState();
  }

  @override
  void dispose() {
    reactionDisposer();
    super.dispose();
  }

  openTransactionDetails(_) {
    if (_appStore.transactionId != null) {
      if (Navigator.canPop(context)) {
        Navigator.popUntil(context, (route) => route.isFirst);
      }

      navigator.pushNamed(
        Router.TRANSACTION_DETAILS_ROUTE,
        arguments: TransactionDetailsScreenArgs(
          transactionId: _appStore.transactionId,
        ),
      );

      _appStore.setTransactionId(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    _tabs = <TabContent>[
      TabContent(
        title: 'Envios',
        iconData: RemessaIcons.send,
        widget: DashboardScreen(),
        action: () {
          TrackEvents.log(TrackEvents.NAVBAR_SEND_CLICK);
        },
      ),
      TabContent(
        title: 'Simulador',
        iconData: RemessaIcons.simulador,
        widget: Container(),
        action: () {
          TrackEvents.log(TrackEvents.NAVBAR_SIMULATOR_CLICK);
          navigator.pushNamed(Router.SIMULATOR_ROUTE);
        },
      ),
      // TabContent(
      //   title: 'Perfil',
      //   iconData: RemessaIcons.user_fill,
      //   widget: DashboardScreen(),
      // ),
    ];

    if (_appStore?.configs?.isChatEnabled ?? true) {
      _tabs.add(
        TabContent(
          title: i18n.trans('help'),
          iconData: RemessaIcons.chat,
          widget: Container(),
          action: () {
            TrackEvents.log(TrackEvents.DASHBOARD_HELP_TAB_CLICK);
            ChatHelper().openChat();
          },
        ),
      );
    }

    return Observer(
      builder: (_) {
        return GetIt.I<Screens>().widget(
          isStatic: true,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          child: _tabs[_tabControllerStore.currentTabIndex].widget,
          bottomNavigationBar: _tabs.length >= 2
              ? BottomNavigationBar(
                  selectedItemColor: StyleColors.SUPPORT_NEUTRAL_10,
                  unselectedItemColor: StyleColors.SUPPORT_NEUTRAL_40,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  elevation: 100,
                  iconSize: 30,
                  currentIndex: _tabControllerStore.currentTabIndex,
                  onTap: (int index) {
                    onTabTapped(context, index);
                  },
                  items: _tabs
                      .map(
                        (tab) => BottomNavigationBarItem(
                          icon: Icon(
                            tab.iconData,
                            size: 18,
                          ),
                          title: Text(tab.title),
                        ),
                      )
                      .toList(),
                )
              : null,
        )
          ..errorStreamController.add(_tabControllerStore.errorMessage)
          ..loaderStreamController.add(_tabControllerStore.isLoading);
      },
    );
  }

  void onTabTapped(BuildContext context, int index) async {
    if (_tabs[index].action != null) {
      return _tabs[index].action();
    }

    _tabControllerStore.setCurrentTabIndex(index);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:remessa_app/app/app_store.dart';
import 'package:easy_i18n/easy_i18n.dart';
import 'package:remessa_app/helpers/chat_helper.dart';
import 'package:remessa_app/helpers/navigator.dart';
import 'package:remessa_app/stores/auth_store.dart';
import 'package:remessa_app/v2/core/tracking/tracking_events.dart';
import 'package:remessa_app/presentation/remessa_icons_icons.dart';
import 'package:remessa_app/router.dart';

import 'package:remessa_app/screens/dashboard/dashboard_screen.dart';
import 'package:remessa_app/screens/home/home_screen_store.dart';
import 'package:remessa_app/screens/loader_screen.dart';
import 'package:remessa_app/screens/transaction_details/transaction_details_screen_args.dart';
import 'package:remessa_app/stores/info_store.dart';
import 'package:remessa_app/style/colors.dart';
import 'package:remessa_app/v2/modules/profile/view/screens/profile/profile_screen.dart';
import 'package:remessa_app/v2/modules/settings/application/presenters/notification_preferences_presenter.dart';
import 'package:remessa_app/v2/modules/settings/application/viewmodels/notification_preferences_viewmodel.dart';
import 'package:screens/screens.dart';

class TabContent {
  final String label;
  final IconData iconData;
  final Widget widget;
  final Function action;

  TabContent({
    @required this.label,
    @required this.iconData,
    this.widget,
    this.action,
  })  : assert(label != null),
        assert(iconData != null);
}

class HomeScreen extends StatefulWidget {
  final NotificationPreferencesPresenter notificationPreferencesPresenter;

  const HomeScreen({
    Key key,
    @required this.notificationPreferencesPresenter,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final i18n = GetIt.I<I18n>();
  final _homeScreenStore = GetIt.I<HomeScreenStore>()..setErrorMessage(null);
  final _appStore = GetIt.I<AppStore>();
  final _infoStore = GetIt.I<InfoStore>();
  final _authStore = GetIt.I<AuthStore>();
  final navigator = GetIt.I<NavigatorHelper>();

  NotificationPreferencesPresenter get _notificationPreferencesPresenter =>
      widget.notificationPreferencesPresenter;

  List<TabContent> _tabs = [];
  ReactionDisposer reactionDisposer;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      reactionDisposer = autorun(_handleInfoToShow);
    });

    _tabs = <TabContent>[
      TabContent(
        label: i18n.trans('outbound'),
        iconData: RemessaIcons.list,
        widget: DashboardScreen(),
        action: () {
          TrackingEvents.log(TrackingEvents.NAVBAR_SEND_CLICK);
        },
      ),
      TabContent(
        label: i18n.trans('simulator'),
        iconData: RemessaIcons.send,
        action: () {
          TrackingEvents.log(TrackingEvents.NAVBAR_SIMULATOR_CLICK);
          _homeScreenStore.setCurrentTabIndex(
              0); // Reset current tab when open the simulator
          navigator.pushNamed(AppRouter.SIMULATOR_ROUTE);
        },
      ),
      TabContent(
        label: i18n.trans('profile'),
        iconData: RemessaIcons.user_fill,
        widget: ProfileScreen(
          customer: _authStore.customer,
          i18n: i18n,
          logout: _authStore.logout,
          isChatEnabled: _appStore?.configs?.isChatEnabled ?? true,
          openChat: ChatHelper.openChat,
        ),
        action: () {
          TrackingEvents.log(TrackingEvents.NAVBAR_PROFILE_CLICK);
        },
      ),
    ];

    super.initState();
  }

  @override
  void dispose() {
    reactionDisposer();
    _homeScreenStore.clean();
    super.dispose();
  }

  _handleInfoToShow(_) async {
    await _infoStore.check();

    if (_infoStore.hasInfoToShow) {
      navigator.pushReplacementNamed(
        AppRouter.GENERATED_VIEW_ROUTE,
        arguments: _infoStore.info,
      );

      return;
    }

    if (!(_authStore?.customer?.pushNotificationsEnabled ?? false)) {
      _notificationPreferencesPresenter.updateNoficiationPreferences(
        NotificationPreferencesViewModel(enablePushNotification: true),
      );
    }

    if (_appStore.transactionId != null) {
      if (Navigator.canPop(context)) {
        Navigator.popUntil(context, (route) => route.isFirst);
      }

      navigator.pushNamed(
        AppRouter.TRANSACTION_DETAILS_ROUTE,
        arguments: TransactionDetailsScreenArgs(
          transactionId: _appStore.transactionId,
        ),
      );

      _appStore.setTransactionId(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        if (_infoStore.hasInfoToShow || _infoStore.isLoading) {
          return LoaderScreen();
        }

        return GetIt.I<Screens>().widget(
          isStatic: true,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          child: _tabs[_homeScreenStore.currentTabIndex].widget,
          bottomNavigationBar: _tabs.length >= 2
              ? BottomNavigationBar(
                  selectedItemColor: StyleColors.SUPPORT_NEUTRAL_10,
                  unselectedItemColor: StyleColors.SUPPORT_NEUTRAL_40,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  elevation: 100,
                  iconSize: 30,
                  currentIndex: _homeScreenStore.currentTabIndex,
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
                          label: tab.label,
                        ),
                      )
                      .toList(),
                )
              : null,
        )
          ..errorStreamController.add(_homeScreenStore.errorMessage ??
              _notificationPreferencesPresenter.errorMessage)
          ..loaderStreamController.add(_homeScreenStore.isLoading);
      },
    );
  }

  void onTabTapped(BuildContext context, int index) async {
    if (_tabs[index].action != null) {
      _tabs[index].action();
    }

    if (_tabs[index]?.widget != null) {
      _homeScreenStore.setCurrentTabIndex(index);
    }
  }
}

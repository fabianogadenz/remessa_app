import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:remessa_app/app/app_store.dart';
import 'package:remessa_app/helpers/i18n.dart';

import 'package:remessa_app/screens/dashboard/dashboard_screen.dart';
import 'package:remessa_app/services/auth_service.dart';
import 'package:remessa_app/style/colors.dart';
import 'package:remessa_app/widgets/tab_controller/bloc/bloc.dart';
import 'package:remessa_app/widgets/widgets.dart';
import 'package:zendesk/zendesk.dart';

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
  final _tabControllerBloc = GetIt.I<TabControllerBloc>();
  final zendesk = GetIt.I<Zendesk>();
  List<TabContent> _tabs = [];

  @override
  Widget build(BuildContext context) {
    _tabs = <TabContent>[
      TabContent(
        title: i18n.trans('dashboard'),
        iconData: Icons.home,
        widget: DashboardScreen(),
      ),
    ];

    if (GetIt.I<AppStore>()?.remoteConfigs?.isChatEnabled ?? true) {
      _tabs.add(
        TabContent(
          title: i18n.trans('help'),
          iconData: Icons.chat,
          widget: Container(),
          action: _openChat,
        ),
      );
    }

    return BlocBuilder<TabControllerBloc, TabControllerState>(
      bloc: _tabControllerBloc,
      builder: (context, state) => ScreenWidget(
        isStatic: true,
        child: _tabs[state.currentTabIndex].widget,
        bottomNavigationBar: _tabs.length >= 2
            ? BottomNavigationBar(
                selectedItemColor: StyleColors.SUPPORT_NEUTRAL_10,
                unselectedItemColor: StyleColors.SUPPORT_NEUTRAL_40,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                elevation: 100,
                iconSize: 30,
                currentIndex: state.currentTabIndex,
                onTap: (int index) {
                  onTabTapped(context, index);
                },
                items: _tabs
                    .map(
                      (tab) => BottomNavigationBarItem(
                        icon: Icon(tab.iconData),
                        title: Text(tab.title),
                      ),
                    )
                    .toList(),
              )
            : null,
      )
        ..errorStreamController.add(state.errorMessage)
        ..loaderStreamController.add(state.isLoading),
    );
  }

  _openChat() async {
    try {
      final customer = GetIt.I<AuthService>().customer;

      await zendesk.setVisitorInfo(
        email: customer.email,
        name: customer.name,
        phoneNumber: '${customer.countryCode}${customer.mobilePhone}',
        note: 'ID: ${customer.id}\nCPF: ${customer.cpfCnpj}',
      );
      await zendesk.startChat();

      return;
    } catch (_) {
      _tabControllerBloc.add(
        ErrorTabEvent(errorMessage: i18n.trans('error', ['chat'])),
      );

      return;
    }
  }

  void onTabTapped(BuildContext context, int index) async {
    if (_tabs[index].action != null) {
      return _tabs[index].action();
    }

    _tabControllerBloc.add(
      ChangeTabEvent(index: index),
    );
  }
}

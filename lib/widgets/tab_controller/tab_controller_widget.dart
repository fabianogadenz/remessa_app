import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remessa_app/helpers/i18n.dart';

import 'package:remessa_app/screens/calculator/calculator_screen.dart';
import 'package:remessa_app/widgets/tab_controller/bloc/bloc.dart';
import 'package:zendesk_chat/zendesk_chat.dart';

class TabContent {
  final String title;
  final IconData iconData;
  final Widget widget;

  TabContent({
    @required this.title,
    @required this.iconData,
    @required this.widget,
  })  : assert(title != null),
        assert(iconData != null),
        assert(widget != null);
}

class TabControllerWidget extends StatefulWidget {
  @override
  _TabControllerWidgetState createState() => _TabControllerWidgetState();
}

class _TabControllerWidgetState extends State<TabControllerWidget> {
  final _tabControllerBloc = TabControllerBloc();

  final _zendeskChat =
      ZendeskChat(accountKey: 'MyqHVBcMtviH16mTlMyl0AlpYYsJLS2i');

  @override
  Widget build(BuildContext context) {
    final i18n = I18n.of(context);

    final _tabs = <TabContent>[
      TabContent(
        title: i18n.trans('help'),
        iconData: Icons.help,
        widget: CalculatorScreen(),
      ),
      TabContent(
        title: i18n.trans('dashboard'),
        iconData: Icons.dashboard,
        widget: CalculatorScreen(),
      ),
      TabContent(
        title: i18n.trans('chat'),
        iconData: Icons.chat,
        widget: Container(),
      ),
    ];

    return BlocBuilder<TabControllerBloc, TabControllerState>(
      bloc: _tabControllerBloc,
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: Text(_tabs[state.currentTabIndex].title),
        ),
        body: _tabs[state.currentTabIndex].widget,
        bottomNavigationBar: BottomNavigationBar(
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
        ),
      ),
    );
  }

  void onTabTapped(BuildContext context, int index) {
    if (index == 2) {
      _zendeskChat.openChatScreen(
        context,
        ChatSettings(
          visitor: Visitor(name: ''),
        ),
      );
      return;
    }

    _tabControllerBloc.add(
      ChangeTabEvent(index: index),
    );
  }
}

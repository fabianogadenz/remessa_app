import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:remessa_app/screens/calculator/calculator_screen.dart';
import 'package:remessa_app/widgets/tab_controller/bloc/bloc.dart';
import 'package:zendesk_chat/zendesk_chat.dart';

class TabContent {
  final String title;
  final Widget widget;

  TabContent({
    @required this.title,
    @required this.widget,
  })  : assert(title != null),
        assert(widget != null);
}

class TabControllerWidget extends StatelessWidget {
  final _tabs = <TabContent>[
    TabContent(
      title: 'Ajuda',
      widget: CalculatorScreen(),
    ),
    TabContent(
      title: 'Dashboard',
      widget: CalculatorScreen(),
    ),
    TabContent(
      title: 'Chat',
      widget: Container(),
    ),
  ];

  final _tabControllerBloc = TabControllerBloc();
  final _zendeskChat =
      ZendeskChat(accountKey: 'MyqHVBcMtviH16mTlMyl0AlpYYsJLS2i');

  @override
  Widget build(BuildContext context) {
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
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.help),
              title: Text('Ajuda'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              title: Text('Dashboard'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              title: Text('Chat'),
            )
          ],
        ),
      ),
    );
  }

  void onTabTapped(BuildContext context, int index) {
    if (index == _tabs.length - 1) {
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

import 'package:flutter/material.dart';

import 'package:remessa_app/screens/calculator/calculator_screen.dart';
import 'package:zendesk_chat/zendesk_chat.dart';

class TabControllerWidget extends StatefulWidget {
  const TabControllerWidget({
    Key key,
  }) : super(key: key);

  @override
  _TabControllerWidgetState createState() => _TabControllerWidgetState();
}

class _TabControllerWidgetState extends State<TabControllerWidget> {
  final _children = <Widget>[
    CalculatorScreen(),
    Container(),
    Container(),
  ];
  int _currentIndex = 0;
  final _zendeskChat =
      ZendeskChat(accountKey: 'MyqHVBcMtviH16mTlMyl0AlpYYsJLS2i');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onTabTapped,
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
    );
  }

  void onTabTapped(int index) {
    if (index == _children.length - 1) {
      _zendeskChat.openChatScreen(
        context,
        ChatSettings(
          visitor: Visitor(name: ''),
        ),
      );
      return;
    }

    setState(() {
      _currentIndex = index;
    });
  }
}

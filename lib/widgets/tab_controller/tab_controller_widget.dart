import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:remessa_app/helpers/i18n.dart';

import 'package:remessa_app/screens/dashboard/dashboard_screen.dart';
// import 'package:remessa_app/style/colors.dart';
import 'package:remessa_app/widgets/tab_controller/bloc/bloc.dart';
import 'package:remessa_app/widgets/widgets.dart';

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
  final i18n = GetIt.I<I18n>();
  final _tabControllerBloc = GetIt.I<TabControllerBloc>();

  @override
  Widget build(BuildContext context) {
    final _tabs = <TabContent>[
      TabContent(
        title: i18n.trans('dashboard'),
        iconData: Icons.home,
        widget: DashboardScreen(),
      ),
      TabContent(
        title: i18n.trans('help'),
        iconData: Icons.chat,
        widget: Container(),
      ),
    ];

    return BlocBuilder<TabControllerBloc, TabControllerState>(
      bloc: _tabControllerBloc,
      builder: (context, state) => ScreenWidget(
        isStatic: true,
        child: _tabs[state.currentTabIndex].widget,
        // bottomNavigationBar: BottomNavigationBar(
        //   selectedItemColor: StyleColors.SUPPORT_NEUTRAL_10,
        //   unselectedItemColor: StyleColors.SUPPORT_NEUTRAL_40,
        //   backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        //   elevation: 100,
        //   iconSize: 30,
        //   currentIndex: state.currentTabIndex,
        //   onTap: (int index) {
        //     onTabTapped(context, index);
        //   },
        //   items: _tabs
        //       .map(
        //         (tab) => BottomNavigationBarItem(
        //           icon: Icon(tab.iconData),
        //           title: Text(tab.title),
        //         ),
        //       )
        //       .toList(),
        // ),
      )
        ..errorStreamController.add(state.errorMessage)
        ..loaderStreamController.add(state.isLoading),
    );
  }

  void onTabTapped(BuildContext context, int index) {
    _tabControllerBloc.add(
      ChangeTabEvent(index: index),
    );
  }
}

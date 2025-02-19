import 'package:flutter/material.dart';
import 'package:monitor_for_sales/screens/dialog_setting_new.dart';
import 'package:monitor_for_sales/screens/dialog_setting_old.dart';
import 'package:monitor_for_sales/screens/settings_home_page.dart';
import 'package:tab_container/tab_container.dart';

class TabSetting extends StatefulWidget {
  const TabSetting({super.key});

  @override
  State<TabSetting> createState() => _TabSettingState();
}

class _TabSettingState extends State<TabSetting>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        // Реагируем на смену вкладки, если нужно
        print('Switched to tab: ${_tabController.index}');
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: TabContainer(
          controller: _tabController,
          curve: Curves.linear,
          radius: 20,
          tabEdge: TabEdge.left,
          tabExtent: 50,
          transitionBuilder: (child, animation) {
        // Анимация переключения вкладок
             return FadeTransition(opacity: animation, child: child);
             },
          tabs: const [
            RotatedBox(
              quarterTurns: 4,
              child: Text(
                'Вкладка 1',
                style: TextStyle(color: Colors.black),
              ),
            ),
            RotatedBox(
              quarterTurns: 4,
              child: Text(
                'Вкладка 2',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
          children: const [
            DialogSettingNew(),
            // Содержимое второй вкладки
            DialogSettingOld()
           ],
        )
    );
  }
}

import 'package:flutter/material.dart';
import 'package:monitor_for_sales/screens_setting/box_left.dart';
import 'package:monitor_for_sales/screens_setting/box_right.dart';
import 'package:monitor_for_sales/screens_setting/setting_column_left.dart';
import '../screens_setting/header.dart';
import '../screens_setting/setting_column_right.dart';

class SettingsDialogContent extends StatefulWidget {
  const SettingsDialogContent({super.key});

  @override
  State<SettingsDialogContent> createState() => _SettingsDialogContentState();
}

class _SettingsDialogContentState extends State<SettingsDialogContent>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }


  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: SizedBox(
          width: 500,
          height: 800,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: const [
              ExpansionTile(
                title: Text('Header Settings'),
                children: [
                  SettingHeader(),
                ],
              ),
              ExpansionTile(
                title: Text('Column Left Settings'),
                children: [
                  SettingColumnLeft(),
                ],
              ),
              ExpansionTile(
                title: Text('Column Right Settings'),
                children: [
                  SettingColumnRight(),
                ],
              ), ExpansionTile(
                title: Text('Box Left Settings'),
                children: [
                  SettingBoxLeft(),
                ],
              ),
              ExpansionTile(
                title: Text('Box Right Settings'),
                children: [
                  SettingBoxRight(),
                ],
              ),
            ],
          ),
        )

    );
  }
}

class SettingsPage extends StatelessWidget {
  final Widget settingsWidget;
  final String title;

  const SettingsPage({required this.settingsWidget, required this.title});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ExpansionTile(
          title: Text(title),
          children: [
            settingsWidget,
          ],
        ),
      ],
    );
  }
}

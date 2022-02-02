import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hisnelmoslem/Shared/constant.dart';
import 'package:hisnelmoslem/Utils/azkar_database_helper.dart';
import 'package:hisnelmoslem/controllers/dashboard_controller.dart';
import 'package:hisnelmoslem/models/alarm.dart';
import 'package:hisnelmoslem/models/zikr_title.dart';
import 'package:hisnelmoslem/providers/app_settings.dart';
import 'package:hisnelmoslem/shared/dialogs/add_fast_alarm_dialog.dart';
import 'package:hisnelmoslem/shared/transition_animation/transition_animation.dart';
import 'package:hisnelmoslem/utils/alarm_database_helper.dart';
import 'package:hisnelmoslem/utils/alarm_manager.dart';
import 'package:hisnelmoslem/views/screens/azkar_read_card.dart';
import 'package:hisnelmoslem/views/screens/azkar_read_page.dart';
import 'package:provider/provider.dart';

class ZikrCard extends StatelessWidget {
  final DbTitle fehrsTitle;
  final DbAlarm dbAlarm;
  ZikrCard({required this.fehrsTitle, required this.dbAlarm});

  @override
  Widget build(BuildContext context) {
    final appSettings = Provider.of<AppSettingsNotifier>(context);

    return GetBuilder<DashboardController>(builder: (controller) {
      bool hasAlarm = false;
      DbAlarm tempAlarm = dbAlarm;
      hasAlarm = controller.alarms
          .where((alarm) => alarm.id == fehrsTitle.orderId - 1)
          .isNotEmpty;
      if (hasAlarm) {
        tempAlarm = controller.alarms
            .where((alarm) => alarm.id == fehrsTitle.orderId - 1)
            .first;
      }
      return ListTile(
        leading: fehrsTitle.favourite == 1
            ? IconButton(
                icon: Icon(
                  Icons.bookmark,
                  color: Colors.blue.shade200,
                ),
                onPressed: () {
                  azkarDatabaseHelper.deleteFromFavourite(dbTitle: fehrsTitle);
                  fehrsTitle.favourite = 0;
                  controller.favouriteTitle
                      .removeWhere((item) => item == fehrsTitle);
                  controller.update();
                })
            : IconButton(
                icon: Icon(Icons.bookmark_border_outlined),
                onPressed: () {
                  //
                  azkarDatabaseHelper.addToFavourite(dbTitle: fehrsTitle);
                  fehrsTitle.favourite = 1;
                  //
                  controller.allTitle[fehrsTitle.orderId - 1] = fehrsTitle;
                  controller.favouriteTitle.add(fehrsTitle);
                  //
                  controller.update();
                  //
                }),
        trailing: !hasAlarm
            ? IconButton(
                icon: Icon(Icons.alarm_add_rounded),
                onPressed: () {
                  dbAlarm.title = fehrsTitle.name;
                  showFastAddAlarmDialog(context: context, dbAlarm: dbAlarm)
                      .then((value) {
                    int index = controller.alarms.indexOf(dbAlarm);
                    if (index == -1) {
                      controller.alarms.add(value);
                    } else {
                      controller.alarms[index] = value;
                    }

                    controller.update();

                    debugPrint(value.toString());
                  });
                })
            : tempAlarm.isActive == 1
                ? IconButton(
                    icon: Icon(
                      Icons.alarm,
                      color: MAINCOLOR,
                    ),
                    onPressed: () {
                      dbAlarm.isActive = 0;
                      tempAlarm.isActive = 0;
                      alarmDatabaseHelper.updateAlarmInfo(dbAlarm: dbAlarm);

                      //
                      alarmManager.alarmState(dbAlarm: dbAlarm);
                      //
                      controller.update();
                    })
                : IconButton(
                    icon: Icon(
                      Icons.alarm,
                      color: Colors.redAccent,
                    ),
                    onPressed: () {
                      dbAlarm.isActive = 1;
                      tempAlarm.isActive = 1;
                      alarmDatabaseHelper.updateAlarmInfo(dbAlarm: dbAlarm);

                      //
                      alarmManager.alarmState(dbAlarm: dbAlarm);
                      //
                      controller.update();
                    }),
        title: Text(fehrsTitle.name, style: TextStyle(fontFamily: "Uthmanic")),
        // trailing: Text(zikrList[index]),
        onTap: () {
          String azkarReadMode = appSettings.getAzkarReadMode();
          if (azkarReadMode == "Page") {
            transitionAnimation.circleReval(
                context: Get.context!,
                goToPage: AzkarReadPage(index: fehrsTitle.id));
          } else if (azkarReadMode == "Card") {
            transitionAnimation.circleReval(
                context: Get.context!,
                goToPage: AzkarReadCard(index: fehrsTitle.id));
          }
        },
      );
    });
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hisnelmoslem/src/core/shared/widgets/loading.dart';
import 'package:hisnelmoslem/src/core/values/app_dashboard.dart';
import 'package:hisnelmoslem/src/features/home/presentation/controller/bloc/home_bloc.dart';

class RearrangeDashboardPage extends StatelessWidget {
  const RearrangeDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is! HomeLoadedState) {
          return const Loading();
        }
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "dashboard arrangement".tr,
            ),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
          ),
          body: ReorderableListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                key: Key("$index"),
                title: Text(
                  appDashboardItem[state.dashboardArrangement[index]].title,
                ),
                trailing: const Icon(Icons.horizontal_rule),
              );
            },
            itemCount: state.dashboardArrangement.length,
            onReorder: (oldIndex, newIndex) {
              context.read<HomeBloc>().add(
                    HomeDashboardReorderedEvent(
                      oldIndex: oldIndex,
                      newIndex: newIndex,
                    ),
                  );
            },
          ),
        );
      },
    );
  }
}

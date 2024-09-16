import 'package:get_it/get_it.dart';
import 'package:hisnelmoslem/src/features/alarms_manager/data/repository/alarm_database_helper.dart';
import 'package:hisnelmoslem/src/features/alarms_manager/presentation/controller/bloc/alarms_bloc.dart';
import 'package:hisnelmoslem/src/features/effects_manager/presentation/controller/sounds_manager_controller.dart';
import 'package:hisnelmoslem/src/features/fake_hadith/data/repository/fake_hadith_database_helper.dart';
import 'package:hisnelmoslem/src/features/home/data/repository/azkar_database_helper.dart';
import 'package:hisnelmoslem/src/features/home/data/repository/data_database_helper.dart';
import 'package:hisnelmoslem/src/features/home/presentation/controller/bloc/home_bloc.dart';
import 'package:hisnelmoslem/src/features/home_search/presentation/controller/cubit/search_cubit.dart';
import 'package:hisnelmoslem/src/features/quran/data/repository/uthmani_repository.dart';
import 'package:hisnelmoslem/src/features/share_as_image/data/repository/share_as_image_data.dart';
import 'package:hisnelmoslem/src/features/tally/data/repository/tally_database_helper.dart';
import 'package:hisnelmoslem/src/features/tally/presentation/controller/bloc/tally_bloc.dart';
import 'package:hisnelmoslem/src/features/themes/presentation/controller/cubit/theme_cubit.dart';

final sl = GetIt.instance;

Future<void> initSL() async {
  ///MARK: Init storages
  sl.registerLazySingleton(() => ShareAsImageData());

  ///MARK: Init Repo
  sl.registerLazySingleton(() => TallyDatabaseHelper());
  sl.registerLazySingleton(() => AlarmDatabaseHelper());
  sl.registerLazySingleton(() => UthmaniRepository());
  sl.registerLazySingleton(() => UserDataDBHelper());
  sl.registerLazySingleton(() => AzkarDatabaseHelper(sl()));
  sl.registerLazySingleton(() => FakeHadithDatabaseHelper(sl()));

  ///MARK: Init BLOC
  sl.registerLazySingleton(() => ThemeCubit());
  sl.registerLazySingleton(() => AlarmsBloc(sl()));
  sl.registerLazySingleton(() => HomeBloc(sl(), sl(), sl()));
  sl.registerLazySingleton(() => SearchCubit(sl()));
  sl.registerFactory(() => TallyBloc(sl(), SoundsManagerController()));
}

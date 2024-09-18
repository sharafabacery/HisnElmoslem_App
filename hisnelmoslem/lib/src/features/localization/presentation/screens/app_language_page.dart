// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hisnelmoslem/generated/l10n.dart';
import 'package:hisnelmoslem/src/features/themes/presentation/controller/cubit/theme_cubit.dart';

class AppLanguagePage extends StatelessWidget {
  const AppLanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        final supportedLocales = S.delegate.supportedLocales;
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              S.of(context).appLanguage,
            ),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
          ),
          body: ListView.builder(
            padding: const EdgeInsets.all(15),
            itemCount: supportedLocales.length,
            itemBuilder: (context, index) {
              final currentLocale = supportedLocales[index];
              return ListTile(
                tileColor:
                    context.read<ThemeCubit>().state.locale == currentLocale
                        ? Theme.of(context).colorScheme.primary.withOpacity(.2)
                        : null,
                title: Text(currentLocale.languageCode),
                onTap: () {
                  context
                      .read<ThemeCubit>()
                      .changeAppLocale(currentLocale.languageCode);
                },
              );
            },
          ),
        );
      },
    );
  }
}

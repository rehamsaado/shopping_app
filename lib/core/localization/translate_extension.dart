import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_strings.dart';
import 'locale_cubit.dart';

extension TranslateX on BuildContext {
  String tr(String key) {
    final locale = read<LocaleCubit>().state;
    return AppStrings.of(key, locale.languageCode);
  }
}
import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/settings_repository.dart';

class LocaleCubit extends Cubit<Locale?> {
  LocaleCubit(this._settings) : super(null);

  final SettingsRepository _settings;
  StreamSubscription<String?>? _sub;

  void start() {
    _sub = _settings.watchLanguageCode().listen((code) {
      emit(code == null ? null : Locale(code));
    });
  }

  Future<void> setLanguage(String code) => _settings.setLanguageCode(code);

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}

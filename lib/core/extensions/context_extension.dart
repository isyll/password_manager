import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:password_manager/core/utils/common.dart';

extension ContextExtension on BuildContext {
  AppLocalizations get l {
    return getApplocalizations(this);
  }

  NavigatorState get navigator => Navigator.of(this);

  ThemeData get theme => Theme.of(this);

  Future<void> toNamed(String routeName) {
    return navigator.pushNamed(routeName);
  }
}

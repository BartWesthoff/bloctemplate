import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'
    show AppLocalizations;

extension BuildContextExtension on BuildContext {
  AppLocalizations get loc => AppLocalizations.of(this)!;
  Size get size => MediaQuery.of(this).size;
}

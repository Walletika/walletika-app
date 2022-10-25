import 'package:get/get.dart';

import '../utils/constants.dart';
import 'en.dart' as en;
import 'ar.dart' as ar;

class AppTranslator extends Translations {
  // Just replace the order to change the primary language
  static const Map<String, String> locales = {
    AppLanguages.en: 'English',
    AppLanguages.ar: 'العربية',
  };

  @override
  Map<String, Map<String, String>> get keys {
    // Just replace the order to change the primary language
    return {
      AppLanguages.en: en.translator,
      AppLanguages.ar: ar.translator,
    };
  }
}

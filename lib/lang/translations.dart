import 'dart:ui';

import 'package:get/get.dart';

import 'en_US.dart';
import 'es_ES.dart';

const ESES = Locale('es', 'ES');
const ENGLISH = Locale('en', 'US');
var languages = [ESES, ENGLISH];

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': en_US,
        'es_ES': es_ES,
      };
}

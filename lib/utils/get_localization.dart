import 'package:get/get.dart';

class MyLocalization extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
        "en": {
          'title': 'GETX Example',
          'example': 'Localization Example with Get: eset = @kow'
        },
        "id": {
          'title': 'Contoh kodingan GETX',
          'example': 'CONTOH Localization Get: eset = @kow'
        }
      };
}

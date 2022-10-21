import 'package:get/get.dart';

class WorkerController extends GetxController {
  var count = 0.obs;

  void change() => count++;

  void reset() => count.value = 0;

  @override
  void onInit() {
    // TODO: implement onInit
    print('ON INIT');
    // SAMA SEPERTI WATCH DI NUXT
    ever(count, (_) => print('triggered'));
    // JIKA MAU WATCH BEBERAPA VAR MENGGUNAKAN EVER ALL DAN PARAM DALAM BENTUK LIST
    // GUNAKAN ONCE JIKA HANYA MAU TRIGGER SEKALI
    once(count, (_) => print('triggered once'));
    // DEBOUNCE SANGAN SIMPLE
    debounce(count, (_) => print('debounce 2 sec'), time: Duration(seconds: 2));
    // INTERVAL KEBALIKAN DEBOUNCE, HITUNGAN DIMULAI DARI TRIGGER PERTAMA
    interval(count, (_) => print('interval 2 sec'), time: Duration(seconds: 2));

    super.onInit();
  }
}

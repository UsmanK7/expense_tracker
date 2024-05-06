import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/state_manager.dart';

class HomeController extends GetxController {
  RxString dropDownValue = "March".obs;
  int touchedIndex = -1;

  void onChartTouch(FlTouchEvent event, PieTouchResponse pieTouchResponse) {
    if (!event.isInterestedForInteractions ||
        pieTouchResponse == null ||
        pieTouchResponse.touchedSection == null) {
      touchedIndex = -1;
      update(); // use update() instead of setState()
      return;
    }
    touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
    update(); // use update() instead of setState()
  }
}

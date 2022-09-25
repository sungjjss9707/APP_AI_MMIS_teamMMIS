import 'package:myapp/model/menu_list.dart';

class Menu {
  final String date;
  final String time;
  final List<String> menuPlate;
  final List<double> rating;

  Menu(this.date, this.time, this.menuPlate, this.rating);
}

Menu getMenuByDateAndTime(String date, String time, List<Menu> menu) {
  return menu
      .firstWhere((element) => element.date == date && element.time == time);
}

int getMenuIndexByDateAndTime(String date, String time, List<Menu> menu) {
  Menu menuElement = getMenuByDateAndTime(date, time, menu);
  return menu.indexOf(menuElement);
}

List<Menu> dummyMenu = makeMenuList();

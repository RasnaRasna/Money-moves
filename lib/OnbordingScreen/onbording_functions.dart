import '../models/category/category_model.dart';

oneTimeAdd({required final value}) async {
  final box = Splashscreens.getdata();
  final data = Splashscreens(screens: value);
  box.put(0, data);
  data.save();
}

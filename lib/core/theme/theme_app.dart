import 'color_app.dart';
import 'text_app.dart';

class ThemeApp {
  ThemeApp._();

  static final colors = LightThemeColors();
  static final text = TextApp(colors);
}

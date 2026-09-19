import 'package:shared_preferences_web/shared_preferences_web.dart';

void initializePreferencesPlatform() {
  SharedPreferencesPlugin.registerWith(null);
  SharedPreferencesAsyncWeb.registerWith(null);
}
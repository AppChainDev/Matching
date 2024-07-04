import 'package:flutter_test/flutter_test.dart';
import 'package:drone/state/settings_state.dart';

void main() {
  test('Toggle dark mode', () {
    final settingsState = SettingsState();

    expect(settingsState.darkMode, false);

    settingsState.toggleDarkMode();
    expect(settingsState.darkMode, true);

    settingsState.toggleDarkMode();
    expect(settingsState.darkMode, false);
  });
}

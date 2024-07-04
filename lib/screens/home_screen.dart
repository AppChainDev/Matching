import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/user_state.dart';
import '../state/settings_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userState = Provider.of<UserState>(context);
    final settingsState = Provider.of<SettingsState>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: Icon(settingsState.darkMode ? Icons.dark_mode : Icons.light_mode),
            onPressed: settingsState.toggleDarkMode,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (userState.isAuthenticated)
              Text('Welcome, ${userState.user!.name}!'),
            // CustomButton(
            //   text: 'Logout',
            //   onPressed: () {
            //     userState.logout();
            //     Navigator.pushReplacementNamed(context, '/');
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}

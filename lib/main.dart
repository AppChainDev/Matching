import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'state/user_state.dart';
import 'state/settings_state.dart';
import 'services/userapi_service.dart';
import 'routes.dart';

void main() async{
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          final authProvider = UserState(userApiService: UserApiService(baseUrl: 'http://localhost:5000'));
          authProvider.checkAuthStatus().then((_) {
            authProvider.scheduleTokenRefresh();
          });
          return authProvider;
        }),
        ChangeNotifierProvider(
          create: (_) => UserState(userApiService: UserApiService(baseUrl: 'http://localhost:5000')),
        ),
        ChangeNotifierProvider(create: (_) => SettingsState()),
      ],
      child: MaterialApp(
        title: 'My Matching App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
          fontFamily: "HiraginoMinchoPro"
        ),
        routes: Routes.routes,
        initialRoute: '/',
      ),
    );
  }
}

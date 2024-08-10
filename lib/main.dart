import 'package:drone/services/postapi_service.dart';
import 'package:drone/services/likeapi_service.dart';
import 'package:drone/services/recordapi_service.dart';
import 'package:drone/state/like_state.dart';
import 'package:drone/state/post_state.dart';
import 'package:drone/state/record_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'state/user_state.dart';
import 'state/settings_state.dart';
import 'services/userapi_service.dart';
import 'routes.dart';

void main() async{
  runApp(const MyApp());
  await dotenv.load();
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
          create: (_) => UserState(userApiService: UserApiService(baseUrl: dotenv.get('BASE_URL'))),
        ),
        ChangeNotifierProvider(
          create: (_) => RecordState(recordApiService: RecordApiService(baseUrl: dotenv.get('BASE_URL'))),
        ),
        ChangeNotifierProvider(
          create: (_) => LikeState(likeApiService: LikeApiService(baseUrl: dotenv.get('BASE_URL'))),
        ),
        ChangeNotifierProvider(
          create: (_) => PostState(postApiService: PostApiService(baseUrl: dotenv.get('BASE_URL'))),
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

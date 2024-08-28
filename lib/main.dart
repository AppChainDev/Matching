import 'package:rinlin/services/blockapi_service.dart';
import 'package:rinlin/services/notificationapi_service.dart';
import 'package:rinlin/services/postapi_service.dart';
import 'package:rinlin/services/likeapi_service.dart';
import 'package:rinlin/services/recordapi_service.dart';
import 'package:rinlin/state/block_state.dart';
import 'package:rinlin/state/like_state.dart';
import 'package:rinlin/state/notification_state.dart';
import 'package:rinlin/state/post_state.dart';
import 'package:rinlin/state/record_state.dart';
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
        ChangeNotifierProvider(
          create: (_) => BlockState(blockApiService: BlockApiService(baseUrl: dotenv.get('BASE_URL'))),
        ),
        ChangeNotifierProvider(
          create: (_) => NotificationState(notificationApiService: NotificationApiService(baseUrl: dotenv.get('BASE_URL'))),
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

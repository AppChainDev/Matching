import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_line_sdk/flutter_line_sdk.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:rinlin/firebase_options.dart';
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

void main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize(dotenv.get('APP_ID'));
  OneSignal.Notifications.requestPermission(true);
  LineSDK.instance.setup(dotenv.get('CHANNEL_ID')).then((_) {
    print("LineSDK Prepared");
  });
  // debugPaintSizeEnabled = true;
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    String? screen;
    OneSignal.Notifications.addClickListener((event) {
      final data = event.notification.additionalData;
      screen = data?["screen"];
      // Navigator.pushNamed(context, "/matching_complete", arguments: MatchingModel(id: widget.id, avatar: widget.avatarImage, name: widget.name));
      if (screen != null) {
        if (screen == "message") {
          navigatorKey.currentState?.pushNamed("/chattinglist");
        }
        if (screen == "like") {
          navigatorKey.currentState?.pushNamed("/likelist");
        }
        if (screen == "record") {
          navigatorKey.currentState?.pushNamed("/record_list");
        }
      }
    });
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserState(
              userApiService: UserApiService(baseUrl: dotenv.get('BASE_URL'))),
        ),
        ChangeNotifierProvider(
          create: (_) => RecordState(
              recordApiService:
                  RecordApiService(baseUrl: dotenv.get('BASE_URL'))),
        ),
        ChangeNotifierProvider(
          create: (_) => LikeState(
              likeApiService: LikeApiService(baseUrl: dotenv.get('BASE_URL'))),
        ),
        ChangeNotifierProvider(
          create: (_) => PostState(
              postApiService: PostApiService(baseUrl: dotenv.get('BASE_URL'))),
        ),
        ChangeNotifierProvider(
          create: (_) => BlockState(
              blockApiService:
                  BlockApiService(baseUrl: dotenv.get('BASE_URL'))),
        ),
        ChangeNotifierProvider(
          create: (_) => NotificationState(
              notificationApiService:
                  NotificationApiService(baseUrl: dotenv.get('BASE_URL'))),
        ),
        ChangeNotifierProvider(create: (_) => SettingsState()),
      ],
      child: MaterialApp(
        title: 'My Matching App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.green, fontFamily: "HiraginoMinchoPro"),
        navigatorKey: navigatorKey,
        routes: Routes.routes,
        initialRoute: '/',
      ),
    );
  }
}

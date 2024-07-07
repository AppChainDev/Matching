import 'package:drone/screens/auth/loginhome_screen.dart';
import 'package:drone/screens/auth/phone_screen.dart';
import 'package:drone/screens/auth/phoneverify_screen.dart';
import 'package:drone/screens/client/job/clientjobdetail_screen.dart';
import 'package:drone/screens/client/job/clientjoblist_screen.dart';
import 'package:drone/screens/client/payment/paymentdetail_screen.dart';
import 'package:drone/screens/client/payment/paymentlist_screen.dart';
import 'package:drone/screens/client/request/request_screen.dart';
import 'package:drone/screens/client/request/requestconfirm_screen.dart';
import 'package:drone/screens/client/request/requestsuccess_screen.dart';
import 'package:drone/screens/client/settingpilot_screen.dart';
import 'package:drone/screens/login_screen.dart';
import 'package:drone/screens/mailsend_alert_screen.dart';
import 'package:drone/screens/mailsend_screen.dart';
import 'package:drone/screens/client/findpilot_screen.dart';
import 'package:drone/screens/client/pilotprofile_screen.dart';
import 'package:drone/screens/register/preferences.dart';
import 'package:drone/screens/register/registerprofile_first.dart';
import 'package:drone/screens/register/registerprofile_fourth.dart';
import 'package:drone/screens/register/registerprofile_group.dart';
import 'package:drone/screens/register/registerprofile_photo.dart';
import 'package:drone/screens/register/registerprofile_second.dart';
import 'package:drone/screens/register/registerprofile_third.dart';
import 'package:flutter/material.dart';
import 'package:drone/screens/first_screen.dart';
import 'screens/home_screen.dart';

class Routes {
  static final Map<String, WidgetBuilder> routes = {
    '/': (context) => const FirstScreen(),
    '/mailsend': (context) => MailSendScreen(),
    '/mailsendalert': (context) => MailSendAlertScreen(),
    '/login': (context) => LoginScreen(),
    '/loginhome': (context) => const LoginHomeScreen(),
    '/phone': (context) => const PhoneScreen(),
    '/phoneverify': (context) => const PhoneVerifyScreen(),
    '/registerprofile_first': (context) => const RegisterProfileFirstScreen(),
    '/registerprofile_second': (context) => const RegisterProfileSecondScreen(),
    '/registerprofile_third': (context) => const RegisterProfileThirdScreen(),
    '/registerprofile_photo': (context) => const RegisterProfilePhotoScreen(),
    '/registerprofile_fourth': (context) => const RegisterProfileFourthScreen(),
    '/registerprofile_group': (context) => const RegisterProfileGroupScreen(),
    '/preference': (context) => const PreferenceScreen(),
    '/findpilot': (context) => FindPilotScreen(),
    '/settingpilot': (context) => SettingPilotScreen(),
    '/pilotprofile': (context) => PilotProfileScreen(),
    '/request': (context) => RequestScreen(),
    '/requestconfirm': (context) => RequestConfirmScreen(),
    '/requestsuccess': (context) => RequestSuccessScreen(),
    '/clientjoblist': (context) => ClientJobListScreen(),
    '/clientjobdetail': (context) => ClientJobDetailScreen(),
    '/paymentlist': (context) => PaymentListScreen(),
    '/paymentdetail': (context) => PaymentDetailScreen(),
    '/home': (context) => const HomeScreen(),
  };
}

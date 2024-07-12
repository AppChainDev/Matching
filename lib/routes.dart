import 'package:drone/screens/agreement/agreement.dart';
import 'package:drone/screens/agreement/agreement_chatlist.dart';
import 'package:drone/screens/agreement/matching_complete.dart';
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
import 'package:drone/screens/male/male_mypage.dart';
import 'package:drone/screens/profile/view_profile.dart';
import 'package:drone/screens/record/record_empty.dart';
import 'package:drone/screens/record/record_list.dart';
import 'package:drone/screens/register/introduce.dart';
import 'package:drone/screens/register/preferences.dart';
import 'package:drone/screens/register/registerprofile_first.dart';
import 'package:drone/screens/register/registerprofile_fourth.dart';
import 'package:drone/screens/register/registerprofile_group.dart';
import 'package:drone/screens/register/registerprofile_photo.dart';
import 'package:drone/screens/register/registerprofile_second.dart';
import 'package:drone/screens/register/registerprofile_third.dart';
import 'package:drone/screens/support/support_screen.dart';
import 'package:flutter/material.dart';
import 'package:drone/screens/first_screen.dart';
class Routes {
  static final Map<String, WidgetBuilder> routes = {
    '/': (context) => const FirstScreen(),
    '/agreement': (context) => const AgreementScreen(),
    '/agreenment_chatlist': (context) => const AgreementChatListScreen(),
    '/login': (context) => LoginScreen(),
    '/matching_complete': (context) => const MatchingCompleteScreen(),
    '/phone': (context) => const PhoneScreen(),
    '/phoneverify': (context) => const PhoneVerifyScreen(),
    '/registerprofile_first': (context) => const RegisterProfileFirstScreen(),
    '/registerprofile_second': (context) => const RegisterProfileSecondScreen(),
    '/registerprofile_third': (context) => const RegisterProfileThirdScreen(),
    '/registerprofile_photo': (context) => const RegisterProfilePhotoScreen(),
    '/registerprofile_fourth': (context) => const RegisterProfileFourthScreen(),
    '/registerprofile_group': (context) => const RegisterProfileGroupScreen(),
    '/preference': (context) => const PreferenceScreen(),
    '/introduce': (context) => const IntroduceScreen(),
    '/malemypage': (context) => const MaleMyPage(),
    '/support': (context) => const SupportScreen(),
    '/record_list': (context) => const RecordListScreen(),
    '/record_empty': (context) => const RecordEmptyScreen(),
    '/view_profile': (context) => const ViewProfileScreen(),
    '/request': (context) => RequestScreen(),
    '/requestconfirm': (context) => RequestConfirmScreen(),
    '/requestsuccess': (context) => RequestSuccessScreen(),
    '/clientjoblist': (context) => ClientJobListScreen(),
    '/clientjobdetail': (context) => ClientJobDetailScreen(),
    '/paymentlist': (context) => PaymentListScreen(),
    '/paymentdetail': (context) => PaymentDetailScreen(),
  };
}

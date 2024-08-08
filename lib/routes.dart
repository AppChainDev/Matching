import 'package:drone/screens/agreement/agreement.dart';
import 'package:drone/screens/agreement/agreement_chatlist.dart';
import 'package:drone/screens/agreement/matching_complete.dart';
import 'package:drone/screens/auth/loginhome_screen.dart';
import 'package:drone/screens/auth/phone_screen.dart';
import 'package:drone/screens/auth/phoneverify_screen.dart';
import 'package:drone/screens/chatting/chatinglist_screen.dart';
import 'package:drone/screens/chatting/chattingdetail_screen.dart';
import 'package:drone/screens/chatting/editphrase_screen.dart';
import 'package:drone/screens/chatting/violation_screen.dart';
import 'package:drone/screens/chatting/violationconfirm_screen.dart';
import 'package:drone/screens/female/female_mypage.dart';
import 'package:drone/screens/like/like_screen.dart';
import 'package:drone/screens/login_screen.dart';
import 'package:drone/screens/male/male_mypage.dart';
import 'package:drone/screens/notification/notification.dart';
import 'package:drone/screens/notification/notification_detail.dart';
import 'package:drone/screens/plan/plan_screen.dart';
import 'package:drone/screens/post/create_post.dart';
import 'package:drone/screens/post/postpage.dart';
import 'package:drone/screens/profile/component/edit_introductoin.dart';
import 'package:drone/screens/profile/component/group/group_edit.dart';
import 'package:drone/screens/profile/component/memories/favorite_description.dart';
import 'package:drone/screens/profile/component/profileinformation/edit_name.dart';
import 'package:drone/screens/profile/component/question/question1.dart';
import 'package:drone/screens/profile/component/question/question2.dart';
import 'package:drone/screens/profile/component/question/question3.dart';
import 'package:drone/screens/profile/edit_profile.dart';
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
import 'package:drone/screens/setting/account/delete_account.dart';
import 'package:drone/screens/setting/blockaccount/block_list.dart';
import 'package:drone/screens/setting/notification/notification_setting.dart';
import 'package:drone/screens/setting/settings.dart';
import 'package:drone/screens/support/support_screen.dart';
import 'package:drone/screens/swipe/groupmember_screen.dart';
import 'package:drone/screens/swipe/swipe_message_screen.dart';
import 'package:drone/screens/swipe/swipe_screen.dart';
import 'package:drone/screens/verify/verify_screen.dart';
import 'package:drone/screens/verify/verifysend_screen.dart';
import 'package:drone/screens/verify/verifywaiting_screen.dart';
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
    '/loginhome': (context) => const LoginHomeScreen(),
    '/registerprofile_first': (context) => const RegisterProfileFirstScreen(),
    '/registerprofile_second': (context) => const RegisterProfileSecondScreen(),
    '/registerprofile_third': (context) => const RegisterProfileThirdScreen(),
    '/registerprofile_photo': (context) => const RegisterProfilePhotoScreen(),
    '/registerprofile_fourth': (context) => const RegisterProfileFourthScreen(),
    '/registerprofile_group': (context) => const RegisterProfileGroupScreen(),
    '/preference': (context) => const PreferenceScreen(),
    '/introduce': (context) => const IntroduceScreen(),
    '/edit_introduce': (context) => const EditIntroduceScreen(),
    '/malemypage': (context) => const MaleMyPage(),
    '/femalemypage': (context) => const FemaleMyPage(),
    '/support': (context) => const SupportScreen(),
    '/record_list': (context) => const RecordListScreen(),
    '/record_empty': (context) => const RecordEmptyScreen(),
    '/notification': (context) => const NotificationScreen(),
    '/notification_detail': (context) => const NotificationDetailScreen(),
    '/setting': (context) => const SettingScreen(),
    '/block_list': (context) => const BlockListScreen(),
    '/notification_setting': (context) => const NotificationSettingScreen(),
    '/delete_account': (context) => const DeleteAccountScreen(),
    '/view_profile': (context) => const ViewProfileScreen(),
    '/edit_profile': (context) => const EditProfileScreen(),
    '/question1': (context) => const Question1Screen(),
    '/question2': (context) => const Question2Screen(),
    '/question3': (context) => const Question3Screen(),
    '/favorite_description': (context) => const FavoriteDescriptionWidget(),
    '/edit_name': (context) => const EditNameScreen(),
    '/edit_group': (context) => const GroupEditScreen(),
    '/postpage': (context) => const PostScreen(),
    '/create_post': (context) => const CreatePostScreen(),
    '/likelist': (context) => const LikeListScreen(),
    '/chattinglist': (context) => const ChattingListScreen(),
    '/chatting_detail': (context) => const ChattingDetailScreen(),
    '/edit_phrase': (context) => const EditPhraseScreen(),
    '/violation_screen': (context) => const ViolationScreen(),
    '/violationconfirm_screen': (context) => const ViolationConfirmScreen(),
    '/swipe': (context) => const SwipeScreen(),
    '/group_member': (context) => const GroupMemberScreen(),
    '/messagescreen': (context) => const SwipeMessageScreen(),

    '/planscreen': (context) => const PlanScreen(),
    '/verifyscreen': (context) => const VerifyScreen(),
    '/verify_send': (context) => const VerifySendScreen(),
    '/verify_waiting': (context) => const VerifyWaitingScreen(),

  };
}

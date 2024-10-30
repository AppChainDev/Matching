import 'package:rinlin/components/app_colors.dart';
import 'package:rinlin/components/base_screen.dart';
import 'package:rinlin/components/custom_container.dart';
import 'package:rinlin/components/custom_text.dart';
import 'package:rinlin/components/message/received_support_message_card.dart';
import 'package:rinlin/components/message/send_support_message_card.dart';
import 'package:flutter/material.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  final TextEditingController introduceController = TextEditingController();
  int textCount = 0;
  final List<Widget> messages = [
    const ReceivedSupportMessageItem(text: "こんにちは。こちらは公式サポートへの相談チャットになります。"),
    const ReceivedSupportMessageItem(text: "お困りごとやアプリに対しての意見などをご送信ください。順次担当が確認します。"),
    const SendSupportMessageItem(text: "魅力的なプロフィール文がわかりません。\nおすすめを教えて欲しいです。\n自分なりの。\nお願いします。")
  ];

  @override
  void initState() {
    super.initState();
    introduceController.addListener(_updateButtonColor);
  }

  @override
  void dispose() {
    introduceController.removeListener(_updateButtonColor);
    introduceController.dispose();
    super.dispose();
  }

  void _updateButtonColor() {
    setState(() {
      textCount = introduceController.text.length;
    });
  }

  void _sendMessage() {
    if (introduceController.text.isNotEmpty) {
      setState(() {
        messages.add(SendSupportMessageItem(text: introduceController.text));
        introduceController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return BaseScreen(
      child: Stack(
        children: [
          Center(
            child: CustomContainer(
              decoration: BoxDecoration(
                color: AppColors.primaryBlack.withOpacity(0.5),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Container(
                  height: MediaQuery.of(context).size.height - 40,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: AppColors.primaryWhite,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: CustomText(
                                text: "とじる",
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                lineHeight: 1,
                                letterSpacing: 1,
                                color: AppColors.secondaryGreen,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CustomText(
                              text: "公式サポート",
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              lineHeight: 1,
                              letterSpacing: 1,
                              color: AppColors.primaryBlack,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: messages,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: bottomInset != 0 ? bottomInset : 0,
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.only(top: 8),
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                color: AppColors.secondaryGray.withOpacity(0.5),
                                width: 2,
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 317,
                                height: 65,
                                child: TextField(
                                  controller: introduceController,
                                  textAlign: TextAlign.left,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  cursorColor: AppColors.primaryBlack,
                                  style: TextStyle(
                                    color: AppColors.primaryBlack,
                                  ),
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.secondaryGray.withOpacity(0.5),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.secondaryGray.withOpacity(0.5),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: 15,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 14),
                              IconButton(
                                onPressed: _sendMessage,
                                icon: Icon(
                                  Icons.send,
                                  color: AppColors.secondaryGreen,
                                  size: 40,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

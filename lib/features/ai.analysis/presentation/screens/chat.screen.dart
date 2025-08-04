import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mentaura_app/core/widgets/dialogs.dart';
import 'package:mentaura_app/features/mood.history/providers/activity.provider.dart';
import 'package:mentaura_app/features/ai.analysis/providers/chat.provider.dart';
import 'package:mentaura_app/core/theme/color.palette.dart';
import 'package:mentaura_app/core/extensions.dart';
import 'package:mentaura_app/features/ai.analysis/models/emotion.history.model.dart';
import 'package:mentaura_app/features/ai.analysis/presentation/screens/ai.analysis.screen.dart';
import 'package:mentaura_app/features/ai.analysis/presentation/widgets/chat.widgets/chat.textfield.dart';
import 'package:mentaura_app/features/ai.analysis/presentation/widgets/chat.widgets/done.button.widget.dart';
import 'package:mentaura_app/features/ai.analysis/presentation/widgets/chat.widgets/mic.word.field.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../widgets/chat.widgets/hidden.textfield.kboard.dart';
import '../widgets/chat.widgets/main.mic.button.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final SpeechToText _speechToText = SpeechToText();
  final TextEditingController _emotionTextController = TextEditingController();
  final FocusNode _emotionTextfieldFocus = FocusNode();

  bool _speechEnabled = false;

  @override
  void initState() {
    _initSpeech();
    super.initState();
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();

    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(
      onResult: _onSpeechResult,
    );
  }

  Future<void> _stopListening() async {
    await _speechToText.stop();
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    ref.read(lastWordProvider.notifier).state = result.recognizedWords;
  }

  @override
  Widget build(BuildContext context) {
    final isKeyBoard = ref.watch(keyboardProvider);
    return Container(
      width: context.width(),
      decoration: BoxDecoration(
          color: Palette.backgroundColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            children: [
              Divider(
                color: Palette.lightTextColor,
                endIndent: 170,
                indent: 170,
                thickness: 3,
              ),
              SizedBox(height: 25.h),
              CircleAvatar(
                radius: 23,
                backgroundColor: Palette.backgroundColor,
                backgroundImage:
                    AssetImage("assets/images/mentaura_logo_black.png"),
              ),
              SizedBox(height: 10.h),
              // ------------------------- Textfield for typing emotion -------------------------//////////
              isKeyBoard
                  ? ChatTextField(
                      emotionTextfieldFocus: _emotionTextfieldFocus,
                      emotionTextController: _emotionTextController,
                      onchanged: (value) {
                        ref.read(lastWordProvider.notifier).state = value;
                      },
                    )

// ---------------Field for mic recogized words -------------------------------//
                  : Consumer(
                      builder: (context, ref, child) {
                        final lastWords = ref.watch(lastWordProvider);
                        return MicWordsField(
                            speechEnabled: _speechEnabled,
                            lastWords: lastWords);
                      },
                    ),
              const Spacer(),
            ],
          ),

          ///-------------------------Bottom Console------------------------------------///

          AnimatedPadding(
            duration: const Duration(milliseconds: 300),
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  width: context.width(),
                  height: context.width() * .30,
                  decoration: BoxDecoration(
                      color: Palette.kWhiteColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.elliptical(70, 70),
                          topRight: Radius.elliptical(70, 70))),
                ),

                ///-----------------listen showing widget bottom center --------------------------///

                Padding(
                  padding: EdgeInsets.only(bottom: 25.h),
                  child: Text((isKeyBoard == false &&
                          _speechToText.lastStatus == "listening")
                      ? "Listening.."
                      : ""),
                ),

//------------------------------Main mic button --------------------------------//

                Consumer(
                  builder: (context, ref, child) {
                    final statusListener = ref.watch(micListeningProvider);
                    return MainMicButton(
                      speechToText: _speechToText,
                      statusListener: statusListener,
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        _emotionTextController.clear();
                        _speechToText.statusListener = (status) {
                          ref.read(micListeningProvider.notifier).state =
                              status;
                        };
                        if (_speechToText.isNotListening) {
                          _startListening();
                          ref.read(lastWordProvider.notifier).state = "";
                          ref.read(keyboardProvider.notifier).state = false;
                        } else {
                          _stopListening();
                        }
                      },
                    );
                  },
                ),
//------- ----------------keyboard button --------------------------//

                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: CircleAvatar(
                        backgroundColor: Palette.backgroundColor,
                        radius: 31,
                        child: SvgPicture.asset(
                            color: Palette.errorColor,
                            "assets/images/svg/keyboard_icon.svg")),
                  ),
                ),

// --------------Hidden Textfield on keyboard Icon for keyboard funtonalities ---------------------//

                HiddenTextFieldOnKBoard(
                  onTap: () {
                    _emotionTextfieldFocus.requestFocus();
                    ref.read(lastWordProvider.notifier).state = "";
                    ref.read(keyboardProvider.notifier).state = true;
                    if (_speechToText.isListening) {
                      _stopListening();
                    }
                  },
                ),

                ///----------------------------- Done Button -------------------------------//
                DoneButtonWidget(onPressed: () => analyzeMoodAndSave())
              ],
            ),
          ),
        ],
      ),
    );
  }

  void analyzeMoodAndSave() async {
    final userMessage = ref.read(lastWordProvider);
    final navContext = Navigator.of(context);
    if (userMessage.isEmpty) {
      Fluttertoast.showToast(msg: "Type or Say something to detect emotion");
    } else {
      AppDialogs.showAIAnalyzLoader(context: context);
      final emotionResp =
          await ref.read(geminiRepositoryProvider).analyzeEmotion(userMessage);

      ref
          .read(emotionDetailsNotifierProvider.notifier)
          .updateEmotionDetails(emotionResp);
      final emotionsDetails = ref.read(emotionDetailsNotifierProvider);
      final newMoodHistory = EmotionHistoryModel(
          emotion: emotionsDetails.emotion,
          confidence: emotionsDetails.confidence,
          chatTitle: emotionsDetails.chatTitle,
          createdDateTime: DateTime.now(),
          userMessage: userMessage,
          suggestedReplyTitle: emotionsDetails.suggestedReplyTitle,
          suggestedReply: emotionsDetails.suggestedReply,
          activityTitle: emotionsDetails.activityTitle,
          explanation: emotionsDetails.explanation);

      final historyId = await ref
          .read(emotionHistoryRepositoryProvider)
          .createNewEmotion(newMoodHistory);
      final newMoodHistoryWithId = newMoodHistory.copyWith(id: historyId);
      log("Mood with id ${newMoodHistoryWithId.id}");

      ref
          .read(emotionHistoryNotifierProvider.notifier)
          .addNewMoodHistory(newMoodHistoryWithId);

      await Future.delayed(Duration(milliseconds: 1200));
      navContext.pop();
      navContext.pop();
      navContext.pushNamed(AiAnalysisScreen.routeName);
    }
  }

  @override
  void dispose() {
    _stopListening();
    _emotionTextController.dispose();

    super.dispose();
  }
}

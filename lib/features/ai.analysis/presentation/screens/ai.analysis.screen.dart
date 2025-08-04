import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mentaura_app/core/extensions.dart';
import 'package:mentaura_app/core/theme/color.palette.dart';
import 'package:mentaura_app/core/theme/text.styles.dart';
import 'package:mentaura_app/core/utils/string.utils.dart';
import 'package:mentaura_app/core/widgets/dashed.line.divider.dart';
import 'package:mentaura_app/core/widgets/ui_components/rotating.logo.dart';
import 'package:mentaura_app/features/ai.analysis/providers/chat.provider.dart';
import 'package:mentaura_app/features/home/presentation/widgets/title.with.divider.widget.dart';

import '../widgets/chat.result.widgets/card.title.widget.dart';
import '../widgets/chat.result.widgets/spotify.suggestions.widget.dart';
import '../widgets/chat.result.widgets/suggested.activity.widget.dart';

class AiAnalysisScreen extends ConsumerStatefulWidget {
  static const routeName = "/chatAnalysis";
  const AiAnalysisScreen({super.key});

  @override
  ConsumerState<AiAnalysisScreen> createState() => _AiAnalysisScreenState();
}

class _AiAnalysisScreenState extends ConsumerState<AiAnalysisScreen>
    with TickerProviderStateMixin {
  bool isExpand = false;
  late AnimationController _controller;
  late Animation<double> _fadeTransition;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));

    _fadeTransition = Tween<double>(begin: .5, end: 1).animate(_controller);

    Future.delayed(Duration(milliseconds: 500)).then((value) {
      _controller.forward();
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
    SystemChrome.restoreSystemUIOverlays();
  }

  @override
  Widget build(BuildContext context) {
    final emotionDetails = ref.read(emotionDetailsNotifierProvider);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Palette.backgroundColor,
        statusBarBrightness: Brightness.light,
      ),
    );
    return SafeArea(
      child: Scaffold(
        backgroundColor: Palette.kWhiteColor,
        appBar: AppBar(
          backgroundColor: Palette.backgroundColor,
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "AI",
                style: CustomTextStyles.subtitleLargeBold(
                    color: Palette.primaryBlackColor, fontSize: 14),
              ),
              SvgPicture.asset(
                height: 12,
                width: 12,
                "assets/images/svg/ai_stars.svg",
                color: Palette.primaryBlackColor,
              ),
              Text(
                " Analysis.",
                style: CustomTextStyles.subtitleLargeBold(
                    color: Palette.primaryBlackColor, fontSize: 15),
              ),
            ],
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back,
                color: Palette.primaryBlackColor,
              )),
        ),
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: context.width(),
                padding: EdgeInsets.only(bottom: 15.h),
                decoration: BoxDecoration(
                    // border:
                    //     Border.all(color: Palette.kThirdGreenColor, width: .5),
                    color: Palette.backgroundColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.elliptical(40, 50),
                        bottomRight: Radius.elliptical(40, 50))),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 13.h),
                  child: Column(
                    children: [
                      ScaleTransition(
                        scale: _fadeTransition,
                        child: Container(
                          width: 55.h,
                          height: 55.h,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Palette.primaryBlackColor),
                              shape: BoxShape.circle,
                              color: Palette.emojiBgColor),
                          child: Center(
                            child: SvgPicture.asset(
                              StringUtil.getEmoji(emotionDetails.emotion),
                              height: 37.h,
                              width: 37.w,
                              fit: BoxFit.cover,
                              color: Palette.primaryBlackColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      // Container(
                      //   decoration: BoxDecoration(
                      //       color: Palette.quoteBgColor,
                      //       borderRadius: BorderRadius.circular(10.r)),
                      //   padding:
                      //       EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      //   child: Text(
                      //     "Looks like you're feeling ${emotionDetails.emotion[0].toUpperCase() + emotionDetails.emotion.substring(1)}",
                      //     style: CustomTextStyles.subtitleLargeBold(),
                      //   ),
                      // ),
                      SizedBox(height: 12.h),
                      Text(
                        emotionDetails.suggestedReplyTitle,
                        style: CustomTextStyles.titleLargeBold(
                            color: Palette.primaryBlackColor),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Container(
                        width: context.width(),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Palette.kSecondaryGreenColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Text(
                          emotionDetails.suggestedReply,
                          style: CustomTextStyles.subtitleLargeSemiBold(
                              color: Palette.backgroundColor),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Container(
                  width: context.width(),
                  color: Palette.kWhiteColor,
                  child: SingleChildScrollView(
                    child: Column(
                      spacing: 7,
                      children: [
                        TitleWithDividerWidget(title: 'Activity'),
                        SuggestedActivityWidget(emotionDetails: emotionDetails),
                        SizedBox(height: 2.h),
                        Container(
                          width: context.width(),
                          decoration: BoxDecoration(
                            color: Palette.backgroundColor,
                            border: Border(
                              top: BorderSide(
                                  color: Palette.kGreyColor, width: .3),
                              left: BorderSide(
                                  color: Palette.kGreyColor, width: .3),
                              right: BorderSide(
                                  color: Palette.kGreyColor, width: .3),
                              bottom: BorderSide(
                                  color: Palette.kGreyColor, width: .3),
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.r)),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 14.h,
                                left: 15.w,
                                bottom: 14.h,
                                right: 10.w),
                            child: Row(
                              children: [
                                Column(
                                  spacing: 5,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Something on your mind?",
                                      style: CustomTextStyles.subtitleLargeBold(
                                          color: Palette.primaryBlackColor),
                                    ),
                                    Text(
                                      "Write a little note about how you're feeling",
                                      style: CustomTextStyles
                                          .subtitleSmallSemiBold(fontSize: 11),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Container(
                                  width: context.width() * .22,
                                  decoration: BoxDecoration(
                                    color: Palette.kSecondaryGreenColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12.r)),
                                  ),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 6.h),
                                    child: Center(
                                      child: Text(
                                        "Write a note",
                                        style: CustomTextStyles
                                            .subtitleLargeSemiBold(
                                                fontSize: 11,
                                                color: Palette.kWhiteColor),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 2.h),
                        TitleWithDividerWidget(title: 'Recommendations'),
                        Consumer(
                          builder: (context, ref, child) {
                            final asyncValue = ref.watch(
                                spotifySuggestionsFutureProvider(
                                    emotionDetails.emotion));
                            return asyncValue.when(data: (spotifySuggestions) {
                              return Column(
                                children: [
                                  CardTitleWidget(
                                    title: "Made for Your Mood",
                                    bgColor: Palette.yellowAccent,
                                    isPrefixiImage: false,
                                    fontZise: 11,
                                    titleColor: Palette.kPrimaryGreenColor,
                                    padding: EdgeInsets.symmetric(vertical: 3),
                                  ),
                                  Container(
                                    width: context.width(),
                                    decoration: BoxDecoration(
                                      color: Palette.kWhiteColor,
                                      border: Border(
                                        left: BorderSide(
                                            color: Palette.kGreyColor,
                                            width: .3),
                                        right: BorderSide(
                                            color: Palette.kGreyColor,
                                            width: .3),
                                        bottom: BorderSide(
                                            color: Palette.kGreyColor,
                                            width: .3),
                                      ),
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(12.r),
                                          bottomRight: Radius.circular(12.r)),
                                    ),
                                    child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 5, left: 10, bottom: 5),
                                        child: Column(
                                          children: [
                                            spotifySuggestions.playlist != null
                                                ? SpotifySuggestionsWidget(
                                                    name:
                                                        "Songs That Make You Feel Like Everything Will Be Okay",
                                                    // spotifySuggestions
                                                    //         .playlist?.name ??
                                                    //     "",
                                                    icon: Icons
                                                        .music_note_outlined,
                                                    cardName: "Playlist",
                                                    spotifyUrl:
                                                        spotifySuggestions
                                                                .playlist
                                                                ?.spotifyUrl ??
                                                            "")
                                                : const SizedBox(),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8,
                                                  bottom: 8,
                                                  left: 10,
                                                  right: 15),
                                              child: DashedLine(
                                                color: Palette.kGreyColor,
                                                height: .3,
                                              ),
                                            ),
                                            spotifySuggestions.podcast != null
                                                ? SpotifySuggestionsWidget(
                                                    name: spotifySuggestions
                                                            .podcast?.name ??
                                                        "",
                                                    icon: Icons.podcasts,
                                                    cardName: "Podcast",
                                                    spotifyUrl:
                                                        spotifySuggestions
                                                                .podcast
                                                                ?.spotifyUrl ??
                                                            "")
                                                : const SizedBox()
                                          ],
                                        )),
                                  ),
                                ],
                              );
                            }, error: (err, st) {
                              return Center(
                                child: Text("Something Went Wrong"),
                              );
                            }, loading: () {
                              return Column(
                                children: [
                                  SizedBox(
                                    height: 25.h,
                                  ),
                                  Center(child: RotatingLogo())
                                ],
                              );
                            });
                          },
                        ),
                        SizedBox(height: 10.h),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class SpotifySuggestionsWidget extends StatelessWidget {
//   final String thumbnail;
//   final String name;
//   final String description;
//   final IconData iconData;
//   final String title;
//   final String openingUrl;

//   const SpotifySuggestionsWidget({
//     super.key,
//     required this.thumbnail,
//     required this.name,
//     required this.description,
//     required this.iconData,
//     required this.title,
//     required this.openingUrl,
//   });

//   String? extractSpotifyId(String url) {
//     try {
//       Uri uri = Uri.parse(url);
//       // Check if it's a valid Spotify link
//       if (uri.host.contains("spotify.com")) {
//         // Path looks like: /playlist/<id> or /show/<id>
//         final segments = uri.pathSegments;
//         if (segments.length >= 2) {
//           return segments[1]; // This is the ID
//         }
//       }
//       return null;
//     } catch (e) {
//       return null;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Container(
//           width: context.width() * .25,
//           height: context.width() * .25,
//           decoration: BoxDecoration(
//             color: Palette.yellowAccent,
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(12.r),
//               bottomLeft: Radius.circular(12.r),
//             ),
//             // image: DecorationImage(
//             //     image: title == "Playlist"
//             //         ? AssetImage(
//             //             "assets/images/playlist_image.jpg",
//             //           )
//             //         : AssetImage(
//             //             "assets/images/podcast_image.jpg",
//             //           ),
//             //     fit: BoxFit.cover,
//             //     filterQuality: FilterQuality.high)
//           ),
//           child: Center(
//             child: Icon(
//               iconData,
//               size: 50,
//               color: Palette.primaryBlackColor,
//             ),
//           ),
//         ),
//         Expanded(
//           child: Container(
//             width: context.width(),
//             height: context.width() * .25,
//             decoration: BoxDecoration(
//                 border: Border(
//                   top: BorderSide(color: Palette.kGreyColor, width: .3),
//                   right: BorderSide(color: Palette.kGreyColor, width: .3),
//                   bottom: BorderSide(color: Palette.kGreyColor, width: .3),
//                 ),
//                 borderRadius: BorderRadius.only(
//                   topRight: Radius.circular(12.r),
//                   bottomRight: Radius.circular(12.r),
//                 ),
//                 color: Palette.kWhiteColor),
//             child: Padding(
//               padding: EdgeInsets.only(left: 10.w),
//               child: Column(
//                 spacing: 5,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(
//                     height: 8.h,
//                   ),
//                   Row(
//                     spacing: 3,
//                     children: [
//                       // Icon(
//                       //   iconData,
//                       //   color: Palette.errorColor,
//                       //   size: 15,
//                       // ),
//                       Text(
//                         title,
//                         style: CustomTextStyles.subtitleSmallSemiBold(
//                             color: Palette.errorColor),
//                       )
//                     ],
//                   ),
//                   Text(
//                     name.replaceAll(emojiRegex, ''),
//                     style: CustomTextStyles.subtitleLargeBold(
//                         color: Palette.primaryTextColor),
//                   ),
//                   // Text(
//                   //   description,
//                   //   style: CustomTextStyles.subtitleSmallSemiBold(
//                   //       color: Palette.primaryTextColor),
//                   // )

//                   InkWell(
//                     onTap: () async {
//                       final spotifyId = extractSpotifyId(openingUrl);
//                       final type = title == "playlist" ? title : "show";
//                       final spotifyOpeningUrl =
//                           Uri.parse("spotify:$type:$spotifyId");
//                       if (await canLaunchUrl(spotifyOpeningUrl)) {
//                         await launchUrl(spotifyOpeningUrl);
//                       } else {
//                         await launchUrl(Uri.parse(openingUrl),
//                             mode: LaunchMode.externalApplication);
//                       }
//                     },
//                     child: Container(
//                       height: 23.h,
//                       decoration: BoxDecoration(
//                           color: Palette.kWhiteColor,
//                           borderRadius: BorderRadius.all(Radius.circular(15))),
//                       child: Row(
//                         children: [
//                           SvgPicture.asset(
//                             "assets/images/svg/spotify_logo.svg",
//                             width: 40.w,
//                             height: 40.h,
//                             fit: BoxFit.fitWidth,
//                             color: Palette.kPrimaryGreenColor,
//                           ),
//                           Icon(
//                             Icons.chevron_right,
//                             size: 18,
//                             color: Palette.kPrimaryGreenColor,
//                           )
//                         ],
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

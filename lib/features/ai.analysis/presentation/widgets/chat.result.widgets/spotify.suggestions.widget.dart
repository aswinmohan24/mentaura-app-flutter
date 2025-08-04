import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mentaura_app/core/theme/text.styles.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/constants/string.constants.dart';
import '../../../../../core/theme/color.palette.dart';

class SpotifySuggestionsWidget extends StatelessWidget {
  final String name;
  final IconData icon;
  final String cardName;
  final String spotifyUrl;
  const SpotifySuggestionsWidget({
    super.key,
    required this.name,
    required this.icon,
    required this.cardName,
    required this.spotifyUrl,
  });

  String? extractSpotifyId(String url) {
    try {
      Uri uri = Uri.parse(url);
      // Check if it's a valid Spotify link
      if (uri.host.contains("spotify.com")) {
        // Path looks like: /playlist/<id> or /show/<id>
        final segments = uri.pathSegments;
        if (segments.length >= 2) {
          return segments[1]; // This is the ID
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      child: Row(
        children: [
          Icon(
            icon,
            size: 29,
            color: Palette.primaryBlackColor.withAlpha(225),
          ),
          const SizedBox(width: 20),
          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4,
              children: [
                Text(
                  name.replaceAll(emojiRegex, ''),
                  style: CustomTextStyles.subtitleLargeBold(
                      color: Palette.primaryTextColor),
                ),
                Text(
                  cardName,
                  style: CustomTextStyles.subtitleSmallRegular(
                      color: Palette.primaryTextColor),
                ),
              ],
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () async {
              final spotifyId = extractSpotifyId(spotifyUrl);
              final type = cardName == "playlist" ? cardName : "show";
              final spotifyOpeningUrl = Uri.parse("spotify:$type:$spotifyId");
              if (await canLaunchUrl(spotifyOpeningUrl)) {
                await launchUrl(spotifyOpeningUrl);
              } else {
                await launchUrl(Uri.parse(spotifyUrl),
                    mode: LaunchMode.externalApplication);
              }
            },
            child: Container(
              height: 25.h,
              decoration: BoxDecoration(
                  color: Palette.kWhiteColor,
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Row(
                children: [
                  SvgPicture.asset(
                    "assets/images/svg/spotify_logo.svg",
                    width: 45.w,
                    height: 45.h,
                    fit: BoxFit.fitWidth,
                    color: Palette.kPrimaryGreenColor,
                  ),
                  Icon(
                    Icons.chevron_right,
                    size: 20,
                    color: Palette.kPrimaryGreenColor,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

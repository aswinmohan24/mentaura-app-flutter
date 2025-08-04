import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mentaura_app/core/theme/color.palette.dart';

class WeeklyMoodChart extends StatefulWidget {
  final Map<String, String> moodMap;
  const WeeklyMoodChart({super.key, required this.moodMap});

  @override
  State<WeeklyMoodChart> createState() => _WeeklyMoodChartState();
}

class _WeeklyMoodChartState extends State<WeeklyMoodChart> {
  final moodLevel = {
    'sad': 1,
    'depressed': 2,
    'angry': 3,
    'neutral': 4,
    'happy': 5,
    'surprised': 6
  };

  final moodEmoji = {
    1: 'assets/images/svg/sad_face.svg',
    2: 'assets/images/svg/depressed_face.svg',
    3: 'assets/images/svg/angry_face.svg',
    4: 'assets/images/svg/neutral_face.svg',
    5: 'assets/images/svg/happy_face.svg',
    6: 'assets/images/svg/surprised_face.svg'
  };

  @override
  Widget build(BuildContext context) {
    final weekdays = widget.moodMap.keys.toList();
    final spots = List.generate(
      weekdays.length,
      (i) => FlSpot(
        i.toDouble(),
        moodLevel[widget.moodMap[weekdays[i]]]!.toDouble(),
      ),
    );

    return LineChart(
      LineChartData(
        // All your chart configuration remains the same
        minX: 0,
        maxX: 6,
        minY: 1,
        maxY: 6,
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              getTitlesWidget: (value, _) => Padding(
                padding: const EdgeInsets.only(bottom: 5, right: 7),
                child: Container(
                  width: 12.w,
                  height: 12.h,
                  decoration: BoxDecoration(
                      color: Palette.emojiBgColor,
                      shape: BoxShape.circle,
                      border: Border.all(
                          width: .5, color: Palette.primaryBlackColor)),
                  child: Center(
                    child: SvgPicture.asset(
                      moodEmoji[value.toInt()] ?? '',
                      width: 8,
                      height: 8,
                    ),
                  ),
                ),
              ),
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              getTitlesWidget: (value, _) {
                int index = value.toInt();
                if (index >= 0 && index < weekdays.length) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child:
                        Text(weekdays[index], style: TextStyle(fontSize: 12)),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            barWidth: 4,
            color: Palette.kSecondaryGreenColor,
            isStrokeCapRound: true,
            belowBarData: BarAreaData(
              show: true,
              color: Palette.quoteBgColor,
            ),
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, bar, index) {
                return FlDotCirclePainter(
                  radius: 4,
                  color: Palette.kPrimaryGreenColor,
                  strokeWidth: 2,
                  strokeColor: Colors.white,
                );
              },
            ),
          ),
        ],
      ),
      duration: const Duration(milliseconds: 900),
      curve: Curves.easeInOut,
    );
  }
}

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:hive_customer/utilities/colors.dart';

class AppPieChart extends StatefulWidget {
  const AppPieChart({super.key});

  @override
  State<StatefulWidget> createState() => AppPieChartState();
}

class AppPieChartState extends State {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 28,
          ),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  startDegreeOffset: 180,
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 1,
                  centerSpaceRadius: 0,
                  sections: showingSections(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(
      6,
      (i) {
        final isTouched = i == touchedIndex;
        const color0 = Colors.blue;
        const color1 = Colors.yellow;
        const color2 = Colors.pink;
        const color3 = Colors.purple;
        const color4 = Colors.green;
        const color5 = Colors.orange;
        switch (i) {
          case 0:
            return PieChartSectionData(
              color: color0,
              value: 225,
              radius: 80,
              titlePositionPercentageOffset: 0.55,
              borderSide: isTouched
                  ? BorderSide(color: AppColors.container, width: 6)
                  : BorderSide(color: AppColors.container.withOpacity(0)),
            );
          case 1:
            return PieChartSectionData(
              color: color1,
              value: 15,
              radius: 65,
              titlePositionPercentageOffset: 0.55,
              borderSide: isTouched
                  ? BorderSide(color: AppColors.container, width: 6)
                  : BorderSide(color: AppColors.container.withOpacity(0)),
            );
          case 2:
            return PieChartSectionData(
              color: color2,
              value: 35,
              radius: 60,
              titlePositionPercentageOffset: 0.6,
              borderSide: isTouched
                  ? BorderSide(color: AppColors.container, width: 6)
                  : BorderSide(color: AppColors.container.withOpacity(0)),
            );
          case 3:
            return PieChartSectionData(
              color: color3,
              value: 225,
              radius: 70,
              titlePositionPercentageOffset: 0.55,
              borderSide: isTouched
                  ? BorderSide(color: AppColors.container, width: 6)
                  : BorderSide(color: AppColors.container.withOpacity(0)),
            );
          case 4:
            return PieChartSectionData(
              color: color4,
              value: 55,
              radius: 70,
              titlePositionPercentageOffset: 0.55,
              borderSide: isTouched
                  ? BorderSide(color: AppColors.container, width: 6)
                  : BorderSide(color: AppColors.container.withOpacity(0)),
            );
          case 5:
            return PieChartSectionData(
              color: color5,
              value: 125,
              radius: 70,
              titlePositionPercentageOffset: 0.55,
              borderSide: isTouched
                  ? BorderSide(color: AppColors.container, width: 6)
                  : BorderSide(color: AppColors.container.withOpacity(0)),
            );
          default:
            throw Error();
        }
      },
    );
  }
}

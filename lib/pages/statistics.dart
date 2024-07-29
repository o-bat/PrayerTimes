import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:prayer_times/Components/provider.dart';
import 'package:provider/provider.dart';

class Statistics extends StatefulWidget {
  const Statistics({super.key});

  @override
  State<StatefulWidget> createState() => StatisticsState();
}

class StatisticsState extends State<Statistics> {
  final Duration animDuration = const Duration(milliseconds: 250);

  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AspectRatio(
        aspectRatio: 1,
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    'Your Week',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: BarChart(
                        mainBarData(),
                        swapAnimationDuration: animDuration,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color? barColor,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    barColor ??= Theme.of(context).colorScheme.primary;
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched ? y + 1 : y,
          color: isTouched
              ? Theme.of(context).colorScheme.primary.withOpacity(0.5)
              : barColor,
          width: width,
          borderSide: isTouched
              ? BorderSide(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.5))
              : const BorderSide(color: Colors.white, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 20,
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(7, (i) {
        switch (i) {
          case 0:
            return makeGroupData(
                0,
                Provider.of<StatisticsProvider>(context, listen: false)
                    .monday
                    .toDouble(),
                isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(
                1,
                Provider.of<StatisticsProvider>(context, listen: false)
                    .tuesday
                    .toDouble(),
                isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(
                2,
                Provider.of<StatisticsProvider>(context, listen: false)
                    .wednesday
                    .toDouble(),
                isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(
                3,
                Provider.of<StatisticsProvider>(context, listen: false)
                    .thursday
                    .toDouble(),
                isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(
                4,
                Provider.of<StatisticsProvider>(context, listen: false)
                    .friday
                    .toDouble(),
                isTouched: i == touchedIndex);
          case 5:
            return makeGroupData(
                5,
                Provider.of<StatisticsProvider>(context, listen: false)
                    .saturday
                    .toDouble(),
                isTouched: i == touchedIndex);
          case 6:
            return makeGroupData(
                6,
                Provider.of<StatisticsProvider>(context, listen: false)
                    .sunday
                    .toDouble(),
                isTouched: i == touchedIndex);
          default:
            return throw Error();
        }
      });

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (_) => Theme.of(context).secondaryHeaderColor,
          tooltipHorizontalAlignment: FLHorizontalAlignment.center,
          tooltipMargin: 10,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            String weekDay;
            switch (group.x) {
              case 0:
                weekDay = 'Monday';
                break;
              case 1:
                weekDay = 'Tuesday';
                break;
              case 2:
                weekDay = 'Wednesday';
                break;
              case 3:
                weekDay = 'Thursday';
                break;
              case 4:
                weekDay = 'Friday';
                break;
              case 5:
                weekDay = 'Saturday';
                break;
              case 6:
                weekDay = 'Sunday';
                break;
              default:
                throw Error();
            }
            return BarTooltipItem(
              '$weekDay\n',
              const TextStyle(),
              children: <TextSpan>[
                TextSpan(
                  text: (rod.toY - 1).toString(),
                ),
              ],
            );
          },
        ),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
              touchedIndex = -1;
              return;
            }
            touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 38,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
      gridData: const FlGridData(show: false),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    var style = TextStyle(
      color: Theme.of(context).colorScheme.primary,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = Text('M', style: style);
        break;
      case 1:
        text = Text('T', style: style);
        break;
      case 2:
        text = Text('W', style: style);
        break;
      case 3:
        text = Text('T', style: style);
        break;
      case 4:
        text = Text('F', style: style);
        break;
      case 5:
        text = Text('S', style: style);
        break;
      case 6:
        text = Text('S', style: style);
        break;
      default:
        text = Text('', style: style);
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }
}

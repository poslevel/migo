import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:migo/view/responsive.dart';
import 'package:migo/widgets/indicator.dart';

class ProductsSoldByCategoryChart extends StatefulWidget {
  const ProductsSoldByCategoryChart({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: !Responsive.isMobile(context)
          ? (MediaQuery.of(context).size.width - 100) / 2
          : null,
      height: 400,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const Text(
                "Sales by categories",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: Responsive.isDesktop(context) ? 3 / 2 : 1,
                      child: PieChart(
                        PieChartData(
                            pieTouchData: PieTouchData(touchCallback:
                                (FlTouchEvent event, pieTouchResponse) {
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
                            }),
                            borderData: FlBorderData(
                              show: false,
                            ),
                            sectionsSpace: 0,
                            centerSpaceRadius: 40,
                            sections: showingSections()),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const <Widget>[
                      Indicator(
                        color: Color(0xffBEE29B),
                        text: "Phones",
                        isSquare: false,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Indicator(
                        color: Color(0xff90BAF9),
                        text: "Audio",
                        isSquare: false,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Indicator(
                        color: Color(0xffF29DA3),
                        text: 'FITNESS BANDS',
                        isSquare: false,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Indicator(
                        color: Color(0xffE5B66A),
                        text: 'TV',
                        isSquare: false,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Indicator(
                        color: Color(0xffB9B7FF),
                        text: 'Laptops',
                        isSquare: false,
                      ),
                      SizedBox(
                        height: 18,
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 28,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(5, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xffBEE29B),
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xff1F212E),
            ),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xff90BAF9),
            value: 25,
            title: '25%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xff1F212E)),
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xffF29DA3),
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xff1F212E)),
          );
        case 3:
          return PieChartSectionData(
            color: const Color(0xffE5B66A),
            value: 10,
            title: '10%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xff1F212E)),
          );
        case 4:
          return PieChartSectionData(
            color: const Color(0xFFB9B7FF),
            value: 10,
            title: '10%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xff1F212E)),
          );
        default:
          throw Error();
      }
    });
  }
}

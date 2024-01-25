import 'package:flutter/material.dart';

class CustomBarChart extends StatelessWidget {
  final double availableQty;
  final double soldQty;

  CustomBarChart({required this.availableQty, required this.soldQty});

  @override
  Widget build(BuildContext context) {
    double maxYValue = (availableQty > soldQty) ? availableQty : soldQty;
    double yAxisDifference = ((maxYValue / 100)) * 20;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border:
            Border.all(color: Theme.of(context).colorScheme.primary, width: 3),
      ),
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 12,),
          SizedBox(
            height: 200,
            width: MediaQuery.of(context).size.width * 0.9,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [

                    for (int i = 5; i >= 1; i--)
                      Expanded(
                        child: Column(
                          children: [
                            Text((yAxisDifference * i).toStringAsFixed(1)),
                            SizedBox(height: 16), // Adjust the height as needed
                          ],
                        ),
                      ),
                    // SizedBox(height: 6), // Adjust the height as needed
                    Text('0'),
                  ],
                ),
                // SizedBox(width: 3),
                AspectRatio(
                  aspectRatio: 1.2,
                  child: CustomPaint(
                    painter: BarChartPainter(
                      context:context,
                      availableQty: availableQty,
                      soldQty: soldQty,
                      maxYValue: maxYValue,
                      yAxisDifference: yAxisDifference,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Available Quantity'),
                SizedBox(width: 20),
                Text('Sold Quantity'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BarChartPainter extends CustomPainter {
  final double availableQty;
  final double soldQty;
  final double maxYValue;
  final double yAxisDifference;
  final BuildContext context;

  BarChartPainter({
    required this.availableQty,
    required this.soldQty,
    required this.maxYValue,
    required this.yAxisDifference,
    required this.context,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = Colors.blue;

    double barWidth = size.width / 3;
    double xPosition = size.width / 4;

    double availableBarHeight = (availableQty / maxYValue) * size.height;
    double soldBarHeight = (soldQty / maxYValue) * size.height;

    // Draw available bar
    canvas.drawRect(
      Rect.fromPoints(
        Offset(xPosition - barWidth / 2, size.height - availableBarHeight),
        Offset(xPosition + barWidth / 2, size.height),
      ),
      paint,
    );

    // Draw available text on top of the available bar
    drawText(canvas, availableQty.toString(), xPosition, size.height - availableBarHeight - 5);

    xPosition += 20;
    paint.color = Colors.red;

    // Draw sold bar
    canvas.drawRect(
      Rect.fromPoints(
        Offset(2 * xPosition - barWidth / 2, size.height - soldBarHeight),
        Offset(2 * xPosition + barWidth / 2, size.height),
      ),
      paint,
    );

    // Draw sold text on top of the sold bar
    drawText(canvas, soldQty.toString(), 2 * xPosition, size.height - soldBarHeight - 5);
  }

  void drawText(Canvas canvas, String text, double x, double y) {
    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: Theme.of(context).textTheme.labelMedium,
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    textPainter.paint(canvas, Offset(x - textPainter.width / 2, y - textPainter.height));
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

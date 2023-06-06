import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NeumorphicButtons extends StatelessWidget {
  const NeumorphicButtons(
      {super.key,
      required this.text,
      this.beginColor,
      this.endColor,
      this.color,
      this.depth,
      required this.onPressed,
      this.textColor});
  final String text;
  final Color? beginColor;
  final Color? endColor;
  final Color? color;
  final double? depth;
  final VoidCallback onPressed;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
        onPressed: onPressed,
        minDistance: 10,
        padding: EdgeInsets.zero,
        style: NeumorphicStyle(
          shape: NeumorphicShape.flat,
          boxShape: NeumorphicBoxShape.roundRect(
            BorderRadius.circular(30),
          ),
          depth: depth ?? 10,
          intensity: 19,
          lightSource: LightSource.topLeft,
        ),
        child: DecoratedBox(
            decoration: BoxDecoration(
                gradient: (beginColor != null && endColor != null)
                    ? LinearGradient(
                        colors: [
                          beginColor!,
                          endColor!,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : null,
                color: color),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 32,
                    color: textColor ?? Colors.white,
                  ),
                ),
              ),
            )));
  }
}

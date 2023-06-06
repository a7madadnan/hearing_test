import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NeumorphicContainer extends StatelessWidget {
  const NeumorphicContainer(
      {super.key,
      required this.child,
      this.beginColor,
      this.endColor,
      this.color,
      this.depth,
      this.padding, this.height, this.width});
  final Widget child;
  final Color? beginColor;
  final Color? endColor;
  final Color? color;
  final double? depth;
  final double? padding;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(
        shape: NeumorphicShape.flat,
        boxShape: NeumorphicBoxShape.roundRect(
          BorderRadius.circular(25),
        ),
        depth: depth??-5,
        intensity: 0.9,
        lightSource: LightSource.topLeft,
      ),
      child: Container(
        height: height,
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 30),
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
        child: Padding(
          padding: EdgeInsets.all(padding ?? 10.0),
          child: Center(child: child),
        ),
      ),
    );
  }
}

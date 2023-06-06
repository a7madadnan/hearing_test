import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sound_generator/sound_generator.dart';
import 'package:sound_generator/waveTypes.dart';

void main() {
  runApp(const SoundGen());
}

class SoundGen extends StatefulWidget {
  const SoundGen({super.key});

  @override
  SoundGenState createState() => SoundGenState();
}

class MyPainter extends CustomPainter {
  //         <-- CustomPainter class
  final List<int> oneCycleData;

  MyPainter(this.oneCycleData);

  @override
  void paint(Canvas canvas, Size size) {
    var i = 0;
    List<Offset> maxPoints = [];

    final t = size.width / (oneCycleData.length - 1);
    for (var i0 = 0, len = oneCycleData.length; i0 < len; i0++) {
      maxPoints.add(Offset(
          t * i,
          size.height / 2 -
              oneCycleData[i0].toDouble() / 32767.0 * size.height / 2));
      i++;
    }

    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;
    canvas.drawPoints(PointMode.polygon, maxPoints, paint);
  }

  @override
  bool shouldRepaint(MyPainter old) {
    if (oneCycleData != old.oneCycleData) {
      return true;
    }
    return false;
  }
}

class SoundGenState extends State<SoundGen> {
  bool isPlaying = false;
  double frequency = 20;
  double balance = 0;
  double volume = 1;
  waveTypes waveType = waveTypes.SINUSOIDAL;
  int sampleRate = 96000;
  List<int>? oneCycleData;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Sound Generator Example'),
            ),
            body: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 20,
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("A Cycle's Snapshot With Real Data"),
                      const SizedBox(height: 2),
                      Container(
                          height: 100,
                          width: double.infinity,
                          color: Colors.white54,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 0,
                          ),
                          child: oneCycleData != null
                              ? CustomPaint(
                                  painter: MyPainter(oneCycleData!),
                                )
                              : Container()),
                      const SizedBox(height: 2),
                      Text("A Cycle Data Length is ${(sampleRate / frequency).round()} on sample rate $sampleRate"),
                      const SizedBox(height: 5),
                      const Divider(
                        color: Colors.red,
                      ),
                      const SizedBox(height: 5),
                      CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.lightBlueAccent,
                          child: IconButton(
                              icon: Icon(
                                  isPlaying ? Icons.stop : Icons.play_arrow),
                              onPressed: () {
                                isPlaying
                                    ? SoundGenerator.stop()
                                    : SoundGenerator.play();
                              })),
                      const SizedBox(height: 5),
                      const Divider(
                        color: Colors.red,
                      ),
                      const SizedBox(height: 5),
                      const Text("Wave Form"),
                      Center(
                          child: DropdownButton<waveTypes>(
                              value: waveType,
                              onChanged: (waveTypes? newValue) {
                                setState(() {
                                  waveType = newValue!;
                                  SoundGenerator.setWaveType(waveType);
                                });
                              },
                              items:
                                  waveTypes.values.map((waveTypes classType) {
                                return DropdownMenuItem<waveTypes>(
                                    value: classType,
                                    child: Text(
                                        classType.toString().split('.').last));
                              }).toList())),
                      const SizedBox(height: 5),
                      const Divider(
                        color: Colors.red,
                      ),
                      const SizedBox(height: 5),
                      const Text("Frequency"),
                      SizedBox(
                          width: double.infinity,
                          height: 40,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Expanded(
                                  flex: 2,
                                  child: Center(
                                      child: Text(
                                          "${frequency.toStringAsFixed(2)} Hz")),
                                ),
                                Expanded(
                                  flex: 8, // 60%
                                  child: Slider(
                                      min: 20,
                                      max: 10000,
                                      value: frequency,
                                      onChanged: (value) {
                                        setState(() {
                                          frequency = value.toDouble();
                                          SoundGenerator.setFrequency(
                                              frequency);
                                        });
                                      }),
                                )
                              ])),
                      const SizedBox(height: 5),
                      const Text("Balance"),
                      SizedBox(
                          width: double.infinity,
                          height: 40,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Expanded(
                                  flex: 2,
                                  child: Center(
                                      child: Text(
                                          balance.toStringAsFixed(2))),
                                ),
                                Expanded(
                                  flex: 8, // 60%
                                  child: Slider(
                                      min: -1,
                                      max: 1,
                                      value: balance,
                                      onChanged: (value) {
                                        setState(() {
                                          balance = value.toDouble();
                                          SoundGenerator.setBalance(
                                              balance);
                                        });
                                      }),
                                )
                              ])),
                      const SizedBox(height: 5),
                      const Text("Volume"),
                      SizedBox(
                          width: double.infinity,
                          height: 40,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Expanded(
                                  flex: 2,
                                  child: Center(
                                      child:
                                          Text(volume.toStringAsFixed(2))),
                                ),
                                Expanded(
                                  flex: 8, // 60%
                                  child: Slider(
                                      min: 0,
                                      max: 1,
                                      value: volume,
                                      onChanged: (value) {
                                        setState(() {
                                          volume = value.toDouble();
                                          SoundGenerator.setVolume(volume);
                                        });
                                      }),
                                )
                              ]))
                    ]))));
  }

  @override
  void dispose() {
    super.dispose();
    SoundGenerator.release();
  }

  @override
  void initState() {
    super.initState();
    isPlaying = false;

    SoundGenerator.init(sampleRate);

    SoundGenerator.onIsPlayingChanged.listen((value) {
      setState(() {
        isPlaying = value;
      });
    });

    SoundGenerator.onOneCycleDataHandler.listen((value) {
      setState(() {
        oneCycleData = value;
      });
    });

    SoundGenerator.setAutoUpdateOneCycleSample(true);
    //Force update for one time
    SoundGenerator.refreshOneCycleData();
  }
}
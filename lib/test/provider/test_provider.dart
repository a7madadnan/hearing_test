import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final resultListProvider = StateProvider<List<Result>>((ref) {
  final List<Result> resultList = [];
  return resultList;
});

class Result {
  final double volume;
  final int frequency;
  final bool isLeft;

  Result({required this.volume, required this.frequency, required this.isLeft});
}

class Sound {
  final int frequency;
  final double volume;
  final double balance;
  final int nofYes;
  final int nofNo;
  final int nofClicks;
  final bool isFinished;
  final int rightLevel;
  final int leftLevel;
  final bool isLeft;
  Sound({
    required this.frequency,
    required this.volume,
    required this.isFinished,
    this.nofYes = 0,
    this.nofNo = 0,
    this.balance = -1,
    this.rightLevel = 0,
    this.nofClicks = 0,
    this.isLeft = false,
    this.leftLevel = 0,
  });
  Sound copyWith(
      {int? frequency,
      double? volume,
      double? balance,
      int? nofYes,
      int? nofNo,
      int? nofClicks,
      bool? isFinished,
      int? rightLevel,
      int? leftLevel,
      bool? isLeft}) {
    return Sound(
      frequency: frequency ?? this.frequency,
      volume: volume ?? this.volume,
      isFinished: isFinished ?? this.isFinished,
      nofNo: nofNo ?? this.nofNo,
      nofYes: nofYes ?? this.nofYes,
      balance: balance ?? this.balance,
      rightLevel: rightLevel ?? this.rightLevel,
      leftLevel: leftLevel ?? this.leftLevel,
      nofClicks: nofClicks ?? this.nofClicks,
      isLeft: isLeft ?? this.isLeft,
    );
  }
}

class SoundStateNotifier extends StateNotifier<Sound> {
  AudioPlayer player = AudioPlayer();

  SoundStateNotifier()
      : super(Sound(frequency: 250, volume: 0.30, isFinished: false));
  List<Sound> resultSound = [];
  void playSound() async {
    String audioasset = "assets/tones/${state.frequency}.wav";
    ByteData bytes = await rootBundle.load(audioasset);
    Uint8List soundbytes =
        bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
    await player.setSourceBytes(soundbytes);
    Source source = player.source!;

    player.setReleaseMode(ReleaseMode.loop);
    double volume = state.volume;
    print(volume);
    await player.play(
      source,
      volume: volume,
      balance: state.balance,
    );
  }

  void get raiseVolume {
    double volume = state.volume + 0.10;
    state = state.copyWith(volume: volume);
  }

  void get raiseFrequency {
    int? frequency;
    int? rightLevel;
    int? leftLevel;
    if (state.frequency < 8000) {
      frequency = state.frequency * 2;

      if (!state.isLeft) {
        if (state.rightLevel <= 6) {
          rightLevel = state.rightLevel + 1;
        } else {
          rightLevel = 6;
        }
      }
      if (state.isLeft) {
        if (state.leftLevel <= 6) {
          leftLevel = state.leftLevel + 1;
        } else {
          leftLevel = 6;
        }
      }
    } else {
      frequency = 250;
      finish();
    }

    state = state.copyWith(
        frequency: frequency, rightLevel: rightLevel, leftLevel: leftLevel);
  }

  void get downVolume {
    double volume = state.volume - 0.10;
    state = state.copyWith(volume: volume);
  }

  void get reset {
    state = state.copyWith(volume: 0.3, nofNo: 0, nofYes: 0, nofClicks: 0);
  }

  void get saidYes {
    int nofYes = state.nofYes + 1;
    state = state.copyWith(nofYes: nofYes);
    print(nofYes);
  }

  void get saidNo {
    int nofNo = state.nofNo + 1;
    state = state.copyWith(nofNo: nofNo);
  }

  void finish() {
    if (!state.isLeft) {
      state = state.copyWith(
        isLeft: true,
        frequency: 250,
        volume: 0.3,
        nofNo: 0,
        nofYes: 0,
        leftLevel: 0,
        nofClicks: 0,
        balance: 1,
      );
    } else {
      state = state.copyWith(isFinished: true);
      player.pause();
      player.dispose();
    }
  }

  void canHear() {
    saidYes;

    if (state.volume > 0.1 && state.nofNo == 0) {
      downVolume;
    } else {
      raiseFrequency;
      reset;
    }
  }

  void cannotHear() {
    saidNo;

    if (state.volume <= 0.8 && state.nofYes == 0) {
      raiseVolume;
    } else {
      raiseFrequency;
      reset;
    }
  }
}

final soundStateNotifierProvider =
    StateNotifierProvider<SoundStateNotifier, Sound>((ref) {
  return SoundStateNotifier();
});

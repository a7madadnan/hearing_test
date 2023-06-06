import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sound_generator/sound_generator.dart';
import 'package:sound_generator/waveTypes.dart';

final frequencyProvider = StateProvider<int>((ref) {
  const int frequency = 250;
  return frequency;
});
final volumeProvider = StateProvider<double>((ref) {
  const double volume = 0.1;
  return volume;
});
List<int> frequencies = [250, 500, 1000, 2000, 4000, 8000];
List<double> volumes = [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1];

enum Frequency {
  f250(frequency: 250),
  f500(frequency: 500),
  f1000(frequency: 1000),
  f2000(frequency: 2000),
  f4000(frequency: 4000),
  f8000(frequency: 8000),
  ;

  const Frequency({required this.frequency});
  final int frequency;
}

class Sound {
  final double frequency;
  final double volume;
  final double balance;
  final int nofYes;
  final int nofNo;
  final bool isDone;
  final bool isFinished;
  Sound({
    required this.frequency,
    required this.volume,
    required this.isDone,
    required this.isFinished,
    this.nofYes = 0,
    this.nofNo = 0,
    this.balance = 0,
  });
  Sound copyWith({
    double? frequency,
    double? volume,
    double? balance,
    int? nofYes,
    int? nofNo,
    bool? isDone,
    bool? isFinished,
  }) {
    return Sound(
      frequency: frequency ?? this.frequency,
      volume: volume ?? this.volume,
      isDone: isDone ?? this.isDone,
      isFinished: isFinished ?? this.isFinished,
      nofNo: nofNo ?? this.nofNo,
      nofYes: nofYes ?? this.nofYes,
      balance: balance ?? this.balance,
    );
  }

  void soundGenerate() {
    SoundGenerator.init(96000);
    SoundGenerator.setFrequency(frequency);
    SoundGenerator.setBalance(balance);
    SoundGenerator.setVolume(volume);
    SoundGenerator.setWaveType(waveTypes.SINUSOIDAL);
    SoundGenerator.play();
  }
}

class SoundStateNotifier extends StateNotifier<Sound> {
  SoundStateNotifier()
      : super(Sound(
            frequency: 250, volume: 0.3, isDone: false, isFinished: false));
  void playSound() {

    state.soundGenerate();
  }

  void initialize() {}

  void stop() {
    SoundGenerator.stop();
  }

  void raiseVolume() {
    double volume = state.volume + 0.1;
    state = state.copyWith(volume: volume);
  }

  void downVolume() {
    double volume = state.volume - 0.1;
    state = state.copyWith(volume: volume);
  }
  // void didNotHeared() {
  //   if (state.frequency >= 250 && state.frequency < 8000) {
  //     if (state.volume <= 0.1 && state.volume < 1 && state.nofNo <= 2) {
  //       state = Sound(
  //           frequency: state.frequency,
  //           volume: state.volume == 0.1 ? state.volume + 0.2 : state.volume + 0.1,
  //           isDone: false,
  //           isFinished: false);

  //     } else if (state.nofNo == 2) {
  //       Sound(
  //           frequency: state.frequency,
  //           volume: state.volume,
  //           isDone: true,
  //           isFinished: false);

  //     }

  //   } else {
  //     state = Sound(
  //         frequency: state.frequency,
  //         volume: state.volume,
  //         isDone: true,
  //         isFinished: true);

  //   }
  // }

  // void didHeared() {
  //   if (state.frequency >= 250 && state.frequency < 8000) {
  //     if (state.volume <= 0.1 && state.volume < 1 && state.nofYes <= 2) {
  //       state = Sound(
  //           frequency: state.frequency,
  //           volume: state.volume - 0.1,
  //           isDone: false,
  //           isFinished: false);

  //     } else if (state.nofNo == 2) {
  //       Sound(
  //           frequency: state.frequency,
  //           volume: state.volume,
  //           isDone: true,
  //           isFinished: false);

  //     }

  //   } else {
  //     state = Sound(
  //         frequency: state.frequency,
  //         volume: state.volume,
  //         isDone: true,
  //         isFinished: true);

  //   }
  // }
}

final soundStateNotifierProvider =
    StateNotifierProvider<SoundStateNotifier, Sound>((ref) {
  return SoundStateNotifier();
});

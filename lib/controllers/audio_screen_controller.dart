import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player_app/utils/dimensions.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AudioScreenController extends GetxController {
  final AudioPlayer advancedPlayer = Get.arguments['advancedPlayer'];
  final List<SongModel> listSongModel = Get.arguments['listSongModel'];
  final songsTitleSearchCont = Get.arguments['title'];

  int index = Get.arguments['index'];

  Duration duration = const Duration(); // To Take Audio Duration
  Duration position = const Duration(); // To Take Audio Position
  bool isPlaying = true;
  bool isPaused = false;
  bool isRepeat = false; // Repeat a single Audio
  bool isLoop = false; // Loop All Audios
  Color repeatColor = Colors.black; // Color For changing when press it
  Color loopColor = Colors.black; // Color For changing when press it
  final List<IconData> _icons = [
    // Icons For changing about in condition
    Icons.play_circle_fill,
    Icons.pause_circle_filled,
  ];

  @override
  void onInit() {
    super.onInit();
    // songsTitleSearchListFun();
    playAudio();
    listSongModel[
        index]; // The index is Always change it so The ListSongModel is change it
    index;
  }

  void playAudio() {
    advancedPlayer.onDurationChanged.listen((d) {
      duration = d;
      update();
    });

    advancedPlayer.onAudioPositionChanged.listen((p) {
      position = p;
      update();
    });

    advancedPlayer.onPlayerError.listen((msg) {
      PlayerState.STOPPED;
      duration = const Duration(seconds: 0);
      position = const Duration(seconds: 0);
      update();
    });
    advancedPlayer.play(listSongModel[index].data,
        isLocal: true); // isLocal : true To Access to Loacal Audios in Device
    advancedPlayer.onPlayerCompletion.listen((event) {
      // When AudioPlayer Complete Do This

      position = const Duration(seconds: 0);
      update();
      if (isRepeat == true) {
        isPlaying = true;
        update(); //
      }
      if (isLoop == true) {
        onComplete();
        index;
        update();
      } else {
        isPlaying = false;
        isRepeat = false;
        isLoop == false;
        update(); //
      }
    });
  }

  void onComplete() {
    // For Looping
    if (index < listSongModel.length - 1) {
      index++;
      isPlaying = true;

      update();
      advancedPlayer.play(listSongModel[index].data, isLocal: true);
    } else {
      index = 0;
      isPlaying = true;
      update();
      advancedPlayer.play(listSongModel[index].data, isLocal: true);
    }
  }

  Widget btnStart() {
    return Padding(
      padding: EdgeInsets.only(bottom: Dimensions.heigh10),
      child: IconButton(
        icon: isPlaying == false
            ? Icon(_icons[0],
                size: Dimensions.iconSize50,
                color: const Color(0xFF607D8B).withOpacity(0.80))
            : Icon(_icons[1],
                size: Dimensions.iconSize50,
                color: const Color(0xFF607D8B).withOpacity(0.80)),
        onPressed: () {
          if (isPlaying == false) {
            advancedPlayer.play(listSongModel[index].data, isLocal: true);
            isPlaying = true;
          } else if (isPlaying == true) {
            advancedPlayer.pause();
            isPlaying = false;
            update();
          }
        },
      ),
    );
  }

  Widget btnNext() {
    return IconButton(
      icon: const Icon(Icons.skip_next),
      iconSize: Dimensions.iconSize25,
      color: Colors.black,
      onPressed: () {
        if (index < listSongModel.length - 1) {
          index++;
          isPlaying = true;
          position = const Duration(seconds: 0);
          update();
          advancedPlayer.play(listSongModel[index].data, isLocal: true);
        } else {
          index = 0;
          isPlaying = true;
          position = const Duration(seconds: 0);
          update();
          advancedPlayer.play(listSongModel[index].data, isLocal: true);
        }
      },
    );
  }

  Widget btnPrevious() {
    return IconButton(
      icon: const Icon(Icons.skip_previous),
      iconSize: 25,
      color: Colors.black,
      onPressed: () {
        if (index > 0) {
          index--;
          isPlaying = true;
          position = const Duration(seconds: 0);
          update();
          advancedPlayer.play(listSongModel[index].data, isLocal: true);
        } else {
          isPlaying = true;
          position = const Duration(seconds: 0);
          advancedPlayer.play(listSongModel[index].data, isLocal: true);
        }
      },
    );
  }

  Widget btnFast() {
    return IconButton(
      icon: const Icon(Icons.forward_10),
      iconSize: Dimensions.iconSize25,
      color: Colors.black,
      onPressed: () {
        advancedPlayer.setPlaybackRate(1.5);
      },
    );
  }

  Widget btnSlow() {
    return IconButton(
      icon: const Icon(Icons.slow_motion_video),
      iconSize: Dimensions.iconSize25,
      color: Colors.black,
      onPressed: () {
        advancedPlayer.setPlaybackRate(0.5);
      },
    );
  }

  Widget btnLoop() {
    return IconButton(
        icon: ImageIcon(const AssetImage('images/loop.png'),
            size: Dimensions.imgSize15, color: loopColor),
        color: loopColor,
        onPressed: () {
          if (isLoop == false) {
            isLoop = true;
            loopColor = const Color(0xFF607D8B).withOpacity(0.80);
            update();
          } else if (isLoop == true) {
            isLoop = false;
            loopColor = Colors.black;
            update();
          }
        });
  }

  Widget btnRepeat() {
    return IconButton(
        icon: ImageIcon(
          const AssetImage('images/repeat.png'),
          size: Dimensions.imgSize15,
          color: repeatColor,
        ),
        onPressed: () {
          if (isRepeat == false) {
            advancedPlayer.setReleaseMode(ReleaseMode.LOOP);
            isRepeat = true;
            repeatColor = const Color(0xFF607D8B).withOpacity(0.80);
            update();
          } else if (isRepeat == true) {
            advancedPlayer.setReleaseMode(ReleaseMode.STOP);
            isRepeat = false;
            repeatColor = Colors.black;
            update();
          }
        });
  }

  Widget loadAsset() {
    // has all buttons
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          btnRepeat(),
          btnSlow(),
          btnPrevious(),
          btnStart(),
          btnNext(),
          btnFast(),
          btnLoop()
        ]);
  }

  Widget slider() {
    double _value = position.inSeconds.toDouble();

    return Slider(
        activeColor: const Color(0xFF607D8B).withOpacity(0.80),
        inactiveColor: Colors.grey,
        value: _value,
        min: 0.0,
        max: duration.inSeconds.toDouble() + 12.10,
        onChanged: (double value) {
          changeToSecond(value.toInt());
          value = value;

          update();
        });
  }

  void changeToSecond(int second) {
    Duration newDuration = Duration(seconds: second);
    advancedPlayer.seek(newDuration);
  }
}

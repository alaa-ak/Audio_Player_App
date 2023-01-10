import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player_app/controllers/audio_screen_controller.dart';
import 'package:music_player_app/utils/dimensions.dart';

class AudioScreen extends StatelessWidget {
  const AudioScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final AudioScreenController audioScreenController =
        Get.put(AudioScreenController());

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: Dimensions.positionedHeightDivided2Point2,
            child: Container(
              color: Theme.of(context).primaryColor.withOpacity(0.90),
            ),
          ),
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              )),
          Positioned(
              left: 0,
              right: 0,
              top: Dimensions.positionedHeightMultiPlied0Point29,
              height: Dimensions.positionedHeightMultiPlied0Point42,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius40),
                  color: Colors.white,
                ),
                child: GetBuilder<AudioScreenController>(
                    builder: (_) => Column(
                          children: [
                            SizedBox(
                              height: Dimensions.heightMultied0Point11,
                            ),
                            Padding(
                              padding: EdgeInsets.all(Dimensions.heigh10),
                              child: Text(
                                audioScreenController.songsTitleSearchCont[
                                    audioScreenController.index],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: Dimensions.fontSize18,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Ayenir'),
                              ),
                            ),
                            Text(
                              audioScreenController
                                  .listSongModel[audioScreenController.index]
                                  .artist
                                  .toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: Dimensions.fontSize15,
                              ),
                            ),
                          ],
                        )),
              )),
          Positioned(
            top: Dimensions.positionedHeightMultiPlied0Point16,
            left: Dimensions.positionedWidthDividedBy2Point5,
            right: Dimensions.positionedWidthDividedBy2Point5,
            height: Dimensions.positionedHeightMultiPlied0Point21,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                border: Border.all(color: Colors.white, width: 2),
                color: Theme.of(context).primaryColor.withOpacity(0.90),
              ),
              child: Padding(
                  padding: EdgeInsets.all(Dimensions.heigh20),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: Colors.white, width: Dimensions.width5),
                      image: const DecorationImage(
                        image: AssetImage('images/music-note.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )),
            ),
          ),
          Positioned(
            top: Dimensions.positionedHeightMultiPlied0Point53,
            left: 0,
            right: 0,
            height: Dimensions.positionedHeightDividedBy4,
            child: Container(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: Dimensions.width20, right: Dimensions.width20),
                    child: GetBuilder<AudioScreenController>(
                        builder: (_) => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  audioScreenController.position
                                      .toString()
                                      .split('.')[0],
                                  style: TextStyle(
                                      fontSize: Dimensions.fontSize14),
                                ),
                                Text(
                                    audioScreenController.duration
                                        .toString()
                                        .split('.')[0],
                                    style: TextStyle(
                                        fontSize: Dimensions.fontSize14))
                              ],
                            )),
                  ),
                  GetBuilder<AudioScreenController>(
                      builder: (_) => audioScreenController.slider()),
                  GetBuilder<AudioScreenController>(
                      builder: (_) => audioScreenController
                          .loadAsset()), // The Widget that has all buttons about audio
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

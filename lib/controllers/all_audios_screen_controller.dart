import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player_app/utils/dimensions.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import '../models/menu_item_buttons.dart';
import '../models/menu_items_data_buttons.dart';

class AllAudiosScreenController extends GetxController {
  final AudioPlayer advancedPlayer = AudioPlayer();
  final List<List<SongModel>> songsModelsController =
      <List<SongModel>>[]; // To save all songModels data .
  final List<String> songsTitleSearchController =
      <String>[]; // To save songModelTitle for search and rename .
  final List<MenuItemButtons> itemList = MenuItemsDataButtons.itemList;
  String _newTitle = ''; // To rename the songModel title.

  @override
  void onInit() {
    super.onInit();
    Permission.storage.request();
  }

  void requestPermission() {
    Permission.storage.request(); // To Access to the audios in local device;
  }

  deleteSongModel(int index) {
    // The function to delete a songModel
    Future.delayed(
        // Using Future.delayed because The DefaultDialog need to second to keep it open
        const Duration(seconds: 0),
        () => Get.defaultDialog(
              titlePadding: EdgeInsets.only(
                  top: Dimensions.heigh10, bottom: Dimensions.heigh10),
              title: 'Alert',
              titleStyle: TextStyle(
                  color: const Color(0xFF607D8B).withOpacity(0.80),
                  fontSize: Dimensions.fontSize18,
                  fontWeight: FontWeight.bold),
              middleText: 'Delete',
              middleTextStyle: TextStyle(
                  fontSize: Dimensions.fontSize15, fontWeight: FontWeight.bold),
              textCancel: 'Cancel',
              textConfirm: 'Confirm',
              onConfirm: () {
                songsModelsController[index].removeAt(index);
                songsTitleSearchController.removeAt(index);
                update();
                Get.back();
              },
            ));
  }

  reNameSongModelTitle(int index) {
    Future.delayed(
        // Using Future.delayed because The DefaultDialog need to second to keep it open
        const Duration(seconds: 0),
        () => Get.defaultDialog(
              title: 'Rename',
              titleStyle: TextStyle(
                  color: const Color(0xFF607D8B).withOpacity(0.80),
                  fontSize: Dimensions.fontSize18,
                  fontWeight: FontWeight.bold),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: Dimensions.heigh200,
                    child: TextField(
                      onChanged: ((value) => _newTitle = value),
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: Dimensions.heigh5,
                              horizontal: Dimensions.width5),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.all(
                              Radius.circular(Dimensions.radius5),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(Dimensions.radius5)),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: const Color(0xFF607D8B)
                                      .withOpacity(0.80)),
                              borderRadius: BorderRadius.all(
                                Radius.circular(Dimensions.radius5),
                              ))),
                    ),
                  ),
                ],
              ),
              textCancel: 'Cancel',
              textConfirm: 'Ok',
              onConfirm: () {
                songsTitleSearchController[index] = _newTitle;
                update();
                Get.back();
              },
            ));
  }
}

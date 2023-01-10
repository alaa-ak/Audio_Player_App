import 'package:music_player_app/utils/dimensions.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:music_player_app/controllers/all_audios_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'audio_screen.dart';

class AudiosSearchScreen extends SearchDelegate {
  AllAudiosScreenController allAudiosScreenController =
      Get.find(); // Values for search that find in this controller

  final audioQuery = OnAudioQuery();
  late int
      indexOf; // To send the index of songModel to Audio Screen for playing

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    final suggestions =
        allAudiosScreenController.songsTitleSearchController.where((songTitle) {
      indexOf = allAudiosScreenController.songsTitleSearchController
          .indexOf(songTitle);
      return songTitle.toLowerCase().contains(query.toLowerCase());
    });
    return FutureBuilder<List<SongModel>>(
        future: audioQuery.querySongs(
          sortType: null,
          orderType: OrderType.ASC_OR_SMALLER,
          uriType: UriType.EXTERNAL,
          ignoreCase: true,
        ),
        builder: (context, item) {
          return Expanded(
            child: ListView.builder(
              itemCount: suggestions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(suggestions.elementAt(index),
                      style: TextStyle(
                          fontSize: Dimensions.fontSize14,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Ayenir')),
                  leading: Padding(
                    padding: EdgeInsets.only(right: Dimensions.width8),
                    child: CircleAvatar(
                      backgroundColor: Colors.blueGrey,
                      child: Icon(
                        Icons.music_note,
                        color: Colors.white,
                        size: Dimensions.iconSize25,
                      ),
                    ),
                  ),
                  onTap: () {
                    Get.to(
                      () => const AudioScreen(),
                      arguments: {
                        'advancedPlayer':
                            allAudiosScreenController.advancedPlayer,
                        'listSongModel': item.data!,
                        'index': indexOf,
                        'title': allAudiosScreenController
                            .songsTitleSearchController,
                      },
                    );
                  },
                );
              },
            ),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions =
        allAudiosScreenController.songsTitleSearchController.where((songTitle) {
      indexOf = allAudiosScreenController.songsTitleSearchController
          .indexOf(songTitle);
      return songTitle.toLowerCase().contains(query.toLowerCase());
    });
    return FutureBuilder<List<SongModel>>(
        future: audioQuery.querySongs(
          sortType: null,
          orderType: OrderType.ASC_OR_SMALLER,
          uriType: UriType.EXTERNAL,
          ignoreCase: true,
        ),
        builder: (context, item) {
          return ListView.builder(
            itemCount: suggestions.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(suggestions.elementAt(index),
                    style: TextStyle(
                        fontSize: Dimensions.fontSize14,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Ayenir')),
                leading: Padding(
                  padding: EdgeInsets.only(right: Dimensions.width8),
                  child: CircleAvatar(
                    backgroundColor: Colors.blueGrey,
                    child: Icon(
                      Icons.music_note,
                      color: Colors.white,
                      size: Dimensions.iconSize25,
                    ),
                  ),
                ),
                onTap: () {
                  query = suggestions.elementAt(index);
                  Get.to(
                    () => const AudioScreen(),
                    arguments: {
                      'advancedPlayer':
                          allAudiosScreenController.advancedPlayer,
                      'listSongModel': item.data!,
                      'index': indexOf,
                      'title':
                          allAudiosScreenController.songsTitleSearchController,
                    },
                  );
                },
              );
            },
          );
        });
  }
}

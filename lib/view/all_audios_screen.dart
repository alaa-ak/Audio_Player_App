import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player_app/utils/dimensions.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../controllers/all_audios_screen_controller.dart';
import 'audio_screen.dart';

class AllAudiosScreen extends StatelessWidget {
  const AllAudiosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AllAudiosScreenController allAudiosScreenController =
        Get.put(AllAudiosScreenController());
    final _audioQuery = OnAudioQuery();
    return FutureBuilder<List<SongModel>>(
        future: _audioQuery.querySongs(
          sortType: null,
          orderType: OrderType.ASC_OR_SMALLER,
          uriType: UriType.EXTERNAL,
          ignoreCase: true,
        ),
        builder: (context, item) {
          if (item.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (item.data!.isEmpty) {
            return const Center(
              child: Text("No Songs Found !"),
            );
          }
          return GetBuilder<AllAudiosScreenController>(
              builder: (_) => ListView.builder(
                  shrinkWrap: true,
                  // To change  listView when is the songModel delete or rename the title of songModel.
                  itemCount: item.data!.length,
                  itemBuilder: (context, index) {
                    // Define songsScreenController.songsModelsCont to use  as a ListgModel in audio-Search-Screen.
                    allAudiosScreenController.songsModelsController
                        .add(item.data!);
                    // Define songsScreenController.songsTitleSearchCont to use it as a List<String> in songsSearchScreen and to rename.
                    allAudiosScreenController.songsTitleSearchController.add(
                        allAudiosScreenController
                            .songsModelsController[index][index].title);
                    return ListTile(
                      title: Text(
                          allAudiosScreenController
                              .songsTitleSearchController[index],
                          style: TextStyle(
                              fontSize: Dimensions.fontSize14,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Ayenir')),
                      subtitle: Text(
                        '${allAudiosScreenController.songsModelsController[index][index].duration}',
                        style: TextStyle(
                          fontSize: Dimensions.fontSize12,
                        ),
                      ),
                      leading: Padding(
                        padding: EdgeInsets.only(right: Dimensions.width8),
                        child: CircleAvatar(
                          backgroundColor:
                              Theme.of(context).primaryColor.withOpacity(0.90),
                          child: Icon(
                            Icons.music_note,
                            color: Colors.white,
                            size: Dimensions.iconSize25,
                          ),
                        ),
                      ),
                      trailing: SizedBox(
                        width: Dimensions.width20,
                        child: Padding(
                            padding: const EdgeInsets.all(0),
                            child: PopupMenuButton(
                              icon: Icon(Icons.more_vert,
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.90)),
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                    value: 0,
                                    onTap: () {
                                      allAudiosScreenController.deleteSongModel(
                                          index); // To delete the songModel and refresh ListView by updateItem.
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                            allAudiosScreenController
                                                .itemList[0].icon,
                                            color: Theme.of(context)
                                                .primaryColor
                                                .withOpacity(0.90),
                                            size: Dimensions.iconSize20),
                                        SizedBox(
                                          width: Dimensions.width14,
                                        ),
                                        Text(allAudiosScreenController
                                            .itemList[0].text),
                                      ],
                                    )),
                                PopupMenuItem(
                                    value: 1,
                                    onTap: () {
                                      allAudiosScreenController
                                          .reNameSongModelTitle(
                                              index); // To rename the songModel Title and refresh ListView by updateItem.
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                            allAudiosScreenController
                                                .itemList[1].icon,
                                            color: Theme.of(context)
                                                .primaryColor
                                                .withOpacity(0.90),
                                            size: 20),
                                        SizedBox(
                                          width: Dimensions.width14,
                                        ),
                                        Text(allAudiosScreenController
                                            .itemList[1].text),
                                      ],
                                    )),
                              ],
                            )),
                      ),
                      onTap: () {
                        Get.to(
                          () => const AudioScreen(),
                          arguments: {
                            'advancedPlayer':
                                allAudiosScreenController.advancedPlayer,
                            'listSongModel': allAudiosScreenController
                                .songsModelsController[index],
                            'index': index,
                            'title': allAudiosScreenController
                                .songsTitleSearchController,
                          },
                        );
                      },
                    );
                  }));
        });
  }
}

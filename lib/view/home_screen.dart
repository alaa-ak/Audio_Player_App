import 'package:flutter/material.dart';
import 'package:music_player_app/utils/dimensions.dart';
import 'audios-search-screen.dart';
import 'all_audios_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: Dimensions.positionedHeightDividedBy3,
          child: Container(
            color: Theme.of(context).primaryColor.withOpacity(0.90),
          ),
        ),
        Positioned(
            top: Dimensions.positionedHeightDividedBy60,
            left: 0,
            right: Dimensions.positionedWidthDividedBy50,
            child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                title: Text('Audio Player',
                    style: TextStyle(
                      fontSize: Dimensions.fontSize24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Ayenir',
                      color: Colors.white,
                    )),
                actions: [
                  IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                      size: Dimensions.iconSize30,
                    ),
                    onPressed: () async {
                      await showSearch(
                          context: context, delegate: AudiosSearchScreen());
                    }, // Call showSearch function for Searching
                  ),
                ])),
        Positioned(
            left: 0,
            right: 0,
            top: Dimensions.positionedHeightMultiPlied0Point30,
            height: Dimensions.positionedHeightMultiPlied0Point16,
            child: Container(
                decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius40),
              color: Colors.white,
            ))),
        Positioned(
          top: Dimensions.positionedHeightMultiPlied0Point17,
          left: Dimensions.positionedWidthDividedBy2Point7,
          right: Dimensions.positionedWidthDividedBy2Point7,
          height: Dimensions.positionedHeightMultiPlied0Point23,
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
          left: 0,
          right: 0,
          top: Dimensions.positionedHeightMultiPlied0Point40,
          height: Dimensions.positionedHeighMultiPlied0Point60,
          child: Container(
            height: Dimensions.heigh500,
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.only(
                left: Dimensions.width8,
              ),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: SizedBox(
                      height: Dimensions.heightMultied0Point2,
                      child:
                          const AllAudiosScreen(), // The widget that has all audios
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

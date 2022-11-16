import 'package:flutter/material.dart';
import 'widget/portrait_landscape_player_page.dart';

class DummyVideoScreen extends StatelessWidget {
  const DummyVideoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      // body: BetterPlayer.network(
      //   'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
      //   betterPlayerConfiguration:
      //   const BetterPlayerConfiguration(
      //       autoPlay: true,
      //       looping: true,
      //       aspectRatio: 9 / 16,
      //       fit: BoxFit.cover),
      // ),
      /* body: VideoItems(
        videoPlayerController:
            VideoPlayerController.network(
             'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
            ),
        key: UniqueKey(),
        showOptions: false,
        aspectRatio: 9 / 16,
        padding: EdgeInsets.zero,
      ),*/
      body: const PortraitLandscapePlayerPage(
        url:
            'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
      ),
    );
  }
}

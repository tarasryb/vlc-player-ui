import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:vlc_player_ui/vlc_player_ui.dart';

import 'constants.dart';
import 'theme.dart';

class AiVideoPage extends StatefulWidget {
  AiVideoPage({Key key}) : super(key: key);

  @override
  _AiVideoPageState createState() {
    return _AiVideoPageState();
  }
}

class _AiVideoPageState extends State<AiVideoPage> {

  VlcPlayerUiController chewieController;

  @override
  void initState() {
    super.initState();
  }

  void createVideo() {
    if (chewieController == null) {
      chewieController = VlcPlayerUiController(
          onInit: () {
            chewieController.play();
          }
        // videoPlayerController: VideoPlayerController.network(videoName)//asset(videoName)
        //   ..addListener(listener)
        //   ..setVolume(1.0)
        //   ..initialize(),
        // cupertinoProgressColors: ChewieProgressColors(handleColor: Colors.cyanAccent, playedColor: Colors.cyan),
        // materialProgressColors: ChewieProgressColors(handleColor: Colors.cyanAccent, playedColor: Colors.cyan),
      );
    }

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    if(chewieController==null) {
        createVideo();
      }


    return WillPopScope(
      onWillPop: () async {
        if(chewieController!=null){
          chewieController.pause();
        }
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        backgroundColor: ColorThemeDark.backgroundColor,

        appBar: AppBar(
          title: Text('1on1 Ballet Studio'),
          backgroundColor: ColorThemeDark.backgroundColor,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: ColorThemeDark.cardBackgroundColor,
                    borderRadius: new BorderRadius.all(
                      const Radius.circular(10.0),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Artifical Intelligence', style: ColorThemeDark.sectionTextStyle,),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: //widget.root.picture,

                        Center(
                          child: Container(
                            child: (chewieController != null
                                ? Container(
                              child: AspectRatio(
                                aspectRatio: promo_video_aspect_ratio,
                                child: Container(
                                  //width: 580,
                                  //height: 270,

                                  child:
                                  VlcPlayerUi(
                                    aspectRatio: promo_video_aspect_ratio,
                                    backgroundColor: ColorThemeDark.cardBackgroundColor,
                                    url: ai_video,
                                    isLocalMedia: false,
                                    controller: chewieController,
                                    autoplay: false,
                                    // Play with vlc options
                                    options: [
                                      '--quiet',
                                      '--no-drop-late-frames',
                                      '--no-skip-frames',
                                      '--rtsp-tcp',
                                    ],
                                    hwAcc: HwAcc.AUTO,
                                    placeholder: Container(
                                      height: 250.0,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[CircularProgressIndicator()],
                                      ),
                                    ),
//              showControlPanel: _showControlPanel,
                                  ),
                                  // Chewie(
                                  //   controller: chewieController,
                                  // ),
                                ),
                              ),
                            )
                                : Image.asset('assets/promo_video.jpg')),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );


  }
}
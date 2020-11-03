import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:vlc_player_ui/vlc_player_ui.dart';
import 'package:vlc_player_ui_example/ai_video.dart';

import 'TestPage2.dart';

void main() {
  runApp(
      MaterialApp(
        home: MyApp(),
      )
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  String initUrl =
      // "http://distribution.bbb3d.renderfarming.net/video/mp4/bbb_sunflower_1080p_30fps_normal.mp4";
        //"https://1751703346.rsc.cdn77.org/p1/p1_e10_l_c2.mp4";
      "https://1751703346.rsc.cdn77.org/p1/p1_e13_l_c2.mp4";
  String initUrl2 = "https://1751703346.rsc.cdn77.org/p1/p1_e10_l_c2.mp4";

  VlcPlayerUiController _videoViewController;
  GlobalKey playerKey;
  bool _showControlPanel = true;

  @override
  void initState() {
    super.initState();
    initPlatformState();
    playerKey = GlobalKey();

    _videoViewController = new VlcPlayerUiController(onInit: () {
      _videoViewController.play();
      // setState(() {
      // });
    }
    );
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      //platformVersion = await VlcPlayerUi.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('VLC Player Test app'),
          actions: [
            IconButton(
              icon: Icon(Icons.movie_outlined),
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondRoute()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.ondemand_video),
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AiVideoPage()),
                );
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Center(
              child: Text('Running on: $_platformVersion\n'),
            ),

      SizedBox(
        height: 200,
        child: new VlcPlayerUi(
//          key: playerKey,
          aspectRatio: 16 / 9,
          url: initUrl,
          isLocalMedia: false,
          controller: _videoViewController,
          autoplay: false,
          // Play with vlc options
          options: [
            '--quiet',
//                '-vvv',
            '--no-drop-late-frames',
            '--no-skip-frames',
            '--rtsp-tcp',
          ],
          hwAcc: HwAcc.AUTO,
          // or {HwAcc.AUTO, HwAcc.DECODING, HwAcc.FULL, HwAcc.DISABLED}
          placeholder: Container(
            height: 250.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[CircularProgressIndicator()],
            ),
          ),
          showControlPanel: _showControlPanel,
        ),
      ),

          ],
        ),
        floatingActionButton: FloatingActionButton(
              onPressed: () {

            // Call setState. This tells Flutter to rebuild the
            // UI with the changes.
            setState(() {
              //_showControlPanel = !_showControlPanel;
              //VlcPlayerUiController.vLcStreamController.add('event');
              _videoViewController.setStreamUrl(initUrl2);
              //_videoViewController.play();
            });
        },
        tooltip: 'Toggle Opacity',
          child: Icon(Icons.flip),
          ),
      ),
    );
  }
}

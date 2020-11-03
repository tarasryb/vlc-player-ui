import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:vlc_player_ui/vlc_player_ui.dart';



class SecondRoute extends StatefulWidget {
  SecondRoute({Key key}) : super(key: key);

  @override
  _SecondRouteState createState() {
    return _SecondRouteState();
  }
}

  class _SecondRouteState extends State<SecondRoute> {

    String initUrl =
        "https://1751703346.rsc.cdn77.org/p2/p2_e1_c4.mp4";
    VlcPlayerUiController _videoViewController;


  @override
  void initState() {
    super.initState();

    _videoViewController = new VlcPlayerUiController(onInit: () {
      _videoViewController.play();
      // setState(() {
      // });
    }
    );
  }

  @override
  void dispose() {
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Test Page"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate back to first route when tapped.
          },
          child:
          SizedBox(
            height: 200,
            child: new VlcPlayerUi(
//          key: playerKey,
              aspectRatio: 16 / 9,
              backgroundColor: Theme.of(context).primaryColor,
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
//              showControlPanel: _showControlPanel,
            ),
          ),


        ),
      ),
    );
  }
}
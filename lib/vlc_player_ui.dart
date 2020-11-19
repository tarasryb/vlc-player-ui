import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

import 'SliderUpdate.dart';
import 'TextUpdate.dart';

const magentaColor = Color(0x7C5096);
const magentaColor2 = Color(0xf8a0ff);

class VlcPlayerUiController extends VlcPlayerController{
  VlcPlayerUiController({
    VoidCallback onInit,
    CastCallback onCastHandler
  }):super(onInit:onInit, onCastHandler:onCastHandler);

  static StreamController<String> vLcStreamController = StreamController<String>.broadcast();

  Future<void> setStreamUrl(String url,
      {bool isLocalMedia,
        String subtitle,
        bool isLocalSubtitle,
        bool isSubtitleSelected}){


    super.setStreamUrl(url,
    isLocalMedia: isLocalMedia,
    isLocalSubtitle: isLocalSubtitle,
    isSubtitleSelected: isSubtitleSelected);

    VlcPlayerUiController.vLcStreamController.add('url : ${url}');

  }
}

class VlcPlayerUi extends StatefulWidget {
  _VlcPlayerUiState state;
  final double aspectRatio;
  final Color backgroundColor;
  final HwAcc hwAcc;
  final List<String> options;
  final bool autoplay;
  String url;
  final bool isLocalMedia;
  final String subtitle;
  final bool isLocalSubtitle;
  final bool isSubtitleSelected;
  final bool loop;
  final Widget placeholder;
  final VlcPlayerUiController controller;
  bool showControlPanel;

  VlcPlayerUi(
      {Key key,
      this.aspectRatio,
      this.backgroundColor: Colors.white,
      this.hwAcc,
      this.options,
      this.autoplay,
      this.url,
      this.isLocalMedia,
      this.subtitle,
      this.isLocalSubtitle,
      this.isSubtitleSelected,
      this.loop,
      this.placeholder,
      this.controller,
      this.showControlPanel: true})
      : super(key: key);

  @override
  _VlcPlayerUiState createState() {
    state = _VlcPlayerUiState();
    return state;
  }

}

class _VlcPlayerUiState extends State<VlcPlayerUi> {
  double sliderValue;
  bool sliderMoving;
  String textIndicatorValue;
  String position;
  String duration;
  bool isBuffering;
  bool isError;
  bool isPlaying;
  PlayingState prevPlayingState;
  final Duration hidePanelTimeout = const Duration(milliseconds: 5000);
  Timer hidePanelTimer;
  final GlobalKey playerKey = GlobalKey(debugLabel: 'playerKey');
  final GlobalKey sliderKey = GlobalKey(debugLabel: 'sliderKey');
  final GlobalKey sliderKey2 = GlobalKey(debugLabel: 'sliderKey2');
  Duration oPosition;
  Duration oDuration;
  SliderUpdate slider;
  SliderUpdate slider2;
  TextUpdate textIndicator;
  bool waitingForFirstFrame;

  void initFields(){
    position = '';
    duration = '';
    isPlaying = false;
    isBuffering = false;
    prevPlayingState = null;
    sliderValue = 0;
    sliderMoving =false;
    waitingForFirstFrame = true;
    isError = false;
  }

  @override
  void initState() {
    super.initState();
    initFields();

    VlcPlayerUiController.vLcStreamController.stream.asBroadcastStream().listen((message){
      setState(() {
        //initFields();
        var split = message.split(' : ');
        if(split.length==2)
          if(split[0]=='url')
            widget.url = split[1];
        prevPlayingState = null;
        waitingForFirstFrame = true;
        isError = false;
        widget.controller.play();
        print('+>>>>>>>>>>>> $message');
      });
    });

    widget.controller.addListener(controllerListener);

    slider = SliderUpdate(
        value: sliderValue==null?0:sliderValue,
        max: widget.controller.duration == null
            ? 1.0
            : widget.controller.duration.inSeconds.toDouble(),
        min: 0,
        onChangeStart: (__){
          setState(() {
            sliderMoving = true;
            print('***            sliderMoving = true');
          });
        },
        onChangeEnd: (__){
          setState(() {
            sliderMoving = false;
            print('***            sliderMoving = false');
          });
        },
        onChanged: (pos){
          print('$pos');
          setState(() {
            sliderValue = pos.floor().toDouble();
          });
          widget.controller.setTime(sliderValue.toInt() * 1000);
        });

    slider2 = SliderUpdate(
        value: sliderValue==null?0:sliderValue,
        max: 1,
        min: 0,
        onChanged: (pos){
          print('$pos');
        });

    textIndicator = TextUpdate(
        '-:-/-:-',
      style: TextStyle(
          color: magentaColor2.withAlpha(255),
          fontSize: 12
      ),
    );
  }

  @override
  void dispose() {
    widget.controller.removeListener(controllerListener);
//    VlcPlayerUiController.vLcStreamController.close();
    super.dispose();
  }

  void controllerListener(){
      if (!this.mounted) return;
      if (widget.controller.initialized) {
        oPosition = widget.controller.position;
        oDuration = widget.controller.duration;
        if (oDuration.inHours == 0) {
          String strPosition = oPosition.toString().split('.')[0];
          String strDuration = oDuration.toString().split('.')[0];
          position =
          "${strPosition.split(':')[1]}:${strPosition.split(':')[2]}";
          duration =
          "${strDuration.split(':')[1]}:${strDuration.split(':')[2]}";
        } else {
          position = oPosition.toString().split('.')[0];
          duration = oDuration.toString().split('.')[0];
        }

        sliderValue = oPosition == null || oDuration == null || oDuration == Duration.zero
            ? 0
            : oPosition.inSeconds.toDouble() /
            oDuration.inSeconds.toDouble();
        textIndicatorValue = '${position}/${duration}';

        slider.update(oPosition.inSeconds, oDuration.inSeconds);//sliderValue);
        slider2.update(oPosition.inSeconds, oDuration.inSeconds);//sliderValue);
        textIndicator.update(textIndicatorValue);

        if(widget.controller.playingState == prevPlayingState){
          return;
        }
        prevPlayingState = widget.controller.playingState;
        switch (widget.controller.playingState) {
          case PlayingState.PAUSED:
            setState(() {
              isPlaying = false;
              isBuffering = false;
            });
            break;

          case PlayingState.STOPPED:
            setState(() {
              isPlaying = false;
              isBuffering = false;
            });
            break;
          case PlayingState.BUFFERING:
            setState(() {
              isBuffering = true;
            });
            break;
          case PlayingState.PLAYING:
            setState(() {
              if(waitingForFirstFrame){
                waitingForFirstFrame = false;
                  widget.controller.pause().then((value){
                    widget.controller.setTime(0).then((value){
                      if(widget.autoplay){
                        widget.controller.play();
                      }else{
                        widget.controller.pause();
                      }
                    });
                  });
              }
              isPlaying = true;
              isBuffering = false;
            });
            break;
          case PlayingState.ERROR:
            setState(() {
              isError = true;
            });
            print("VLC encountered error");
            break;
          default:
            setState(() {});
            break;
        }
      }else{
        //not widget.controller.initialized
      }
  }

  @override
  Widget build(BuildContext context) {
    final RenderBox renderBoxRed= playerKey.currentContext?.findRenderObject();

    if(hidePanelTimer==null && widget.showControlPanel) {
      hidePanelTimer = Timer(hidePanelTimeout, () {
        hidePanelTimer = null;
        setState(() {
          if(!sliderMoving) {
            widget.showControlPanel = false;
          }
        });
      });
    }

    //update both of sliders and text indicator
    Timer(Duration(milliseconds: 100),
        (){
          slider.update(oPosition.inSeconds, oDuration.inSeconds);
          slider2.update(oPosition.inSeconds, oDuration.inSeconds);
          textIndicator.update(textIndicatorValue);
        });

    //print('***** Slider value: ${sliderValue}, ${oPosition}/${oDuration}');

    if(isError){
      return Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.amber, size: 50),
            Padding(
              padding: const EdgeInsets.symmetric(vertical:8.0),
              child: Text("You've got an error. Try to reload.", style: TextStyle(color: Colors.amber, fontSize: 20),),
            ),
            FlatButton(
              onPressed: () {
                widget.controller.setStreamUrl(widget.url);
              },
              child:
              Image.asset(
                'icons/rePlay.png',
                package: 'vlc_player_ui',
              ),
            ),

          ],
        ),
      );
    }

    return Stack(
      children: [
        Center(
          child:
          Stack(
            children: [
              Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      color: widget.backgroundColor,
                    ),
                  ),
                ],
              ),
              Center(
                child: Container(
                  key: playerKey,
                  child: VlcPlayer(
                    aspectRatio: widget.aspectRatio,
                    url: widget.url,
                    isLocalMedia: widget.isLocalMedia,
                    controller: widget.controller,
                    autoplay: widget.autoplay,
                    options: widget.options,
                    hwAcc: widget.hwAcc,
                    placeholder: widget.placeholder,
                  ),
                ),
              ),
            ],
          ),
        ),

        waitingForFirstFrame || isBuffering
        ?Center(
          child: CircularProgressIndicator(

          ),
        )
        :

        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            if(!widget.showControlPanel) {
              hidePanelTimer?.cancel();
              setState(() {
                widget.showControlPanel = true;
              });
            }else{
              setState(() {
                widget.showControlPanel = false;
              });
            }
          },
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 200),
            reverseDuration: Duration(milliseconds: 500),
            child: widget.showControlPanel
                ? Container(
                    key: UniqueKey(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(''),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            FlatButton(
                              onPressed: (){
                                widget.controller.getTime().then((value){widget.controller.setTime(value - 5000);});
                                sliderMoving = false;
                              },
                              child: Image.asset(
                                'icons/goBack5s.png',
                                package: 'vlc_player_ui',
                              ),
                            ),

                            isPlaying
                            ?FlatButton(
                              onPressed: (){
                                widget.controller.pause();
                                sliderMoving = false;
                                },
                              child: Image.asset(
                                'icons/pause.png',
                                package: 'vlc_player_ui',
                              ),
                            )
                            :FlatButton(
                              onPressed: (){
                                widget.controller.play();
                                sliderMoving = false;
                                },
                              child: Image.asset(
                                'icons/play.png',
                                package: 'vlc_player_ui',
                              ),
                            ),

                            FlatButton(
                              onPressed: (){
                                widget.controller.setTime(0);
                                widget.controller.play();
                                sliderMoving = false;
                                },
                              child:
                              Image.asset(
                                'icons/rePlay.png',
                                package: 'vlc_player_ui',
                              ),
                            ),

                          ],
                        ),
                        Container(
                          width: renderBoxRed?.size?.width== null ? 100 : renderBoxRed?.size?.width + 32,
                          child: Column(
                            children: [

                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal:18.0),
                                    child: textIndicator,
                                  ),
                                ],
                              ),

                              SliderTheme(
                                data: SliderThemeData(
                                  activeTrackColor: magentaColor.withAlpha(255),
                                  inactiveTrackColor: magentaColor.withAlpha(128),
                                  trackHeight: 2.0,
                                  thumbColor: Colors.purple.withAlpha(255),
                                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6.0),
                                  overlayColor: Colors.purple.withAlpha(128),
                                  overlayShape: RoundSliderOverlayShape(overlayRadius: 16.0),
                                ),
                                child: slider,
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  )
                : Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(//controls appeared if control panel is not shown
                            width: renderBoxRed?.size?.width== null ? 100 : renderBoxRed?.size?.width,
                       padding: const EdgeInsets.only(bottom:1.0),
                            child: SliderTheme(
                          data: SliderThemeData(
                            activeTrackColor: magentaColor2.withAlpha(255),
                            inactiveTrackColor: magentaColor2.withAlpha(128),
                            trackHeight: 3.0,
                            thumbColor: Colors.purple.withAlpha(255),
                            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 0.0),
                            overlayColor: Colors.purple.withAlpha(128),
                            overlayShape: RoundSliderOverlayShape(overlayRadius: 0.0),
                          ),
                          child: slider2,
              ),

            ),
                        ],
                      ),
                    ],
                  ),
                ),
          ),
        ),
      ],
    );
  }
}

class VlcPlayerUi0 extends VlcPlayer {
  static const MethodChannel _channel = const MethodChannel('vlc_player_ui');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}

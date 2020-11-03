import 'package:flutter/material.dart';
import 'dart:ui' as ui show TextHeightBehavior;

class TextUpdate extends StatefulWidget {
  _TextUpdateState state;

   String data;
  final TextStyle style;
  final StrutStyle strutStyle;
  final TextAlign textAlign;
  final TextDirection textDirection;
  final Locale locale;
  final bool softWrap;
  final TextOverflow overflow;
  final double textScaleFactor;
  final int maxLines;
  final String semanticsLabel;
  final TextWidthBasis textWidthBasis;
  final ui.TextHeightBehavior textHeightBehavior;


   TextUpdate(
      this.data, {
        Key key,
        this.style,
        this.strutStyle,
        this.textAlign,
        this.textDirection,
        this.locale,
        this.softWrap,
        this.overflow,
        this.textScaleFactor,
        this.maxLines,
        this.semanticsLabel,
        this.textWidthBasis,
        this.textHeightBehavior,
      }) : super(key: key);

  @override
  _TextUpdateState createState() {
    return _TextUpdateState();
  }

  void update(String val){
    if(state==null)return;
    if( val==null)return;
    if(state.mounted) {
      try {
        state.setState(() {
          data = val;
        });
      }
      catch (e) {}
    }
  }

}

class _TextUpdateState extends State<TextUpdate> {
  @override
  void initState() {
    super.initState();
    widget.state = this;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
        widget.data,
        key: widget.key,
        style: widget.style,
        strutStyle: widget.strutStyle,
        textAlign: widget.textAlign,
        textDirection: widget.textDirection,
        locale: widget.locale,
        softWrap: widget.softWrap,
        overflow: widget.overflow,
        textScaleFactor: widget.textScaleFactor,
        maxLines: widget.maxLines,
        semanticsLabel: widget.semanticsLabel,
        textWidthBasis: widget.textWidthBasis,
        textHeightBehavior: widget.textHeightBehavior
    );
  }
}
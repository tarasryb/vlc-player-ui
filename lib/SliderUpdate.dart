import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SliderUpdate extends StatefulWidget {
  _SliderUpdateState state;
  final Key key;
  double value = 0;
  final ValueChanged<double> onChanged;
  final ValueChanged<double> onChangeStart;
  final ValueChanged<double> onChangeEnd;
  final double min;
  final double max;
  final int divisions;
  final String label;
  final Color activeColor;
  final Color inactiveColor;
  final MouseCursor mouseCursor;
  final SemanticFormatterCallback semanticFormatterCallback;
  final FocusNode focusNode;
  final bool autofocus;

  SliderUpdate({
    this.key,
    @required this.value,
    @required this.onChanged,
    this.onChangeStart,
    this.onChangeEnd,
    this.min = 0.0,
    this.max = 1.0,
    this.divisions,
    this.label,
    this.activeColor,
    this.inactiveColor,
    this.mouseCursor,
    this.semanticFormatterCallback,
    this.focusNode,
    this.autofocus = false,
  }) : super(key: key);

  @override
  _SliderUpdateState createState() {
    return _SliderUpdateState();
  }

  void update(double val){
    if(state==null)return;
    if(state.mounted) {
      try {
        state.setState(() {
          value = val;
        });
      }
      catch (e) {}
    }
  }

}

class _SliderUpdateState extends State<SliderUpdate> {
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
    // TODO: implement build
    return Slider(
        key: widget.key,
        value: widget.value,
        onChanged: widget.onChanged,
        onChangeStart: widget.onChangeStart,
        onChangeEnd: widget.onChangeEnd,
        min: widget.min,
        max: widget.max,
        divisions: widget.divisions,
        label: widget.label,
        activeColor: widget.activeColor,
        inactiveColor: widget.inactiveColor,
        mouseCursor: widget.mouseCursor,
        semanticFormatterCallback: widget.semanticFormatterCallback,
        focusNode: widget.focusNode,
        autofocus: widget.autofocus
    );
  }
}


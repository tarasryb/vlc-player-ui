import 'package:flutter/material.dart';
// import 'package:charts_flutter/flutter.dart' as charts;

class ColorThemeDark {

  static Color backgroundColor = Color.fromRGBO(20, 17, 53, 1);
  static Color backgroundColor_05 = Color.fromRGBO(20, 17, 53, 0.5);
  static Color backgroundColorBN = Color.fromRGBO(0x25, 0x23, 0x47, 1);
  static Color backgroundColor2 = Color.fromRGBO(70, 67, 83, 0.5);
  static Color backgroundColor3 = Color.fromRGBO(120, 117, 253, 0.5);
  static Color appBarBackgroundColor = Color.fromRGBO(0xc4, 0xc4, 0xc4, 0.1);
  static Color bottomNavigationBackgroundColor = Color.fromRGBO(32, 30, 54, 1.0);
  static Color cardBackgroundColor = Color.fromRGBO(81, 80, 150, 1.0);
  static Color cardBackgroundColor2 = Color.fromRGBO(0x50, 0x80, 0x96, 1.0);//81, 170, 150, 1.0
  static Color cardExBackgroundColor0 = Color.fromRGBO(181, 175, 205, 1.0);
  static Color cardExBackgroundColor = Color.fromRGBO(221, 215, 245, 1.0);
  static Color semitransparentPanelColor = Color.fromRGBO(70, 70, 90, 0.5);

  static Color iconColor = new Color.fromRGBO(173, 172, 185, 1);
  static TextStyle textStyle = new TextStyle(color:Color.fromRGBO(173, 172, 185, 1), fontSize: 18.0, fontWeight: FontWeight.w300, fontFamily: 'sourcesanspro');
  static TextStyle inverseTextStyle = new TextStyle(color:Color.fromRGBO(73, 72, 85, 1), fontSize: 18.0, fontWeight: FontWeight.w300, fontFamily: 'sourcesanspro');
  static TextStyle hintStyle = new TextStyle(color: Color.fromRGBO(103, 102, 115, 1), fontSize: 18.0, fontWeight: FontWeight.w300, fontFamily: 'sourcesanspro');
  static TextStyle asteriscTextStyle = new TextStyle(color: Colors.orangeAccent, fontSize: 16.0, fontWeight: FontWeight.w300, height: 1.0, fontFamily: 'sourcesanspro');
  static TextStyle errTextStyle = new TextStyle(color: Colors.red, fontSize: 13.0, fontWeight: FontWeight.w300, height: 1.0, fontFamily: 'sourcesanspro');

  static TextStyle hintTextStyle = new TextStyle(color:Color.fromRGBO(193, 192, 205, 1), fontSize: 18.0, fontWeight: FontWeight.w300, fontFamily: 'sourcesanspro');
  static TextStyle hintTextInvStyle = new TextStyle(color:inverseTextStyle.color, fontSize: 18.0, fontWeight: FontWeight.w300, fontFamily: 'sourcesanspro');
  static TextStyle videoDataTextStyle = new TextStyle(color:Color.fromRGBO(143, 142, 255, 1), fontSize: 14.0, fontWeight: FontWeight.w300, fontFamily: 'sourcesanspro');

  static TextStyle buttonTextStyle = new TextStyle(color:Colors.white, fontSize: 20.0, fontWeight: FontWeight.w600, fontFamily: 'sourcesanspro');
  static TextStyle appBarSectionTextStyle = new TextStyle(color:Colors.white, fontSize: 18.0, fontWeight: FontWeight.w400, fontFamily: 'sourcesanspro');
  static TextStyle sectionTextStyle = new TextStyle(color:Colors.white, fontSize: 22.0, fontWeight: FontWeight.w600, /*decoration: TextDecoration.underline,*/ fontFamily: 'sourcesanspro');
  static TextStyle topicTextStyle = new TextStyle(color:Colors.white, fontSize: 16.0, fontWeight: FontWeight.w400, fontFamily: 'sourcesanspro');
  static TextStyle topicDisabledTextStyle = new TextStyle(color:Color.fromRGBO(154, 154, 154, 1), fontSize: 16.0, fontWeight: FontWeight.w400, fontFamily: 'sourcesanspro');
  static TextStyle topicTextInvStyle = new TextStyle(color:inverseTextStyle.color, fontSize: 16.0, fontWeight: FontWeight.w400, fontFamily: 'sourcesanspro');

  static Color topic1Color = Color.fromRGBO(81, 80, 150, 1);
  static Color topic2Color = Color.fromRGBO(124, 80, 150, 1);

  static Color gingerColor = Color.fromRGBO(205, 101, 38, 1);
  static Color gingerColor2 = Color.fromRGBO(205, 101, 38, 0.5);
  static Color gingerAccentColor = Color.fromRGBO(248, 168, 60, 1);

  static Color drawerBackgroundColor = Color.fromRGBO(70, 67, 133, 1);
  static Color drawerBackgroundColor2 = Color.fromRGBO(120, 117, 253, 1);

  static Color accuracyGaugeColor = Color.fromRGBO(0xf8, 0xa8, 0x3c, 1);//Color.fromRGBO(248, 168, 60, 1);
  static Color energyGaugeColor = Color.fromRGBO(0x7c, 0x50, 0x96, 1);//Color.fromRGBO(0xd3, 0x87, 0xff, 1);
  static Color timeGaugeColor = Color.fromRGBO(0x51, 0x50, 0x96, 1);//Color.fromRGBO(0x89, 0x87, 0xff, 1);
  static Color gaugeSecondaryColor = Color.fromRGBO(255, 255, 255, 1);

  static TextStyle gaugeValueStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white);
  static TextStyle gaugeSelectedValueStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white);
  static TextStyle gaugeLabelStyle = TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white);
  static TextStyle gaugeSelectedLabelStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white);

  static TextStyle methodologyHtmlStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color:  Color.fromRGBO(0x231, 0x230, 0x236, 1));

  static final ThemeData themeData = new ThemeData(
    // Define the default brightness and colors.
    brightness: Brightness.dark,
    //primaryColor: Colors.lightBlue[800],
    //accentColor: Colors.deepPurpleAccent,

    // Define the default font family.
    fontFamily: 'sourcesanspro',

    // Define the default TextTheme. Use this to specify the default
    // text styling for headlines, titles, bodies of text, and more.
    textTheme: TextTheme(
      //headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
      //title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
      //body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
    ),
  );

}

class ChartStyles{
  /*
  static final charts.Color accuracyColor =     charts.Color(r:0xf8, g:0xa8, b:0x3c);
  static final charts.Color accuracyAreaColor = charts.Color(r:0xf8, g:0xa8, b:0x3c, a:90, );
  static final charts.Color energyColor =       charts.Color(r:0x7c, g:0x50, b:0x96);
  static final charts.Color energyAreaColor =   charts.Color(r:0x7c, g:0x50, b:0x96, a:90);
  static final charts.Color timeColor =         charts.Color(r:0x51, g:0x50, b:0x96);
  static final charts.Color timeAreaColor =     charts.Color(r:0x51, g:0x50, b:0x96, a:90);

  static final charts.Color bodyColor = charts.Color(r:0xf8, g:0xa8, b:0x3c);
  static final charts.Color bodyAreaColor = charts.Color(r:0xf8, g:0xa8, b:0x3c, a:90, );
  static final charts.Color neckColor = charts.Color(r:0x7c, g:0x50, b:0x96);
  static final charts.Color neckAreaColor = charts.Color(r:0x7c, g:0x50, b:0x96, a:90, );
  static final charts.Color handsColor = charts.Color(r:0x51, g:0x50, b:0x96);
  static final charts.Color handsAreaColor = charts.Color(r:0x51, g:0x50, b:0x96, a:90, );
  static final charts.Color legsColor = charts.Color(r:0xcf, g:0x29, b:0x29);
  static final charts.Color legsAreaColor = charts.Color(r:0xcf, g:0x29, b:0x29, a:90, );

  static final TextStyle dateStyle = TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.white);//gaugeSecondaryColor);

   */
}


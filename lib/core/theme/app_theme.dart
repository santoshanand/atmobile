import 'package:flutter/material.dart';

ThemeData get applicationTheme {
  return ThemeData(
    primarySwatch: Styles.blue,
  );
}

class Styles {
  static const MaterialColor blue = MaterialColor(_bluePrimaryValue, <int, Color>{
    50: Color(0xFFE0EDFF),
    100: Color(0xFFB3D2FF),
    200: Color(0xFF80B5FF),
    300: Color(0xFF4D97FF),
    400: Color(0xFF2680FF),
    500: Color(_bluePrimaryValue),
    600: Color(0xFF0062FF),
    700: Color(0xFF0057FF),
    800: Color(0xFF004DFF),
    900: Color(0xFF003CFF),
  });
  static const int _bluePrimaryValue = 0xFF006AFF;

  static const MaterialColor blueAccent = MaterialColor(_blueAccentValue, <int, Color>{
    100: Color(0xFFFFFFFF),
    200: Color(_blueAccentValue),
    400: Color(0xFFBFCAFF),
    700: Color(0xFFA6B5FF),
  });
  static const int _blueAccentValue = 0xFFF2F4FF;
  static const Color _subTitleColor = Color(0x95000000);
  // static const Color _titleColor = Colors.black87;
  // static const double _titleFontSize = 16;
  static const double _subHeadFontSize = 11;
  static const Color _iconColor = Colors.grey;
  static const Color _whiteColor = Colors.white;
  static const double _bodyFontSize = 14;
  // static const Color _colorOne = Color(0xff222831);
  // static const Color _colorEE = Color(0xffeeeeee);
  // static const Color _colorD4 = Color(0xffD4D4D4);
  static const Color _titleColor = Color(0xff0D0F13);
  static const Color colorBlack_37414F = Color(0xFF37414F);
  static const double h3 = 20;
  static const double h4 = 18;

  static const double _badgeFontSize = 8;
  static const double gap = 24.0;
  static const double margin = 16.0;

  static TextStyle get subhead {
    return const TextStyle(
      fontSize: _subHeadFontSize,
      color: _subTitleColor,
    );
  }

  static TextStyle get title {
    return const TextStyle(
      color: _titleColor,
      fontSize: _bodyFontSize,
      overflow: TextOverflow.fade,
    );
  }

  static TextStyle get titleApp {
    return const TextStyle(
      color: _titleColor,
      fontSize: h3,
      overflow: TextOverflow.ellipsis,
    );
  }

  static TextStyle get titleMain {
    return const TextStyle(
      color: _titleColor,
      fontSize: h4,
      overflow: TextOverflow.ellipsis,
    );
  }

  static TextStyle get titleUser {
    return const TextStyle(
      color: _titleColor,
      fontSize: 14,
      overflow: TextOverflow.ellipsis,
    );
  }

  static TextStyle get badge {
    return const TextStyle(
      color: _subTitleColor,
      fontSize: _badgeFontSize,
    );
  }

  static TextStyle get searchStyle {
    return const TextStyle(
      color: _iconColor,
      fontSize: _bodyFontSize,
    );
  }

  static Color get bgColor {
    return const Color(0xffF7F7F7);
  }

  static Color get titleColor {
    return _subTitleColor;
  }

  static Color get whiteColor {
    return _whiteColor;
  }

  static Color get iconColor {
    return _iconColor;
  }

  static Color get darkColor {
    return _titleColor;
  }

  static TextStyle get emptyStyle {
    return const TextStyle(color: _iconColor, fontSize: h3);
  }

  static TextStyle get redStyle {
    return const TextStyle(color: Colors.red, fontSize: _bodyFontSize);
  }

  static TextStyle get greenStyle {
    return const TextStyle(color: Colors.green, fontSize: _bodyFontSize);
  }

  static TextStyle get listItemTop {
    return const TextStyle(color: _iconColor, fontSize: 12);
  }

  static TextStyle get badgeCircleText {
    return const TextStyle(color: Colors.white, fontSize: _badgeFontSize);
  }
}

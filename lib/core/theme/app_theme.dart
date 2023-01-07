import 'package:flutter/material.dart';

ThemeData get applicationTheme {
  return ThemeData(
    primarySwatch: Colors.blue,
  );
}

class Styles {
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
  // static const Color _colorGrey = Color(0xff37414F);
  static const double h3 = 20;

  static const double _badgeFontSize = 8;
  static const double gap = 24.0;

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
    );
  }

  static TextStyle get badge {
    return const TextStyle(
      color: _subTitleColor,
      fontSize: _badgeFontSize,
    );
  }

  static Color get bgColor {
    return const Color(0xffeeeeee);
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

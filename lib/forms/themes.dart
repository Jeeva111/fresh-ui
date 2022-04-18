import 'package:flutter/material.dart';

class FormThemes {
  static const Color appTheme = Color(0xff9cb533);
  static const Color appLabelColor = Color(0xff202020);
  static const Color appHeaderColor = Color(0xff9e7d49);
  static const Widget SpaceDivider = SizedBox(height: 20.0);
  static const TextStyle formHeaderStyle = TextStyle(
      fontSize: 20.0, color: Color(0xff202020), fontWeight: FontWeight.bold);

  // Textinput
  static const Color labelColor = Color(0xff3E4E32);
  static const BorderRadius inputBorderRadius =
      BorderRadius.all(Radius.circular(10.0));
  static const Map<String, OutlineInputBorder> inputOutlineBorder = {
    "focusedBorder": OutlineInputBorder(
      borderRadius: inputBorderRadius,
      borderSide: BorderSide(color: Colors.white),
    ),
    "disabledBorder": OutlineInputBorder(
      borderRadius: inputBorderRadius,
      borderSide: BorderSide(color: Colors.white),
    ),
    "enabledBorder": OutlineInputBorder(
      borderRadius: inputBorderRadius,
      borderSide: BorderSide(color: Colors.white),
    ),
    "errorBorder": OutlineInputBorder(
      borderRadius: inputBorderRadius,
      borderSide: BorderSide(color: Colors.white),
    ),
    "focusedErrorBorder": OutlineInputBorder(
      borderRadius: inputBorderRadius,
      borderSide: BorderSide(color: Colors.white),
    ),
    "border": OutlineInputBorder(
      borderRadius: inputBorderRadius,
      borderSide: BorderSide(color: Colors.white),
    )
  };

  // Buttons
  static MaterialStateProperty<Color> Function(Color btnBGColor) buttonBgColor =
      (btnBGColor) => MaterialStateProperty.all<Color>(btnBGColor);
  static MaterialStateProperty<Color> buttonFgColor =
      MaterialStateProperty.all<Color>(Colors.white);

  // Form input
  static const Color formLabelColor = appLabelColor;
  static const Color formInputColor = appTheme;

  // Form Radio
  static const Color formRadioSelectedColor = appTheme;
  static const Color formRadioUnSelectedColor = Color(0xffF1F6FB);
  static MaterialStateProperty<Color> formRadioSelectedLabelColor =
      MaterialStateProperty.all<Color>(Colors.white);
  static MaterialStateProperty<Color> formRadioUnSelectedLabelColor =
      MaterialStateProperty.all<Color>(appLabelColor);

  // Form Dropdown
  static const Color formDropdownBorderColor = Color(0xffF5F5F5);
  static const Map<String, OutlineInputBorder> formDropdownBorder = {
    "focusedBorder": OutlineInputBorder(
      borderRadius: inputBorderRadius,
      borderSide: BorderSide(color: formDropdownBorderColor),
    ),
    "disabledBorder": OutlineInputBorder(
      borderRadius: inputBorderRadius,
      borderSide: BorderSide(color: formDropdownBorderColor),
    ),
    "enabledBorder": OutlineInputBorder(
      borderRadius: inputBorderRadius,
      borderSide: BorderSide(color: formDropdownBorderColor),
    ),
    "errorBorder": OutlineInputBorder(
      borderRadius: inputBorderRadius,
      borderSide: BorderSide(color: formDropdownBorderColor),
    ),
    "focusedErrorBorder": OutlineInputBorder(
      borderRadius: inputBorderRadius,
      borderSide: BorderSide(color: formDropdownBorderColor),
    ),
    "border": OutlineInputBorder(
      borderRadius: inputBorderRadius,
      borderSide: BorderSide(color: Colors.white),
    )
  };
}

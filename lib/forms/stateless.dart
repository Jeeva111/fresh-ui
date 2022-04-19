import 'package:flutter/material.dart';
import 'package:fresh_ui/forms/themes.dart';

class TextInput extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final MainAxisSize mainAxisSize;
  final MainAxisAlignment mainAxisAlignment;
  final double? height;
  final String? hintText;
  final String? errorText;
  final bool obscureText;
  final Color textColor;
  final void Function(String) onTextChange;

  const TextInput(
      {required this.label,
      required this.onTextChange,
      this.obscureText = false,
      this.controller,
      this.mainAxisSize = MainAxisSize.max,
      this.mainAxisAlignment = MainAxisAlignment.spaceEvenly,
      this.height,
      this.hintText,
      this.errorText,
      this.textColor = FormThemes.labelColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? MediaQuery.of(context).size.height * 0.13,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: mainAxisAlignment,
          mainAxisSize: mainAxisSize,
          children: <Widget>[
            Text(
              label,
              style: TextStyle(color: textColor),
            ),
            Material(
              elevation: 2.0,
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              child: TextField(
                onChanged: onTextChange,
                obscureText: obscureText,
                controller: controller,
                decoration:
                    InputDecoration(hintText: hintText, errorText: errorText)
                        .copyWith(
                            focusedBorder:
                                FormThemes.inputOutlineBorder['focusedBorder'],
                            border: FormThemes.inputOutlineBorder['border'],
                            errorBorder:
                                FormThemes.inputOutlineBorder['errorBorder'],
                            disabledBorder:
                                FormThemes.inputOutlineBorder['disabledBorder'],
                            enabledBorder:
                                FormThemes.inputOutlineBorder['enabledBorder']),
              ),
            )
          ]),
    );
  }
}

class FormInput extends StatelessWidget {
  final String? label;
  final TextEditingController? controller;
  final MainAxisSize mainAxisSize;
  final MainAxisAlignment mainAxisAlignment;
  final double? height;
  final String? hintText;
  final String? errorText;
  final bool obscureText;
  final Color textColor;
  final bool readOnly;
  final Widget? rightIcon;
  final void Function(String) onTextChange;
  final void Function()? onTap;

  const FormInput(
      {this.label,
      required this.onTextChange,
      this.onTap,
      this.obscureText = false,
      this.readOnly = false,
      this.controller,
      this.mainAxisSize = MainAxisSize.max,
      this.mainAxisAlignment = MainAxisAlignment.spaceEvenly,
      this.height,
      this.hintText,
      this.errorText,
      this.rightIcon,
      this.textColor = FormThemes.formLabelColor});

  @override
  Widget build(BuildContext context) {
    final double mediaQueryHeight = MediaQuery.of(context).size.height;
    return Container(
      height: height != null
          ? height
          : label != null
              ? mediaQueryHeight * 0.17
              : mediaQueryHeight * 0.12,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: mainAxisAlignment,
          mainAxisSize: mainAxisSize,
          children: <Widget>[
            label != null
                ? Text(
                    label!,
                    style: TextStyle(color: textColor),
                  )
                : SizedBox.shrink(),
            Material(
              elevation: 1,
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              child: TextField(
                readOnly: readOnly,
                onTap: onTap,
                onChanged: onTextChange,
                obscureText: obscureText,
                controller: controller,
                style: const TextStyle(color: FormThemes.formInputColor),
                decoration: InputDecoration(
                        suffixIcon: rightIcon ?? rightIcon,
                        suffixIconConstraints: const BoxConstraints(
                          minHeight: 24,
                          minWidth: 24,
                        ),
                        hintText: hintText,
                        errorText: errorText,
                        hintStyle:
                            const TextStyle(color: FormThemes.formInputColor))
                    .copyWith(
                        focusedBorder:
                            FormThemes.inputOutlineBorder['focusedBorder'],
                        border: FormThemes.inputOutlineBorder['border'],
                        errorBorder:
                            FormThemes.inputOutlineBorder['errorBorder'],
                        disabledBorder:
                            FormThemes.inputOutlineBorder['disabledBorder'],
                        enabledBorder:
                            FormThemes.inputOutlineBorder['enabledBorder']),
              ),
            )
          ]),
    );
  }
}

class Button extends StatelessWidget {
  final Widget child;
  final double widthFactor;
  final double heightFactor;
  final Color btnColor;
  final Color btnFgColor;
  final void Function() onPressed;

  Button(
      {Key? key,
      required this.child,
      required this.onPressed,
      this.widthFactor = 0.4,
      this.heightFactor = 0.06,
      this.btnColor = const Color(0xff9E7D49),
      this.btnFgColor = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return TextButton(
      style: ButtonStyle(
          minimumSize: MaterialStateProperty.all<Size>(Size(
              screenSize.width * widthFactor,
              screenSize.height * heightFactor)),
          foregroundColor: FormThemes.buttonFgColor(btnFgColor),
          backgroundColor: FormThemes.buttonBgColor(btnColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ))),
      onPressed: onPressed,
      child: child,
    );
  }
}

class SearchUI extends StatelessWidget {
  final String placeholder;
  final IconData? leftIcon;
  final Color? labelColor;
  const SearchUI(
      {Key? key,
      required this.placeholder,
      this.leftIcon = Icons.search,
      this.labelColor = const Color(0xffBBC5D5)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
        color: Color(0xffEAEAEA),
      ),
      padding: EdgeInsets.only(left: 10.0),
      child: Row(children: [
        Icon(
          leftIcon,
          color: Colors.black,
          size: MediaQuery.of(context).size.width * 0.07,
        ),
        Container(
          color: labelColor,
          width: 1,
          margin: EdgeInsets.all(12.0),
        ),
        Text(
          placeholder,
          style: TextStyle(color: labelColor),
        )
      ]),
    );
  }

//   TextField(
// textAlignVertical: TextAlignVertical.bottom,
//   decoration: InputDecoration(
//     hintText: placeholder,
//     fillColor: const Color(0xffF7F8FA),
//     filled: true,
//     hintStyle: const TextStyle(color: Color(0xffbbc5d5)),
//     prefixIcon: Container(
//       margin: const EdgeInsets.only(right: 20),
//       alignment: Alignment.center,
//       width: 60,
//       decoration: const BoxDecoration(
//         border: Border(right: BorderSide(color: Color(0xffbbc5d5))),
//       ),
//       child: Icon(
//         leftIcon,
//         color: Colors.black,
//         size: MediaQuery.of(context).size.width * 0.07,
//       ),
//     ),
//     border: const OutlineInputBorder(
//       borderRadius: BorderRadius.all(Radius.circular(30.0)),
//       borderSide: BorderSide(color: Colors.white),
//     ),
//     focusedBorder: const OutlineInputBorder(
//       borderRadius: BorderRadius.all(Radius.circular(30.0)),
//       borderSide: BorderSide(color: Colors.white),
//     ),
//     enabledBorder: const OutlineInputBorder(
//       borderRadius: BorderRadius.all(Radius.circular(30.0)),
//       borderSide: BorderSide(color: Colors.white),
//     )))
}

class GoBack extends StatelessWidget {
  final Widget child;
  final void Function() onPressed;

  const GoBack(
      {Key? key,
      required this.onPressed,
      this.child = const Icon(Icons.arrow_back)});

  @override
  Widget build(BuildContext context) {
    return Material(
        elevation: 1,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child:
            IconButton(icon: child, tooltip: "Go back", onPressed: onPressed));
  }
}

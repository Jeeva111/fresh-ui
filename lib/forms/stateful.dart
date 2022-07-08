import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fresh_ui/forms/stateless.dart';
import 'package:fresh_ui/forms/themes.dart';
import 'package:fresh_ui/forms/utils.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class FormRadio extends StatefulWidget {
  String label;
  int selectedIndex;
  Color selectedColor = FormThemes.formRadioSelectedColor;
  Color unSelectedColor = FormThemes.formRadioUnSelectedColor;
  List<Map<String, String>> options;
  final int crossAxisCount;
  Function(List<Map<String, String>>, int) onPressed;

  FormRadio(
      {Key? key,
      required this.label,
      required this.options,
      required this.onPressed,
      this.selectedIndex = -1,
      this.crossAxisCount = 4});

  @override
  State<FormRadio> createState() => _FormRadioState();
}

class _FormRadioState extends State<FormRadio> {
  List<String> dynamicKeys = [];
  int objectLength = 0;
  List<int> selectedIndex = [];
  List<Map<String, String>> selectedOptions = [];

  @override
  void initState() {
    super.initState();
    if (widget.options.isNotEmpty) {
      dynamicKeys = getDynamicKeys(widget.options);
      objectLength = dynamicKeys.length;
    }
    if (widget.selectedIndex != -1) selectedIndex.add(widget.selectedIndex);
  }

  @override
  void didUpdateWidget(FormRadio oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.options.isNotEmpty) {
      dynamicKeys = getDynamicKeys(widget.options);
      objectLength = dynamicKeys.length;
    }
  }

  void handleOnPress(index) {
    selectedIndex = [];
    setState(() {
      selectedIndex.add(index);
    });
    widget.onPressed([widget.options[index]], index);
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return objectLength >= 2 && dynamicKeys.isNotEmpty
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
                Text(
                  widget.label,
                  style: const TextStyle(color: FormThemes.formLabelColor),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: StaggeredGrid.count(
                    crossAxisCount: widget.crossAxisCount,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                    children: [
                      for (int index = 0;
                          index < widget.options.length;
                          index++)
                        TextButton(
                          style: ButtonStyle(
                              foregroundColor: selectedIndex.contains(index)
                                  ? FormThemes.formRadioSelectedLabelColor
                                  : FormThemes.formRadioUnSelectedLabelColor,
                              backgroundColor: selectedIndex.contains(index)
                                  ? MaterialStateProperty.all<Color>(
                                      widget.selectedColor)
                                  : MaterialStateProperty.all<Color>(
                                      widget.unSelectedColor),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ))),
                          onPressed: () => handleOnPress(index),
                          child: Text(
                            widget.options[index][dynamicKeys[1]]!,
                            style: TextStyle(
                                color: selectedIndex.contains(index)
                                    ? Colors.white
                                    : FormThemes.appLabelColor),
                          ),
                        )
                    ],
                  ),
                )
              ])
        : Text("Please add key and value pair");
  }
}

class FormDropdown extends StatefulWidget {
  final Widget dropDownIcon;
  final String hintText;
  final String? errorText;
  final List<Map<String, String>> dropDownLists;
  Function(Map<String, String>?)? onSelect;
  FormDropdown(
      {Key? key,
      this.dropDownIcon = const Icon(Icons.expand_more),
      required this.hintText,
      required this.dropDownLists,
      this.onSelect,
      this.errorText});

  @override
  State<FormDropdown> createState() => _FormDropdownState();
}

class _FormDropdownState extends State<FormDropdown> {
  final GlobalKey<FormFieldState> _key = GlobalKey<FormFieldState>();
  int selectedIndex = -1;
  Map<String, String>? selected;
  List<String> dynamicKeys = [];
  int objectLength = 0;
  List<DropdownMenuItem<Map<String, String>>> dropDownItems = [];

  @override
  void initState() {
    super.initState();

    //selected = widget.dropDownLists.first;
    // selected = {dynamicKeys[0]: "", dynamicKeys[1]: widget.hintText};
    // widget.dropDownLists.insert(0, selected);
  }

  @override
  void didUpdateWidget(FormDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.dropDownLists.isNotEmpty) {
      dynamicKeys = getDynamicKeys(widget.dropDownLists);
      objectLength = dynamicKeys.length;
    } else {
      _key.currentState?.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.dropDownLists.isNotEmpty && dynamicKeys.isNotEmpty) {
      dropDownItems = widget.dropDownLists
          .map<DropdownMenuItem<Map<String, String>>>(
              (Map<String, String> lists) {
        return DropdownMenuItem<Map<String, String>>(
          value: lists,
          child: Text(dynamicKeys.isNotEmpty ? lists[dynamicKeys[1]]! : "",
              style: const TextStyle(fontSize: 16.0)),
        );
      }).toList();
    }

    return widget.dropDownLists.isNotEmpty && dynamicKeys.isNotEmpty
        ? Container(
            margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Material(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              elevation: 1,
              child: DropdownButtonFormField<Map<String, String>>(
                  key: _key,
                  value: selected,
                  icon: widget.dropDownIcon,
                  style: const TextStyle(color: FormThemes.appTheme),
                  elevation: 1,
                  hint: Text(widget.hintText,
                      style: const TextStyle(
                          color: FormThemes.appTheme, fontSize: 16.0)),
                  decoration: InputDecoration(
                      focusedBorder:
                          FormThemes.formDropdownBorder['focusedBorder'],
                      border: FormThemes.formDropdownBorder['border'],
                      errorBorder: FormThemes.formDropdownBorder['errorBorder'],
                      disabledBorder:
                          FormThemes.formDropdownBorder['disabledBorder'],
                      enabledBorder:
                          FormThemes.formDropdownBorder['enabledBorder'],
                      errorText: widget.errorText,
                      hintStyle:
                          const TextStyle(color: FormThemes.formInputColor)),
                  onChanged: (Map<String, String>? newValue) {
                    if (widget.onSelect != null) {
                      widget.onSelect!(newValue);
                    }
                    // setState(() {
                    //   dropdownValue = newValue!;
                    // });
                  },
                  items: dropDownItems),
            ),
          )
        : const SizedBox.shrink();
  }
}

class FormCheckbox extends StatefulWidget {
  final String label;
  final void Function(List<int>) selected;
  final int crossAxisCount;
  final bool gridView;
  final List<Map<String, String>> checkBoxList;

  FormCheckbox(
      {Key? key,
      required this.label,
      required this.selected,
      required this.checkBoxList,
      this.gridView = false,
      this.crossAxisCount = 4});

  @override
  State<FormCheckbox> createState() => _FormCheckboxState();
}

class _FormCheckboxState extends State<FormCheckbox> {
  bool isChecked = false;
  List<String> dynamicKeys = [];
  List<int> checkedIndexes = [];

  @override
  void didUpdateWidget(FormCheckbox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.checkBoxList.isNotEmpty) {
      dynamicKeys = getDynamicKeys(widget.checkBoxList);
    }
  }

  void handleCheck(int index) {
    int checkedIndex = checkedIndexes.indexOf(index);
    if (checkedIndex != -1) {
      checkedIndexes.removeAt(checkedIndex);
    } else {
      checkedIndexes.add(index);
    }
    setState(() {
      checkedIndexes;
    });
    widget.selected(checkedIndexes);
  }

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
        MaterialState.selected
      };
      if (states.any(interactiveStates.contains)) {
        return FormThemes.appTheme;
      }
      return const Color(0xffD4D4D4);
    }

    return widget.checkBoxList.isNotEmpty && dynamicKeys.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
                Text(
                  widget.label,
                  style: const TextStyle(color: FormThemes.formLabelColor),
                ),
                const SizedBox(width: 20),
                widget.gridView
                    ? StaggeredGrid.count(
                        crossAxisCount: widget.crossAxisCount,
                        mainAxisSpacing: 4,
                        crossAxisSpacing: 4,
                        children: [
                          for (int index = 0;
                              index < widget.checkBoxList.length;
                              index++)
                            Row(children: <Widget>[
                              Checkbox(
                                checkColor: Colors.white,
                                fillColor:
                                    MaterialStateProperty.resolveWith(getColor),
                                value: isChecked,
                                onChanged: (bool? value) {
                                  print(value);
                                },
                              ),
                              Text(
                                widget.checkBoxList[index][dynamicKeys[1]]!,
                                style: const TextStyle(
                                    color: FormThemes.formLabelColor),
                              )
                            ])
                        ],
                      )
                    : Wrap(
                        children: [
                          for (int index = 0;
                              index < widget.checkBoxList.length;
                              index++)
                            Row(mainAxisSize: MainAxisSize.min, children: <
                                Widget>[
                              Checkbox(
                                checkColor: Colors.white,
                                fillColor:
                                    MaterialStateProperty.resolveWith(getColor),
                                value: checkedIndexes.contains(index),
                                onChanged: (bool? value) {
                                  handleCheck(index);
                                },
                              ),
                              GestureDetector(
                                onTap: () => handleCheck(index),
                                child: Text(
                                  widget.checkBoxList[index][dynamicKeys[1]]!,
                                  style: const TextStyle(
                                      color: FormThemes.formLabelColor),
                                ),
                              )
                            ])
                        ],
                      )
              ])
        : const SizedBox.shrink();
  }
}

class FormDatepicker extends StatefulWidget {
  final String? label;
  final String? hintText;
  final String? displayFormat;
  final String dateFormat;
  final void Function(String selectedDate) onSelect;

  FormDatepicker(
      {Key? key,
      required this.onSelect,
      this.displayFormat = "dd-MM-y",
      this.dateFormat = "y-MM-dd",
      this.label,
      this.hintText});

  @override
  State<FormDatepicker> createState() => _FormDatepickerState();
}

class _FormDatepickerState extends State<FormDatepicker> {
  DateTime selectedDate = DateTime.now();
  TextEditingController datePickerController = TextEditingController();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      widget.onSelect(DateFormat(widget.dateFormat).format(picked));
      datePickerController.value = TextEditingValue(
          text: DateFormat(widget.displayFormat).format(picked));
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormInput(
      controller: datePickerController,
      label: widget.label,
      hintText: widget.hintText,
      onTextChange: (date) => print(date),
      onTap: () => _selectDate(context),
      readOnly: true,
      rightIcon: Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: Image.asset(
          "assets/images/datepicker.png",
          height: 20,
        ),
      ),
    );
  }
}

class FormTimepicker extends StatefulWidget {
  final String? label;
  final String? hintText;
  final String? displayFormat;
  final String timeFormat;
  final void Function(String selectedTime) onSelect;

  FormTimepicker(
      {Key? key,
      required this.onSelect,
      this.displayFormat = "dd-MM-y",
      this.timeFormat = "y-MM-dd",
      this.label,
      this.hintText});

  @override
  State<FormTimepicker> createState() => _FormTimepickerState();
}

class _FormTimepickerState extends State<FormTimepicker> {
  TimeOfDay selectedTime = TimeOfDay.now();
  TextEditingController timePickerController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      String pickedTime = picked.format(context).padLeft(8, "0");
      widget.onSelect(pickedTime);
      timePickerController.value = TextEditingValue(text: pickedTime);
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    timePickerController.value =
        TextEditingValue(text: selectedTime.format(context));
    return FormInput(
      controller: timePickerController,
      label: widget.label,
      hintText: widget.hintText,
      onTextChange: (date) => print(date),
      onTap: () => _selectTime(context),
      readOnly: true,
      rightIcon: Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: Image.asset(
          "assets/images/clock.png",
          height: 20,
        ),
      ),
    );
  }
}

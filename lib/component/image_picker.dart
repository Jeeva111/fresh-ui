import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

enum RenderImage { platform, web }

class PickedImage {
  dynamic imagePath;
  RenderImage renderType;
  XFile file;
  String base64;
  PickedImage(
      {required this.imagePath,
      required this.file,
      required this.renderType,
      required this.base64});
}

class ImagePick extends StatefulWidget {
  final String? title;
  final bool isMultiple;
  final void Function() onClose;
  final void Function(List<PickedImage> pickedImage) onSave;
  ImagePick(
      {this.title,
      this.isMultiple = false,
      required this.onClose,
      required this.onSave});
  @override
  State<ImagePick> createState() => _ImagePickScreenState();
}

class _ImagePickScreenState extends State<ImagePick> {
  List<PickedImage> pickedImages = [];

  void imagePicker(ImageSource imageSourceType) async {
    final ImagePicker _picker = ImagePicker();
    if (!widget.isMultiple) pickedImages.clear();
    if (!kIsWeb) {
      XFile? response = await _picker.pickImage(source: imageSourceType);
      if (response != null) {
        pickedImages.add(PickedImage(
            imagePath: File(response.path),
            file: response,
            base64: base64Encode(await response.readAsBytes()),
            renderType: RenderImage.platform));
        setState(() {
          pickedImages;
        });
      }
    } else if (kIsWeb) {
      XFile? response = await _picker.pickImage(source: ImageSource.gallery);
      if (response != null) {
        pickedImages.add(PickedImage(
            imagePath: response.path,
            file: response,
            base64: base64Encode(await response.readAsBytes()),
            renderType: RenderImage.web));
        setState(() {
          pickedImages;
        });
      }
    }
  }

  void closePicker() {
    widget.onClose();
  }

  void saveImage() {
    widget.onSave(pickedImages);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey,
        appBar: widget.title != null
            ? AppBar(
                title: Text(widget.title!),
                leading: IconButton(
                    onPressed: closePicker, icon: const Icon(Icons.close)),
                actions: [
                  pickedImages.isNotEmpty
                      ? IconButton(
                          onPressed: saveImage, icon: const Icon(Icons.done))
                      : const SizedBox.shrink()
                ],
              )
            : null,
        body: SafeArea(
            top: true,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                widget.title == null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                            IconButton(
                                onPressed: closePicker,
                                icon: const Icon(Icons.close)),
                            pickedImages.isNotEmpty
                                ? IconButton(
                                    onPressed: saveImage,
                                    icon: const Icon(Icons.done))
                                : const SizedBox.shrink()
                          ])
                    : const SizedBox.shrink(),
                Expanded(
                    child: pickedImages.isNotEmpty
                        ? pickedImages[0].renderType == RenderImage.platform
                            ? FractionallySizedBox(
                                heightFactor: 0.9,
                                child: Image.file(pickedImages[0].imagePath,
                                    fit: BoxFit.contain),
                              )
                            : FractionallySizedBox(
                                heightFactor: 0.9,
                                child: Image.network(pickedImages[0].imagePath,
                                    fit: BoxFit.contain),
                              )
                        : const SizedBox.shrink()),
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(10.0))),
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Select Source",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20.0),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ActionButton(
                                actionIcon: Icons.camera,
                                label: "Camera",
                                onPressed: () =>
                                    imagePicker(ImageSource.camera)),
                            const SizedBox.shrink(),
                            ActionButton(
                                actionIcon: Icons.collections,
                                label: "Gallery",
                                onPressed: () =>
                                    imagePicker(ImageSource.gallery))
                          ],
                        )
                      ]),
                )
              ],
            )));
  }
}

class ActionButton extends StatelessWidget {
  final IconData actionIcon;
  final double iconSize;
  final String label;
  final Color background;
  final void Function() onPressed;

  ActionButton(
      {Key? key,
      required this.actionIcon,
      this.background = Colors.green,
      this.iconSize = 30,
      required this.onPressed,
      required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      TextButton(
        style: TextButton.styleFrom(
          minimumSize: Size(50, 50),
          padding: EdgeInsets.zero,
          backgroundColor: background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Icon(
          actionIcon,
          size: iconSize,
          color: Colors.white,
        ),
        onPressed: onPressed,
      ),
      const SizedBox(height: 10.0),
      Text(label)
    ]);
  }
}

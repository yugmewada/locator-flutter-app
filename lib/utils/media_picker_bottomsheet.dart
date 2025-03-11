import 'package:demo/theming/TextStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../theming/AppColor.dart';

class MediaPickerSheet extends StatelessWidget {
  const MediaPickerSheet({
    super.key,
    required this.pickFileType,
    required this.onSelectFile,
  });

  final PickedFileType pickFileType;
  final Function(XFile?, PickedFileType) onSelectFile;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
              selectMedia(
                sourceType: SourceType.camera,
                pickFileType: pickFileType,
                onSelectFile: onSelectFile,
              );
            },
            child: const _RoundedButton(
              buttonLabel: "Camera",
              bgColor: AppColor.colorScreenBg,
              textColor: AppColor.colorDarkBlue,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
              selectMedia(
                sourceType: SourceType.gallery,
                pickFileType: pickFileType,
                onSelectFile: onSelectFile,
              );
            },
            child: const _RoundedButton(
              buttonLabel: "Gallery",
              bgColor: AppColor.colorScreenBg,
              textColor: AppColor.colorDarkBlue,
            ),
          ),
          15.verticalSpace,
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: const Padding(
              padding: EdgeInsets.only(
                left: 30,
                right: 30,
                bottom: 20,
              ),
              child: _RoundedButton(
                buttonLabel: "Cancel",
                bgColor: AppColor.colorScreenBg,
                textColor: AppColor.colorDarkBlue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> selectMedia({
    required SourceType sourceType,
    required PickedFileType pickFileType,
    required Function(XFile?, PickedFileType) onSelectFile,
  }) async {
    XFile? file;
    switch (sourceType) {
      case SourceType.camera:
        if (pickFileType == PickedFileType.image) {
          file = await ImagePicker().pickImage(source: ImageSource.camera);
        } else {
          file = await ImagePicker().pickVideo(source: ImageSource.camera);
        }
        onSelectFile(file, pickFileType);
        break;
      case SourceType.gallery:
        if (pickFileType == PickedFileType.image) {
          file = await ImagePicker().pickImage(source: ImageSource.gallery);
        } else {
          file = await ImagePicker().pickVideo(source: ImageSource.gallery);
        }
        onSelectFile(file, pickFileType);
        break;
    }
  }
}

class _RoundedButton extends StatelessWidget {
  final String buttonLabel;
  final EdgeInsets margin;
  final Color bgColor;
  final Color textColor;

  const _RoundedButton({
    required this.buttonLabel,
    required this.bgColor,
    required this.textColor,
    this.margin = const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      margin: margin,
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 10,
      ),
      alignment: FractionalOffset.center,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: const BorderRadius.all(Radius.circular(100.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppColor.primaryColor.withOpacity(0.5),
            offset: const Offset(0.5, 2.0),
            blurRadius: 0.001,
          ),
        ],
      ),
      child: Text(
        buttonLabel,
        style: TextStyles.boldDarkBlue14(),
      ),
    );
  }
}

enum PickedFileType { image, video }

enum SourceType { camera, gallery }

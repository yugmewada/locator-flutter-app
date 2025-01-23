import 'package:demo/generated/assets.dart';
import 'package:demo/theming/AppColor.dart';
import 'package:demo/theming/TextStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//ignore: must_be_immutable
class BaseAppBar extends StatefulWidget implements PreferredSizeWidget {
  late String? title;
  bool centerTitle = false;
  late Color? backgroundColor;
  late double? elevations;
  List<Widget>? action;
  bool leadingIcon = false;
  bool showTitle = false;
  VoidCallback? backAction;
  Widget? titleWidget;
  Widget? leadingWidget;
  Color? leadingWidgetColor;
  Color? titleWidgetColor;

  BaseAppBar({
    super.key,
    this.title,
    this.centerTitle = true,
    this.backgroundColor = AppColor.colorScreenBg,
    this.elevations = 0.0,
    this.action,
    this.leadingIcon = false,
    this.showTitle = false,
    this.backAction,
    this.titleWidget,
    this.leadingWidget,
    this.leadingWidgetColor,
    this.titleWidgetColor,
    this.preferredSize = const Size.fromHeight(kToolbarHeight),
  }) : assert(
          title == null || titleWidget == null,
          "Title and Title widget both can't be null",
        );

  @override
  final Size preferredSize; // default is 56.0

  @override
  State<BaseAppBar> createState() => _BaseAppBarState();
}

class _BaseAppBarState extends State<BaseAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: AppColor.colorScreenBg, // Status bar
      ),
      scrolledUnderElevation: 0,
      centerTitle: widget.centerTitle,
      title: !widget.showTitle
          ? const SizedBox.shrink()
          : widget.titleWidget ??
              Text(
                widget.title!,
                style: TextStyles.mediumColorDarkBlue16(),
              ),
      backgroundColor: widget.backgroundColor ?? AppColor.colorWhite,
      elevation: widget.elevations,
      automaticallyImplyLeading: false,
      //brightness: Brightness.dark,
      leading: widget.leadingIcon
          ? widget.leadingWidget ??
              IconButton(
                icon: Image.asset(
                  Assets.imagesImageCross,
                  height: 20.0,
                  width: 24.0,
                  color: widget.leadingWidgetColor,
                ),
                onPressed: () {
                  if (widget.backAction != null) {
                    widget.backAction!.call();
                  } else {
                    Navigator.maybePop(context);
                  }
                },
              )
          : null,
      iconTheme: const IconThemeData(color: Colors.black),
      actions: widget.action,
    );
  }
}

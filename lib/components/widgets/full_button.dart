// ignore_for_file: prefer_const_constructors

import 'package:cubex_assessment/helpers/size_calculator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FullButton extends StatefulWidget {
  final Function? buttonFunction;
  final String? buttonText;
  final bool online;
  final FontWeight? weight;
  final bool isIcon;
  final bool isTextSmall;
  final String? iconAsset;
  final Color? buttonOnlineColor, onlineTextColor;

  const FullButton(
      {super.key,
      required this.buttonFunction,
      this.buttonText,
      this.weight,
      this.online = true,
      this.buttonOnlineColor,
      this.onlineTextColor,
      this.isIcon = false,
      this.isTextSmall = false,
      this.iconAsset});

  @override
  State<FullButton> createState() => _FullButtonState();
}

class _FullButtonState extends State<FullButton> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
          onTap: widget.online
              ? widget.buttonFunction != null
                  ? () {
                      HapticFeedback.lightImpact();
                      widget.buttonFunction!.call();
                    }
                  : () {
                      HapticFeedback.lightImpact();
                    }
              : null,
          child: Container(
            height: sizer(false, 40, context),
            decoration: BoxDecoration(
                color: widget.online
                    ? (widget.buttonOnlineColor ?? Color(0xFF2D4990))
                    : Color(0xFF252525),
                borderRadius: BorderRadius.circular(8)),
            child: widget.isIcon
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      widget.iconAsset != null && widget.iconAsset != ''
                          ? SvgPicture.asset(
                              widget.iconAsset!,                              
                              color: (widget.onlineTextColor ?? Colors.white),
                            )
                          : Container(),
                      SizedBox(width: sizer(true, 14, context)),
                      Text(widget.buttonText ?? '',
                          style: TextStyle(
                              color: widget.online
                                  ? (widget.onlineTextColor ?? Colors.white)
                                  : Color(0xFFB5B5B5),
                              fontSize: sizer(true, 13, context),
                              fontWeight: FontWeight.w800))
                    ],
                  )
                : Center(
                    child: Text(widget.buttonText ?? '',
                        style: TextStyle(
                            color: widget.online
                                ? (widget.onlineTextColor ?? Colors.white)
                                : Color(0xFFB5B5B5),
                            fontSize: widget.isTextSmall
                                ? sizer(true, 11.5, context)
                                : sizer(true, 13, context),
                            fontWeight: widget.weight ?? FontWeight.w700))),
          ),
        ));
  }
}

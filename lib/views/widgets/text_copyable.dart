import 'dart:ui' as ui show TextHeightBehavior;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../utils/constants.dart';

class TextCopyable extends StatefulWidget {
  final String data;
  final double? width;
  final double? height;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow? overflow;
  final double? textScaleFactor;
  final int? maxLines;
  final String? semanticsLabel;
  final TextWidthBasis? textWidthBasis;
  final ui.TextHeightBehavior? textHeightBehavior;
  final Color? selectionColor;
  final MainAxisAlignment mainAxisAlignment;

  const TextCopyable(
    this.data, {
    this.width,
    this.height,
    this.style,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.selectionColor,
    this.mainAxisAlignment = MainAxisAlignment.center,
    super.key,
  });

  @override
  State<TextCopyable> createState() => _TextCopyableState();
}

class _TextCopyableState extends State<TextCopyable> {
  bool isCopied = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Row(
        mainAxisAlignment: widget.mainAxisAlignment,
        children: [
          Flexible(
            child: Text(
              widget.data,
              key: widget.key,
              style: widget.style,
              strutStyle: widget.strutStyle,
              textAlign: widget.textAlign,
              textDirection: widget.textDirection,
              locale: widget.locale,
              softWrap: widget.softWrap,
              overflow: widget.overflow,
              textScaleFactor: widget.textScaleFactor,
              maxLines: widget.maxLines,
              semanticsLabel: widget.semanticsLabel,
              textWidthBasis: widget.textWidthBasis,
              textHeightBehavior: widget.textHeightBehavior,
              selectionColor: widget.selectionColor,
            ),
          ),
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: _copyOnPressed,
            tooltip: isCopied ? "1001@global".tr : "1000@global".tr,
            icon: Icon(
              isCopied ? Icons.check_rounded : Icons.copy_rounded,
              color: isCopied ? AppColors.green : null,
              size: AppDecoration.iconSmallSize,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _copyOnPressed() async {
    if (isCopied) return;

    await Clipboard.setData(ClipboardData(text: widget.data));

    setState(() {
      isCopied = true;

      Future.delayed(const Duration(seconds: 5), () {
        setState(() {
          isCopied = false;
        });
      }).onError((error, stackTrace) => null);
    });
  }
}

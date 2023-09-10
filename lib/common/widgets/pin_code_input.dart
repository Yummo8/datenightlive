// ignore_for_file: prefer_equal_for_default_values

import 'dart:async';

import 'package:flutter/cupertino.dart' show CupertinoTextField;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:DNL/common/values/colors.dart';

typedef OnDone = void Function(String text);
typedef PinBoxDecoration = BoxDecoration Function(
  Color borderColor,
  Color pinBoxColor, {
  double borderWidth,
  double radius,
});

/// class to provide some standard PinBoxDecoration such as standard box or underlined
class ProvidedPinBoxDecoration {
  /// Default BoxDecoration
  static PinBoxDecoration defaultPinBoxDecoration = (
    Color borderColor,
    Color pinBoxColor, {
    double borderWidth = 0,
    double radius = 5.0,
  }) {
    return BoxDecoration(
        border: Border.all(
          color: borderColor,
          width: borderWidth,
        ),
        color: pinBoxColor,
        borderRadius: BorderRadius.circular(radius));
  };

  /// Underlined BoxDecoration
  static PinBoxDecoration underlinedPinBoxDecoration = (
    Color borderColor,
    Color pinBoxColor, {
    double borderWidth = 2.0,
    double radius = 0,
  }) {
    return BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: borderColor,
          width: borderWidth,
        ),
      ),
    );
  };

  static PinBoxDecoration roundedPinBoxDecoration = (
    Color borderColor,
    Color pinBoxColor, {
    double borderWidth = 2.0,
    double radius = 0,
  }) {
    return BoxDecoration(
      border: Border.all(
        color: borderColor,
        width: borderWidth,
      ),
      shape: BoxShape.circle,
      color: pinBoxColor,
    );
  };
}

class ProvidedPinBoxTextAnimation {
  /// A combination of RotationTransition, DefaultTextStyleTransition, ScaleTransition
  static AnimatedSwitcherTransitionBuilder awesomeTransition =
      (Widget child, Animation<double> animation) {
    return RotationTransition(
        turns: animation,
        child: DefaultTextStyleTransition(
          style: TextStyleTween(
                  begin: const TextStyle(color: ThemeColors.primary),
                  end: const TextStyle(color: ThemeColors.primary))
              .animate(animation),
          child: ScaleTransition(
            scale: animation,
            child: child,
          ),
        ));
  };

  /// Simple Scaling Transition
  static AnimatedSwitcherTransitionBuilder scalingTransition =
      (child, animation) {
    return ScaleTransition(
      scale: animation,
      child: child,
    );
  };

  /// No transition
  static AnimatedSwitcherTransitionBuilder defaultNoTransition =
      (Widget child, Animation<double> animation) {
    return child;
  };

  /// Rotate Transition
  static AnimatedSwitcherTransitionBuilder rotateTransition =
      (Widget child, Animation<double> animation) {
    return RotationTransition(turns: animation, child: child);
  };
}

class PinCodeTextField extends StatefulWidget {
  final bool isCupertino;
  final int maxLength;
  final TextEditingController? controller;
  final bool hideCharacter;
  final bool highlight;
  final bool highlightAnimation;
  final Color highlightAnimationBeginColor;
  final Color highlightAnimationEndColor;
  final Duration? highlightAnimationDuration;
  final Color highlightColor;
  final Color defaultBorderColor;
  final Color pinBoxColor;
  final Color? highlightPinBoxColor;
  final double pinBoxBorderWidth;
  final double pinBoxRadius;
  final bool hideDefaultKeyboard;
  final PinBoxDecoration? pinBoxDecoration;
  final String maskCharacter;
  final TextStyle? pinTextStyle;
  final double pinBoxHeight;
  final double pinBoxWidth;
  final OnDone? onDone;
  final bool hasError;
  final Color errorBorderColor;
  final Color hasTextBorderColor;
  final Function(String)? onTextChanged;
  final bool autofocus;
  final FocusNode? focusNode;
  final AnimatedSwitcherTransitionBuilder? pinTextAnimatedSwitcherTransition;
  final Duration pinTextAnimatedSwitcherDuration;
  final WrapAlignment wrapAlignment;
  final TextDirection textDirection;
  final TextInputType keyboardType;
  final EdgeInsets pinBoxOuterPadding;
  final bool hasUnderline;

  const PinCodeTextField({
    Key? key,
    this.isCupertino = false,
    this.maxLength = 6,
    this.controller,
    this.hideCharacter = false,
    this.highlight = false,
    this.highlightAnimation = false,
    this.highlightAnimationBeginColor = ThemeColors.secondary,
    this.highlightAnimationEndColor = ThemeColors.onSecondary,
    this.highlightAnimationDuration,
    this.highlightColor = ThemeColors.onSecondary,
    this.pinBoxDecoration,
    this.maskCharacter = "\u25CF",
    this.pinBoxWidth = 50.0,
    this.pinBoxHeight = 70.0,
    this.pinTextStyle,
    this.onDone,
    this.defaultBorderColor = ThemeColors.onSecondary,
    this.hasTextBorderColor = ThemeColors.onSecondary,
    this.pinTextAnimatedSwitcherTransition,
    this.pinTextAnimatedSwitcherDuration = const Duration(),
    this.hasError = false,
    this.errorBorderColor = Colors.red,
    this.onTextChanged,
    this.autofocus = false,
    this.focusNode,
    this.wrapAlignment = WrapAlignment.start,
    this.textDirection = TextDirection.ltr,
    this.keyboardType = TextInputType.number,
    this.pinBoxOuterPadding = const EdgeInsets.symmetric(horizontal: 4.0),
    this.pinBoxColor = ThemeColors.secondary,
    this.highlightPinBoxColor,
    this.pinBoxBorderWidth = 2.0,
    this.pinBoxRadius = 0,
    this.hideDefaultKeyboard = false,
    this.hasUnderline = false,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return PinCodeTextFieldState();
  }
}

class PinCodeTextFieldState extends State<PinCodeTextField>
    with SingleTickerProviderStateMixin {
  AnimationController? _highlightAnimationController;
  Animation? _highlightAnimationColorTween;
  FocusNode? focusNode;
  String text = "";
  int currentIndex = 0;
  List<String> strList = [];
  bool hasFocus = false;

  @override
  void didUpdateWidget(PinCodeTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    focusNode = widget.focusNode ?? focusNode;

    if (oldWidget.maxLength < widget.maxLength) {
      setState(() {
        currentIndex = text.length;
      });
      widget.controller?.text = text;
      widget.controller?.selection =
          TextSelection.collapsed(offset: text.length);
    } else if (oldWidget.maxLength > widget.maxLength &&
        widget.maxLength > 0 &&
        text.isNotEmpty &&
        text.length > widget.maxLength) {
      setState(() {
        text = text.substring(0, widget.maxLength);
        currentIndex = text.length;
      });
      widget.controller?.text = text;
      widget.controller?.selection =
          TextSelection.collapsed(offset: text.length);
    }
  }

  _calculateStrList() async {
    if (strList.length > widget.maxLength) {
      strList.length = widget.maxLength;
    }
    while (strList.length < widget.maxLength) {
      strList.add("0");
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.highlightAnimation) {
      var highlightAnimationController = AnimationController(
          vsync: this,
          duration: widget.highlightAnimationDuration ??
              const Duration(milliseconds: 500));
      var animationController = highlightAnimationController;

      highlightAnimationController.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          highlightAnimationController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          highlightAnimationController.forward();
        }
      });
      _highlightAnimationColorTween = ColorTween(
              begin: widget.highlightAnimationBeginColor,
              end: widget.highlightAnimationEndColor)
          .animate(animationController);
      highlightAnimationController.forward();
      _highlightAnimationController = highlightAnimationController;
    }
    focusNode = widget.focusNode ?? FocusNode();

    _initTextController();
    _calculateStrList();
    widget.controller?.addListener(_controllerListener);
    focusNode?.addListener(_focusListener);
  }

  void _controllerListener() {
    if (mounted == true) {
      setState(() {
        _initTextController();
      });
      var onTextChanged = widget.onTextChanged;
      if (onTextChanged != null) {
        onTextChanged(widget.controller?.text ?? "");
      }
    }
  }

  void _focusListener() {
    if (mounted == true) {
      setState(() {
        hasFocus = focusNode?.hasFocus ?? false;
      });
    }
  }

  void _initTextController() {
    if (widget.controller == null) {
      return;
    }
    strList.clear();
    var text = widget.controller?.text ?? "";
    if (text.isNotEmpty) {
      if (text.length > widget.maxLength) {
        throw Exception("TextEditingController length exceeded maxLength!");
      }
    }
    for (var i = 0; i < text.length; i++) {
      strList.add(widget.hideCharacter ? widget.maskCharacter : text[i]);
    }
  }

  double get _width {
    var width = 0.0;
    for (var i = 0; i < widget.maxLength; i++) {
      width += widget.pinBoxWidth;
      if (i == 0) {
        width += widget.pinBoxOuterPadding.left;
      } else if (i + 1 == widget.maxLength) {
        width += widget.pinBoxOuterPadding.right;
      } else {
        width += widget.pinBoxOuterPadding.left;
      }
    }
    return width;
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      // Only dispose the focus node if it's internal.  Don't dispose the passed
      // in focus node as it's owned by the parent not this child widget.
      focusNode?.dispose();
    } else {
      focusNode?.removeListener(_focusListener);
    }
    _highlightAnimationController?.dispose();
    widget.controller?.removeListener(_controllerListener);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        !widget.isCupertino ? _fakeTextInput() : _fakeTextInputCupertino(),
        _touchPinBoxRow(),
      ],
    );
  }

  Widget _touchPinBoxRow() {
    return widget.hideDefaultKeyboard
        ? _pinBoxRow(context)
        : GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              if (hasFocus) {
                FocusScope.of(context).requestFocus(FocusNode());
                Future.delayed(const Duration(milliseconds: 100), () {
                  FocusScope.of(context).requestFocus(focusNode);
                });
              } else {
                FocusScope.of(context).requestFocus(focusNode);
              }
            },
            child: _pinBoxRow(context),
          );
  }

  Widget _fakeTextInput() {
    var transparentBorder = const OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.transparent,
        width: 0.0,
      ),
    );
    return SizedBox(
      width: _width,
      height: widget.pinBoxHeight,
      child: TextField(
        autofocus: !kIsWeb ? widget.autofocus : false,
        enableInteractiveSelection: false,
        focusNode: focusNode,
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        inputFormatters: widget.keyboardType == TextInputType.number
            ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
            : null,
        style: const TextStyle(
          height: 0.1,
          color: Colors.transparent,
        ),
        decoration: InputDecoration(
          focusedErrorBorder: transparentBorder,
          errorBorder: transparentBorder,
          disabledBorder: transparentBorder,
          enabledBorder: transparentBorder,
          focusedBorder: transparentBorder,
          counterText: null,
          counterStyle: null,
          helperStyle: const TextStyle(
            height: 0.0,
            color: Colors.transparent,
          ),
          labelStyle: const TextStyle(height: 0.1),
          fillColor: Colors.transparent,
          border: InputBorder.none,
        ),
        cursorColor: Colors.transparent,
        showCursor: false,
        maxLength: widget.maxLength,
        onChanged: _onTextChanged,
      ),
    );
  }

  Widget _fakeTextInputCupertino() {
    return SizedBox(
      width: _width,
      height: widget.pinBoxHeight,
      child: CupertinoTextField(
        autofocus: !kIsWeb ? widget.autofocus : false,
        focusNode: focusNode,
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        inputFormatters: widget.keyboardType == TextInputType.number
            ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
            : null,
        style: const TextStyle(
          color: Colors.transparent,
        ),
        decoration: const BoxDecoration(
          color: Colors.transparent,
          border: null,
        ),
        cursorColor: Colors.transparent,
        showCursor: false,
        maxLength: widget.maxLength,
        onChanged: _onTextChanged,
      ),
    );
  }

  void _onTextChanged(text) {
    var onTextChanged = widget.onTextChanged;
    if (onTextChanged != null) {
      onTextChanged(text);
    }
    setState(() {
      this.text = text;
      if (text.length >= currentIndex) {
        for (int i = currentIndex; i < text.length; i++) {
          strList[i] = widget.hideCharacter ? widget.maskCharacter : text[i];
        }
      }
      currentIndex = text.length;
    });
    if (text.length == widget.maxLength) {
      FocusScope.of(context).requestFocus(FocusNode());
      var onDone = widget.onDone;
      if (onDone != null) {
        onDone(text);
      }
    }
  }

  Widget _pinBoxRow(BuildContext context) {
    _calculateStrList();
    List<Widget> pinCodes = List.generate(widget.maxLength, (int i) {
      return _buildPinCode(i, context);
    });
    return Wrap(
      direction: Axis.horizontal,
      alignment: widget.wrapAlignment,
      verticalDirection: VerticalDirection.down,
      textDirection: widget.textDirection,
      children: pinCodes,
    );
  }

  Widget _buildPinCode(int i, BuildContext context) {
    Color borderColor;
    Color pinBoxColor = widget.pinBoxColor;
    BoxDecoration boxDecoration;
    var highlightPinBoxColor = widget.highlightPinBoxColor;
    var highlightAnimationController = _highlightAnimationController;
    if (widget.hasError) {
      borderColor = widget.errorBorderColor;
    } else if (widget.highlightAnimation &&
        _shouldHighlight(i) &&
        highlightAnimationController != null) {
      return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: AnimatedBuilder(
              animation: highlightAnimationController,
              builder: (BuildContext context, Widget? child) {
                var pinBoxDecoration = widget.pinBoxDecoration;
                if (pinBoxDecoration != null) {
                  boxDecoration = pinBoxDecoration(
                    _highlightAnimationColorTween?.value,
                    pinBoxColor,
                    borderWidth: widget.pinBoxBorderWidth,
                    radius: widget.pinBoxRadius,
                  );
                } else {
                  boxDecoration =
                      ProvidedPinBoxDecoration.defaultPinBoxDecoration(
                    _highlightAnimationColorTween?.value,
                    pinBoxColor,
                    borderWidth: widget.pinBoxBorderWidth,
                    radius: widget.pinBoxRadius,
                  );
                }

                return Container(
                  key: ValueKey<String>("container$i"),
                  decoration: boxDecoration,
                  width: widget.pinBoxWidth,
                  height: widget.pinBoxHeight,
                  child: Center(
                      child: _animatedTextBox(
                          strList[i], i, widget.defaultBorderColor)),
                );
              }));
    } else if (widget.highlight && _shouldHighlight(i)) {
      borderColor = widget.highlightColor;
      if (highlightPinBoxColor != null) {
        pinBoxColor = highlightPinBoxColor;
      }
    } else if (i < text.length) {
      borderColor = widget.hasTextBorderColor;
      if (highlightPinBoxColor != null) {
        pinBoxColor = highlightPinBoxColor;
      }
    } else {
      borderColor = widget.defaultBorderColor;
      pinBoxColor = widget.pinBoxColor;
    }
    var pinBoxDecoration = widget.pinBoxDecoration;
    if (pinBoxDecoration != null) {
      boxDecoration = pinBoxDecoration(
        borderColor,
        pinBoxColor,
        borderWidth: widget.pinBoxBorderWidth,
        radius: widget.pinBoxRadius,
      );
    } else {
      boxDecoration = ProvidedPinBoxDecoration.defaultPinBoxDecoration(
        borderColor,
        pinBoxColor,
        borderWidth: widget.pinBoxBorderWidth,
        radius: widget.pinBoxRadius,
      );
    }
    EdgeInsets insets;
    if (i == 0) {
      insets = EdgeInsets.only(
        left: 0,
        top: widget.pinBoxOuterPadding.top,
        right: widget.pinBoxOuterPadding.right,
        bottom: widget.pinBoxOuterPadding.bottom,
      );
    } else if (i == strList.length - 1) {
      insets = EdgeInsets.only(
        left: widget.pinBoxOuterPadding.left,
        top: widget.pinBoxOuterPadding.top,
        right: 0,
        bottom: widget.pinBoxOuterPadding.bottom,
      );
    } else {
      insets = widget.pinBoxOuterPadding;
    }
    return Padding(
      padding: insets,
      child: SizedBox(
        key: ValueKey<String>("container$i"),
        width: widget.pinBoxWidth,
        height: widget.pinBoxHeight,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
          child: Container(
            decoration: widget.hasUnderline
                ? BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: borderColor, width: 2),
                    ),
                  )
                : null,
            child: Center(
                child: _animatedTextBox(
                    strList[i],
                    i,
                    i < text.length
                        ? widget.hasTextBorderColor
                        : widget.defaultBorderColor)),
          ),
        ),
      ),
    );
  }

  bool _shouldHighlight(int i) {
    return hasFocus &&
        (i == text.length ||
            (i == text.length - 1 && text.length == widget.maxLength));
  }

  Widget _animatedTextBox(String text, int i, Color color) {
    if (widget.pinTextAnimatedSwitcherTransition != null) {
      return AnimatedSwitcher(
        duration: widget.pinTextAnimatedSwitcherDuration,
        transitionBuilder: widget.pinTextAnimatedSwitcherTransition ??
            (Widget child, Animation<double> animation) {
              return child;
            },
        child: Text(
          text,
          key: ValueKey<String>("$text$i"),
          style: TextStyle(fontSize: 28, color: color),
        ),
      );
    } else {
      return Text(
        text,
        key: ValueKey<String>("${strList[i]}$i"),
        style: TextStyle(fontSize: 28, color: color),
      );
    }
  }
}

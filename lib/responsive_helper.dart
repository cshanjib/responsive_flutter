import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

//screen sizes
const double WIDTH_MOBILE = 600;
const double WIDTH_TABLET = 900;
const double WIDTH_DESKTOP = 1024;

const double WIDTH_MAX_APP_WIDTH = 1200;

class ResponsiveHelper {
  final Size deviceSize;

  ResponsiveHelper({BuildContext context, Size size})
      : assert(context != null || size != null),
        deviceSize = size ?? MediaQuery.of(context).size;

  bool get isDesktop => deviceSize.width >= WIDTH_DESKTOP;

  double get optimalDeviceWidth => min(deviceSize.width, WIDTH_MAX_APP_WIDTH);

  bool isTablet({includeMobile: false}) =>
      deviceSize.width < WIDTH_DESKTOP &&
          (deviceSize.width > WIDTH_MOBILE || includeMobile);

  T value<T>({
    @required T mobile,
    T tablet,
    @required T desktop,
  }) =>
      isMobile
          ? mobile
          : isDesktop
          ? desktop
          : (tablet ?? mobile);

  double incremental(double mobile, {double increment = 2}) => isMobile
      ? mobile
      : isDesktop
      ? mobile + (2 * increment)
      : mobile + increment;

  bool get isMobile => deviceSize.width <= WIDTH_MOBILE;

  double get defaultSmallGap => isDesktop
      ? 10
      : isMobile
      ? 6
      : 8;

  double get defaultGap => isDesktop
      ? 20
      : isMobile
      ? 10
      : 12;

  double get smallFontSize => isDesktop
      ? 14
      : isMobile
      ? 10
      : 12;

  double get normalFontSize => isDesktop
      ? 14
      : isMobile
      ? 12
      : 14;

  double get mediumFontSize => isDesktop
      ? 18
      : isMobile
      ? 14
      : 16;

  double get largeFontSize => isDesktop
      ? 20
      : isMobile
      ? 14
      : 18;
}

class RowOrColumn extends StatelessWidget {
  final bool showRow;
  final bool intrinsicRow;
  final List<Widget> children;
  final MainAxisAlignment rowMainAxisAlignment;
  final MainAxisSize rowMainAxisSize;
  final CrossAxisAlignment rowCrossAxisAlignment;

  final MainAxisAlignment columnMainAxisAlignment;
  final MainAxisSize columnMainAxisSize;
  final CrossAxisAlignment columnCrossAxisAlignment;

  RowOrColumn({
    this.showRow: true,
    this.intrinsicRow: false,
    Key key,
    this.children,
    this.columnMainAxisAlignment = MainAxisAlignment.start,
    this.columnMainAxisSize = MainAxisSize.max,
    this.columnCrossAxisAlignment = CrossAxisAlignment.center,
    this.rowMainAxisAlignment = MainAxisAlignment.start,
    this.rowMainAxisSize = MainAxisSize.max,
    this.rowCrossAxisAlignment = CrossAxisAlignment.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return showRow
        ? _intrinsicHeightWrap(
      intrinsicRow,
      child: Row(
        children: children,
        mainAxisAlignment: rowMainAxisAlignment,
        crossAxisAlignment: rowCrossAxisAlignment,
        mainAxisSize: rowMainAxisSize,
      ),
    )
        : Column(
      children: children,
      mainAxisAlignment: columnMainAxisAlignment,
      crossAxisAlignment: columnCrossAxisAlignment,
      mainAxisSize: columnMainAxisSize,
    );
  }

  Widget _intrinsicHeightWrap(bool wrap, {child}) {
    return wrap
        ? IntrinsicHeight(
      child: child,
    )
        : child;
  }
}

class ExpandedIf extends StatelessWidget {
  final bool expanded;
  final Widget child;
  final int flex;

  ExpandedIf({this.expanded: true, this.child, Key key, this.flex: 1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return expanded
        ? Expanded(
      child: child,
      flex: flex,
    )
        : child;
  }
}

class MouseRegionIf extends StatelessWidget {
  final bool addRegion;
  final Widget child;

  final PointerExitEventListener onExit;
  final PointerEnterEventListener onEnter;
  final PointerHoverEventListener onHover;
  final MouseCursor cursor;

  MouseRegionIf(
      {this.addRegion: true,
        this.child,
        this.onExit,
        this.onEnter,
        this.onHover,
        this.cursor,
        Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return addRegion
        ? MouseRegion(
      cursor: cursor,
      onEnter: onEnter,
      onExit: onExit,
      onHover: onHover,
      child: child,
    )
        : child;
  }
}

class PaddingSwitch extends StatelessWidget {
  final bool switchIf;
  final Widget child;
  final EdgeInsets padding;
  final EdgeInsets switchedPadding;

  PaddingSwitch(
      {this.switchIf: false,
        this.child,
        this.padding: EdgeInsets.zero,
        this.switchedPadding: EdgeInsets.zero,
        Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      child: child,
      padding: switchIf ? switchedPadding : padding,
    );
  }
}

class ResponsiveWidget extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const ResponsiveWidget({
    Key key,
    @required this.mobile,
    this.tablet,
    @required this.desktop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= WIDTH_DESKTOP) {
          return desktop;
        } else if (constraints.maxWidth > WIDTH_MOBILE) {
          return tablet ?? mobile;
        } else {
          return mobile;
        }
      },
    );
  }
}

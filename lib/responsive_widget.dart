import 'package:flutter/cupertino.dart';

const double WIDTH_MOBILE_SMALL = 400;
const double WIDTH_MOBILE = 480;
const double WIDTH_MEDIUM = 600;
const double WIDTH_TABLET = 850;
const double WIDTH_DESKTOP = 1024;

class ResponsiveWidget extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const ResponsiveWidget({
    Key? key,
    required this.mobile,
     this.tablet,
    required this.desktop,
  }) : super(key: key);

// This size work fine on my design, maybe you need some customization depends on your design

  // This isMobile, isTablet, isDesktop helps us later
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < WIDTH_MOBILE;

  static bool isTablet(BuildContext context, {include: false}) =>
      MediaQuery.of(context).size.width < WIDTH_DESKTOP &&
          (MediaQuery.of(context).size.width >= WIDTH_MOBILE || include);

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= WIDTH_DESKTOP;

  static double responsiveValue(BuildContext context, desktop,
      {mobile, tablet}) {
    final double _width = MediaQuery.of(context).size.width;
    if (_width >= WIDTH_DESKTOP) {
      return desktop;
    } else if (_width >= WIDTH_MOBILE) {
      return tablet ?? desktop ?? mobile;
    }
    // Or less than that, we call it mobile
    else {
      return mobile ?? tablet ?? desktop;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= WIDTH_DESKTOP) {
          return desktop;
        } else if (constraints.maxWidth >= WIDTH_MOBILE) {
          return tablet ?? desktop;
        } else {
          return mobile;
        }
      },
    );
  }
}
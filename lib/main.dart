import 'package:flutter/material.dart';
import 'package:responsive_flutter/dialog_util.dart';
import 'package:responsive_flutter/nav_item.dart';
import 'package:responsive_flutter/responsive_helper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Responsive Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: Builder(builder: (context) {
        final ResponsiveHelper _responsiveHelper =
            ResponsiveHelper(context: context);
        return SafeArea(
            child: Scaffold(
          drawer: Drawer(),
          appBar: AppBar(
            title: Text("Responsive"),
            centerTitle: false,
            actions: [
              NavItem(
                child: Icon(Icons.login),
                title: "Login",
                subTitle:
                    _responsiveHelper.isDesktop ? "Unlock more features" : null,
                hideTitles: _responsiveHelper.isMobile,
                onPressed: () => DialogUtil.openLoginPopup(context),
              ),
              NavItem(
                child: Icon(Icons.share),
                title: "Share",
                subTitle: _responsiveHelper.isDesktop ? "Invite others" : null,
                hidden: _responsiveHelper.isMobile,
              ),
              NavItem(
                child: Icon(Icons.call),
                title: "Toll Free",
                subTitle: "Call our customer care",
                hideTitles: _responsiveHelper.isMobile,
              ),
            ],
          ),
          body: ResponsiveImageList(_responsiveHelper),
        ));
      }),
    );
  }
}

class ResponsiveImageList extends StatelessWidget {
  final ResponsiveHelper responsiveHelper;

  const ResponsiveImageList(
    this.responsiveHelper, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: RowOrColumn(
        showRow: !responsiveHelper.isMobile,
        columnCrossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ExpandedIf(
              expanded: !responsiveHelper.isMobile,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Image.asset(
                  "assets/images/banner1.jpeg",
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              )),
          ExpandedIf(
              expanded: !responsiveHelper.isMobile,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Image.asset(
                  "assets/images/banner2.jpeg",
                  height: 200,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              )),
          ExpandedIf(
              expanded: !responsiveHelper.isMobile,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Image.asset(
                  "assets/images/banner5.jpeg",
                  height: 200,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ))
        ],
      ),
    );
  }
}

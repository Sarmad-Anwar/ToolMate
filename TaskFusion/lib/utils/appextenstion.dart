import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

extension NavigationExtension on BuildContext {
  void route(Widget screen) {
    Navigator.of(this).push(
      CupertinoPageRoute(
        builder: (context) => screen,
      ),
    );
  }

  void routeoffall(Widget screen) {
    Navigator.of(this).pushAndRemoveUntil(
      CupertinoPageRoute(
        builder: (context) => screen,
      ),
      (route) => false,
    );
  }
}

//  extenstion for pop

extension NavigationExtensionPop on BuildContext {
  void pop() {
    Navigator.of(this).pop();
  }
}

//  extenstion for pop untill

extension NavigationExtensionPopUntil on BuildContext {
  void popUntil(String routeName) {
    Navigator.of(this).popUntil(ModalRoute.withName(routeName));
  }
}

//  extenstion for snackbar

extension SnackBarExtension on BuildContext {
  void showSnackBar(String message, String string) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }
}

//  extenstion for sizedbox you will only use like hieght.10

extension SizedBoxExtension on double {
  SizedBox get heightboxss => SizedBox(height: this);
  SizedBox get widthboxss => SizedBox(width: this);
}

//  extenstion for mediaquery

extension MediaQueryExtension on BuildContext {
  double get heightss => MediaQuery.of(this).size.height;
  double get widths => MediaQuery.of(this).size.width;
}

//  extenstion for theme

extension ThemeExtension on BuildContext {
  TextTheme get textThemes => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  ColorScheme get darkColorScheme => Theme.of(this).colorScheme;
}

//  extenstion for device type for condition bases

extension DeviceType on BuildContext {
  bool get isFold => MediaQuery.of(this).size.width < 300;
  bool get isMobile => MediaQuery.of(this).size.width < 800;
  bool get isTablet =>
      MediaQuery.of(this).size.width >= 800 &&
      MediaQuery.of(this).size.width < 1200;
  bool get isDesktop => MediaQuery.of(this).size.width >= 1200;
}

class ScalePageRoute<T> extends PageRouteBuilder<T> {
  final WidgetBuilder builder;

  ScalePageRoute({required this.builder})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) =>
              builder(context),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );
}

//  extenstion for copy text
extension CopyTextExtension on BuildContext {
  void copyText(String text) {
    Clipboard.setData(ClipboardData(text: text));
  }
}

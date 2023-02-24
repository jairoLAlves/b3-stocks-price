import 'package:flutter/material.dart';

class MediaQueryProvider extends ChangeNotifier {
  bool widthBigSize(BuildContext context) {
    return MediaQuery.of(context).size.width > 640;
  }

  bool heightBigSize(BuildContext context) {
    return MediaQuery.of(context).size.height > 640;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
//import 'package:jovial_svg/jovial_svg.dart';
// Widget LogoStockSvg(String logoUrl) {
//   return ScalableImageWidget.fromSISource(
//     fit: BoxFit.cover,
//     onError: (p0) => const Center(),
//     onLoading: (_) => const Center(
//       child: CircularProgressIndicator(color: Colors.amber),
//     ),
//     si: ScalableImageSource.fromSvgHttpUrl(Uri.parse(logoUrl),
//         currentColor: Colors.transparent),
//   );
// }

Widget LogoStockSvg(String logoUrl) {
  return SvgPicture.network(
    Uri.parse(logoUrl).toString(),
    semanticsLabel: 'Logo Stock',
    placeholderBuilder: (BuildContext context) => const Center(
        child:
            CircularProgressIndicator()), //placeholder while downloading file.
  );
}

  
  
  
  import 'package:flutter/material.dart';
import 'package:jovial_svg/jovial_svg.dart';

Widget  getNetWorkSvg(String logoUrl){
return ScalableImageWidget.fromSISource(
      fit: BoxFit.cover,
      onLoading: (_) =>
          const Center(child: CircularProgressIndicator(color: Colors.amber)),
      si: ScalableImageSource.fromSvgHttpUrl(Uri.parse(logoUrl),
          currentColor: Colors.transparent),
    );
    
  }
  
  
   
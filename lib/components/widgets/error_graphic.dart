  
  


import 'package:flutter/material.dart';

Widget errorGraphic(Function() onPressedBtnError) {
    return SizedBox(
     // height: height,
      child: Center(
          child: ElevatedButton(
        onPressed: onPressedBtnError,
        child: const Text('Tente Novamente'),
      )),
    );
  }

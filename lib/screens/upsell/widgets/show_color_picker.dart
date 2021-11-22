import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:mint_bird_app/screens/upsell/controller/upsell_customise_controller.dart';

showColorPicker({VoidCallback onSet, Function(Color) onChanged}) {
  UpsellCustomiseController uCC = Get.put(UpsellCustomiseController());
  Get.dialog(AlertDialog(
    title: Text('Pick a color!'),
    content: SingleChildScrollView(
      child: ColorPicker(
        pickerColor: uCC.pickerColor.value,
        onColorChanged: onChanged,
        showLabel: true,
        pickerAreaHeightPercent: 0.8,
      ),
    ),
    actions: <Widget>[
      ElevatedButton(
        child: Text('SET'),
        onPressed: onSet,
      ),
    ],
  ));
}

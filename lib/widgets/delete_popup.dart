import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget deletePopUp({String title, VoidCallback onDelete}) {
  return PopupMenuButton(
    itemBuilder: (context) {
      return [
        PopupMenuItem(
          padding: EdgeInsets.zero,
          child: Center(child: Text("Delete")),
          value: 0,
        )
      ];
    },
    onSelected: (value) {
      Get.defaultDialog(
          title: "Are you sure you want to delete this $title ?",
          barrierDismissible: false,
          content: SizedBox(),
          radius: 5,
          actions: [
            SizedBox(
              height: 45,
              child: MaterialButton(
                onPressed: () {
                  Get.back();
                },
                child: Text("NO",
                    style: TextStyle(color: Colors.black, fontSize: 16)),
              ),
            ),
            SizedBox(
              height: 45,
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                onPressed: () {
                  onDelete();
                  Get.back();
                },
                child: Text(
                  "Yes, Delete",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                color: Colors.redAccent,
              ),
            ),
          ]);
    },
    child: Icon(
      Icons.more_vert_rounded,
      color: Color(0xffcccccc),
    ),
  );
}

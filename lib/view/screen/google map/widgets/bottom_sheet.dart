import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nearby_scarch/models/place_model.dart';

class MakePayment {
  static makePaymentSheet(PlaceModel model) {
    print("slkfjadsfjlkdsklfljk");

    return showModalBottomSheet(
      backgroundColor: Colors.white,
      context: Get.context!,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(model.displayName.text,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 20,
                ),
                Text(model.formattedAddress,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w600)),
                const SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/home_controller.dart';

class Kurir extends GetView<HomeController> {
  const Kurir({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: DropdownSearch<String>(
        mode: Mode.MENU,
        showSelectedItem: true,
        items: [
          "JNE",
          "POS Indonesia",
          "TIKI",
        ],
        label: "Pengiriman",
        onChanged: (value) => {
          controller.ubahKurir(value!),
        },
      ),
    );
  }
}

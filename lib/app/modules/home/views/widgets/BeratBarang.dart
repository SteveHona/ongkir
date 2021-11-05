import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/home_controller.dart';

class BeratBarang extends GetView<HomeController> {
  const BeratBarang({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              autocorrect: false,
              controller: controller.weightController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: "Berat Barang",
                hintText: "Berat Barang",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => {
                controller.ubahBerat(value),
              },
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            width: 150,
            child: DropdownSearch<String>(
              mode: Mode.BOTTOM_SHEET,
              showSearchBox: true,
              showSelectedItem: true,
              items: [
                "Ton",
                "Kg",
                "Gram",
                "Ons",
                "Kwintal",
                "Lbs",
                "Pound",
                "Hg",
                "Dag",
                "Dg",
                "Cg",
                "Mg"
              ],
              label: "Satuan",
              onChanged: (value) => {
                controller.ubahSatuan(value!),
              },
              selectedItem: "Gram",
              searchBoxDecoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 10,
                ),
                hintText: "Cari satuan...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

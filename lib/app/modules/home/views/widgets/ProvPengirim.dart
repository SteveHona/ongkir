import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../../../../data/models/province_model.dart';
import '../../controllers/home_controller.dart';
import 'package:dropdown_search/dropdown_search.dart';

class ProvinsiPengirim extends GetView<HomeController> {
  const ProvinsiPengirim({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: DropdownSearch<Province>(
        showSearchBox: true,
        showClearButton: true,
        // ignore: deprecated_member_use
        label: "Provinsi pengirim",
        onFind: (filter) async {
          Uri url = Uri.parse("https://api.rajaongkir.com/starter/province");
          try {
            final response = await http
                .get(url, headers: {"key": "06ce6a002911ef698fca248a38f41dc3"});
            var data = json.decode(response.body) as Map<String, dynamic>;
            var status_code = data['rajaongkir']['status']['code'];
            var description = data['rajaongkir']['status']['description'];
            if (status_code != 200) {
              throw description;
            }
            var listOfProvince = data['rajaongkir']['results'] as List<dynamic>;
            var models = Province.fromJsonList(listOfProvince);
            return models;
          } catch (err) {
            print(err);
            return List<Province>.empty();
          }
        },
        onChanged: (province) {
          if (province != null) {
            controller.provSendId.value = "${province.provinceId}";
            controller.hiddenCitySend.value = false;
            controller.provSend.value = "${province.province}";
          } else {
            controller.hiddenCitySend.value = true;
            controller.provSend.value = "";
          }
        },
        popupItemBuilder: (context, item, isSelected) {
          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: Text(
              "${item.province}",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          );
        },
        searchBoxDecoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 25,
            vertical: 10,
          ),
          hintText: "Cari privinsi...",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        itemAsString: (item) => item.province!,
      ),
    );
  }
}

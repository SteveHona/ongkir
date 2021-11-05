import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../../../../data/models/city_model.dart';
import '../../controllers/home_controller.dart';
import 'package:dropdown_search/dropdown_search.dart';

class KotaPenerima extends GetView<HomeController> {
  const KotaPenerima({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: DropdownSearch<City>(
        showSearchBox: true,
        showClearButton: true,
        // ignore: deprecated_member_use
        label: "Kota/kabupaten penerima",
        onFind: (filter) async {
          Uri url = Uri.parse(
              "https://api.rajaongkir.com/starter/city?province=${controller.provRecieveId}");
          try {
            final response = await http
                .get(url, headers: {"key": "06ce6a002911ef698fca248a38f41dc3"});
            var data = json.decode(response.body) as Map<String, dynamic>;
            var status_code = data['rajaongkir']['status']['code'];
            var description = data['rajaongkir']['status']['description'];
            if (status_code != 200) {
              throw description;
            }
            var listOfCity = data['rajaongkir']['results'] as List<dynamic>;
            var models = City.fromJsonList(listOfCity);
            return models;
          } catch (err) {
            print(err);
            return List<City>.empty();
          }
        },
        onChanged: (kota) {
          if (kota != null) {
            print(kota.cityName);
            controller.cityRecieveId.value = "${kota.cityId}";
          } else {
            controller.cityRecieveId.value = "";
          }
        },
        popupItemBuilder: (context, item, isSelected) {
          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: Text(
              "${item.type} ${item.cityName}",
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
          hintText: "Cari kota/kabupaten...",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        itemAsString: (item) => "${item.type} ${item.cityName}",
      ),
    );
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../../../data/models/city_model.dart';
import '../../../data/models/province_model.dart';
import '../controllers/home_controller.dart';
import 'package:dropdown_search/dropdown_search.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ongkos Kirim Indonesia'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(
          20,
        ),
        children: [
          ProvinsiPengirim(),
          Obx(
            () =>
                controller.hiddenCitySend.isTrue ? SizedBox() : KotaPengirim(),
          ),
          ProvinsiPenerima(),
          Obx(
            () => controller.hiddenCityRecieve.isTrue
                ? SizedBox()
                : KotaPenerima(),
          ),
        ],
      ),
    );
  }
}

class KotaPengirim extends GetView<HomeController> {
  const KotaPengirim({
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
        label: "Kota/kabupaten pengirim",
        onFind: (filter) async {
          Uri url = Uri.parse(
              "https://api.rajaongkir.com/starter/city?province=${controller.provSend}");
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
            print(kota);
          } else {
            print("Tidak memilih kota apapun");
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
            controller.provSend.value = "${province.provinceId}";
            controller.hiddenCitySend.value = false;
          } else {
            controller.hiddenCitySend.value = true;
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
              "https://api.rajaongkir.com/starter/city?province=${controller.provRecieve}");
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
            print(kota);
          } else {
            print("Tidak memilih kota apapun");
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

class ProvinsiPenerima extends GetView<HomeController> {
  const ProvinsiPenerima({
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
        label: "Provinsi penerima",
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
            controller.provRecieve.value = "${province.provinceId}";
            controller.hiddenCityRecieve.value = false;
          } else {
            controller.hiddenCitySend.value = true;
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

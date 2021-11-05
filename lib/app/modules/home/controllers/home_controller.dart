import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ongkirapps/app/data/models/cost_model.dart';

class HomeController extends GetxController {
  var hiddenCitySend = true.obs;
  var provSendId = "".obs;
  var hiddenCityRecieve = true.obs;
  var provRecieveId = "".obs;
  var provSend = "".obs;
  var citySendId = "".obs;
  var provRecieve = "".obs;
  var cityRecieveId = "".obs;
  String kurir = "";
  double berat = 0.0;
  String satuan = "Gram";

  late TextEditingController weightController;

  Future<void> actionSubmitButton() async {
    Uri url = Uri.parse("https://api.rajaongkir.com/starter/cost");
    final response = await http.post(
      url,
      headers: {
        "content-type": "application/x-www-form-urlencoded",
        "key": "06ce6a002911ef698fca248a38f41dc3",
      },
      body: {
        "origin": "$citySendId",
        "destination": "$cityRecieveId",
        "weight": "$berat",
        "courier": "$kurir",
      },
    );
    var data = json.decode(response.body) as Map<String, dynamic>;
    var listOfResults = data['rajaongkir']['results'] as List<dynamic>;
    var models = Cost.fromJsonList(listOfResults);
    var cost = models[0];
    Get.defaultDialog(
      title: cost.name!,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: cost.costs!
            .map((e) => ListTile(
                  title: Text("${e.description}"),
                  subtitle: Text("Rp. ${e.cost![0].value}"),
                  trailing: Text(cost.code == "pos"
                      ? "${e.cost![0].etd}"
                      : "${e.cost![0].etd} HARI"),
                ))
            .toList(),
      ),
    );
  }

  void ubahKurir(String value) {
    switch (value) {
      case "JNE":
        kurir = "jne";
        break;
      case "POS Indonesia":
        kurir = "pos";
        break;
      case "TIKI":
        kurir = "tiki";
        break;
      default:
    }
  }

  void ubahBerat(String value) {
    berat = double.tryParse(value) ?? 0.0;
    String cekSatuan = satuan;
    switch (cekSatuan) {
      case "Ton":
        berat = berat * 1000000;
        break;
      case "Kg":
        berat = berat * 1000;
        break;
      case "Gram":
        berat = berat;
        break;
      case "Ons":
        berat = berat * 100;
        break;
      case "Kwintal":
        berat = berat * 100000;
        break;
      case "Lbs":
        berat = berat * 2204.62;
        break;
      case "Pound":
        berat = berat * 2204.62;
        break;
      case "Hg":
        berat = berat * 100;
        break;
      case "Dag":
        berat = berat * 10;
        break;
      case "Dg":
        berat = berat / 10;
        break;
      case "Cg":
        berat = berat / 100;
        break;
      case "Mg":
        berat = berat / 1000;
        break;
      default:
        berat = berat;
    }
    print("$berat gram");
  }

  void ubahSatuan(String value) {
    berat = double.tryParse(weightController.text) ?? 0.0;
    switch (value) {
      case "Ton":
        berat = berat * 1000000;
        break;
      case "Kg":
        berat = berat * 1000;
        break;
      case "Gram":
        berat = berat;
        break;
      case "Ons":
        berat = berat * 100;
        break;
      case "Kwintal":
        berat = berat * 100000;
        break;
      case "Lbs":
        berat = berat * 2204.62;
        break;
      case "Pound":
        berat = berat * 2204.62;
        break;
      case "Hg":
        berat = berat * 100;
        break;
      case "Dag":
        berat = berat * 10;
        break;
      case "Dg":
        berat = berat / 10;
        break;
      case "Cg":
        berat = berat / 100;
        break;
      case "Mg":
        berat = berat / 1000;
        break;
      default:
        berat = berat;
    }
    print("$berat gram");
  }

  @override
  void onInit() {
    weightController = TextEditingController(text: "$berat");
    super.onInit();
  }

  @override
  void onClose() {
    weightController.dispose();
    super.onClose();
  }
}

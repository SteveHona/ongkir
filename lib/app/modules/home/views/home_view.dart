import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ongkirapps/app/modules/home/views/widgets/Kurir.dart';
import './widgets/BeratBarang.dart';
import './widgets/KotaPenerima.dart';
import './widgets/KotaPengirim.dart';
import './widgets/ProvPengirim.dart';
import '../controllers/home_controller.dart';
import 'package:ongkirapps/app/data/models/cost_model.dart';

import 'widgets/ProvPenerima.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ongkos Kirim Indonesia'),
        centerTitle: true,
        backgroundColor: Colors.red[900],
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(
            20,
          ),
          children: [
            ProvinsiPengirim(),
            Obx(
              () => controller.hiddenCitySend.isTrue
                  ? SizedBox()
                  : KotaPengirim(),
            ),
            ProvinsiPenerima(),
            Obx(
              () => controller.hiddenCityRecieve.isTrue
                  ? SizedBox()
                  : KotaPenerima(),
            ),
            BeratBarang(),
            Kurir(),
            ElevatedButton(
              onPressed: () async {
                if (controller.provSend == "" ||
                    controller.provRecieve == "" ||
                    controller.citySendId == "" ||
                    controller.cityRecieveId == "" ||
                    controller.berat == 0.0 ||
                    controller.kurir == "") {
                  Flushbar(
                    title: "Peringatan",
                    message:
                        "Ada isian yang belum terpilih/ diisi, silakan diisi kembali",
                    duration: Duration(seconds: 2),
                  ).show(context);
                } else {
                  Flushbar(
                    title: "Perhatian",
                    message: "Loading...",
                    duration: Duration(seconds: 2),
                  ).show(context);
                  controller.actionSubmitButton();

                  // showDialog(
                  //   context: context,
                  //   builder: (context) {
                  //     return AlertDialog(
                  //       title: Text("Tes"),
                  //       content: ListView.builder(
                  //         itemCount: models.length,
                  //         itemBuilder: (context, index) {
                  //           return Container(
                  //             child: Row(
                  //               children: [
                  //                 Container(
                  //                   child: Text(models['']),
                  //                 ),
                  //                 Container(),
                  //               ],
                  //             ),
                  //           );
                  //         },
                  //       ),
                  //     );
                  //   },
                  // );
                }
              },
              child: Text("Cek Ongkos Kirim"),
              style: ElevatedButton.styleFrom(
                primary: Colors.red[900],
                padding: EdgeInsets.symmetric(
                  vertical: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

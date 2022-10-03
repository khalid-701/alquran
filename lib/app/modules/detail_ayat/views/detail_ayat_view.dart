import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_ayat_controller.dart';

class DetailAyatView extends GetView<DetailAyatController> {
  const DetailAyatView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DetailAyatView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'DetailAyatView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

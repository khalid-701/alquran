import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/cosntants/color_constants.dart';
import 'app/routes/app_pages.dart';

void main() async{
  await GetStorage.init();
  final tema = GetStorage();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: Routes.INTRODUCTION,
      getPages: AppPages.routes,
      theme: tema.read("themeDark") == null ? appLight : appDark,
    ),
  );
}

import 'package:alquran/app/data/models/detail_surah/detail_surah.dart'
    as detailSurah;
import 'package:alquran/app/data/models/surah/surah.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_surah_controller.dart';

class DetailSurahView extends GetView<DetailSurahController> {
  const DetailSurahView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Surah surah = Get.arguments;
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Get.isDarkMode ? Colors.white:Colors.black, //change your color here
          ),
          title: Text("${surah.name?.transliteration?.id?.toUpperCase()}", style: TextStyle(color: Get.isDarkMode ? Colors.white : Colors.black),),
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            GestureDetector(
              onTap: () => Get.defaultDialog(
                  contentPadding: const EdgeInsets.all(10),
                  title: "Tafsir ${surah.name?.transliteration?.id}",
                  content: Text(
                    surah.tafsir?.id ?? "Tidak ada tafsir",
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w400),
                  )),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: Get.isDarkMode ? const LinearGradient(
                        colors: [Colors.black12, Colors.black]) : const LinearGradient(
                        colors: [Colors.greenAccent, Colors.green])),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        "${surah.name?.transliteration?.id?.toUpperCase()}",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color:
                                Get.isDarkMode ? Colors.white : Colors.black),
                      ),
                      Text(
                        "( ${surah.name?.translation?.id?.toUpperCase()} )",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color:
                                Get.isDarkMode ? Colors.white : Colors.black),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "${surah.numberOfVerses} Ayat | ${surah.revelation?.id}",
                        style: TextStyle(
                            fontSize: 16,
                            color:
                                Get.isDarkMode ? Colors.white : Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            FutureBuilder<detailSurah.DetailSurah>(
                future: controller.detailSurah(surah.number.toString()),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (!snapshot.hasData) {
                    return const Center(child: Text("Tidak ada data"));
                  }
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data?.verses?.length,
                      itemBuilder: (context, index) {
                        if (snapshot.data?.verses?.length == 0) {
                          return const SizedBox();
                        }
                        detailSurah.Verse? ayat = snapshot.data?.verses?[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Get.isDarkMode ? Colors.black38 : Colors.grey[100] ),

                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 35,
                                      width: 35,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(Get.isDarkMode
                                                  ? "assets/images/list_dark.png"
                                                  : "assets/images/list2.png"))),
                                      child: Center(
                                        child: Text("${index + 1}"),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                                Icons.bookmark_add_outlined)),
                                        IconButton(
                                            onPressed: () {},
                                            icon: const Icon(Icons.play_arrow)),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "${ayat?.text?.arab}",
                              style: const TextStyle(fontSize: 25),
                              textAlign: TextAlign.end,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "${ayat?.text?.transliteration?.en}",
                              style: const TextStyle(
                                  fontSize: 18, fontStyle: FontStyle.italic),
                              textAlign: TextAlign.end,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "${ayat?.translation?.id}",
                              style: const TextStyle(fontSize: 16),
                              textAlign: TextAlign.justify,
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                          ],
                        );
                      });
                })
          ],
        ));
  }
}

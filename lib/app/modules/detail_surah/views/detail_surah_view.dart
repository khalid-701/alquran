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
          title: Text("${surah.name?.transliteration?.id?.toUpperCase()}"),
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      "${surah.name?.transliteration?.id?.toUpperCase()}",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "( ${surah.name?.translation?.id?.toUpperCase()} )",
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${surah.numberOfVerses} Ayat | ${surah.revelation?.id}",
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
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
                        detailSurah.Verse? ayat =
                            snapshot.data?.verses?[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () => Get.defaultDialog(),
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CircleAvatar(
                                        child: Text("${index + 1}"),
                                      ),

                                      Container(
                                        height: 35,
                                        width: 35,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    controller.isDarkMode.isTrue
                                                        ? "assets/images/list_dark.png"
                                                        : "assets/images/list2.png"))),
                                        child: Center(
                                          child: Text(surah.number.toString()),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                              onPressed: () {},
                                              icon: const Icon(Icons
                                                  .bookmark_add_outlined)),
                                          IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                  Icons.play_arrow)),
                                        ],
                                      )
                                    ],
                                  ),
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
                                  fontSize: 18,
                                  fontStyle: FontStyle.italic),
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

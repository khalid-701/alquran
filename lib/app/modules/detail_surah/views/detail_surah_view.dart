import 'package:alquran/app/data/models/detail_surah/detail_surah.dart'
    as detailSurah;
import 'package:alquran/app/data/models/surah/surah.dart';
import 'package:alquran/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_surah_controller.dart';

class DetailSurahView extends GetView<DetailSurahController> {
  const DetailSurahView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Surah surah = Get.arguments;
    final homeC = Get.find<HomeController>();
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Get.isDarkMode
                ? Colors.white
                : Colors.black, //change your color here
          ),
          title: Text(
            "${surah.name?.transliteration?.id?.toUpperCase()}",
            style:
                TextStyle(color: Get.isDarkMode ? Colors.white : Colors.black),
          ),
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
                    gradient: Get.isDarkMode
                        ? const LinearGradient(
                            colors: [Colors.black12, Colors.black])
                        : const LinearGradient(
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
              height: 10,
            ),
            if (surah.number != 1)
              Column(
                children: [
                  Text(
                    "بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ",
                    style: TextStyle(
                        fontSize: 25,
                        color: Get.isDarkMode ? Colors.white : Colors.black),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Bismillaahir Rahmaanir Raheem",
                    style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                    textAlign: TextAlign.end,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    "Dengan nama Allah Yang Pengasih, Maha Penyayang.",
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
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
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Get.isDarkMode
                                      ? Colors.black38
                                      : Colors.grey[100]),
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
                                    GetBuilder<DetailSurahController>(
                                      builder: (c) => Row(
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                Get.defaultDialog(
                                                    title: "BOOKMARK",
                                                    middleText:
                                                        "Pilih jenis bookmark",
                                                    actions: [
                                                      ElevatedButton(
                                                          onPressed: () async {
                                                            await c.addBookmark(
                                                                true,
                                                                snapshot.data!,
                                                                ayat!,
                                                                index,
                                                                "surah");
                                                            homeC.update();
                                                          },
                                                          child: Text(
                                                              "LAST READ")),
                                                      ElevatedButton(
                                                          onPressed: () async {
                                                            await c.addBookmark(
                                                                false,
                                                                snapshot.data!,
                                                                ayat!,
                                                                index,
                                                                "surah");
                                                          },
                                                          child:
                                                              Text("BOOKMARK")),
                                                    ]);
                                              },
                                              icon: const Icon(
                                                  Icons.bookmark_add_outlined)),
                                          (ayat?.kondisiAudio == "stop")
                                              ? IconButton(
                                                  onPressed: () {
                                                    c.playAudio(ayat!);
                                                  },
                                                  icon: const Icon(
                                                      Icons.play_arrow))
                                              : Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    (ayat?.kondisiAudio ==
                                                            "playing")
                                                        ? IconButton(
                                                            onPressed: () {
                                                              c.pauseAudio(
                                                                  ayat!);
                                                            },
                                                            icon: const Icon(
                                                                Icons.pause))
                                                        : IconButton(
                                                            onPressed: () {
                                                              c.resumeAudio(
                                                                  ayat!);
                                                            },
                                                            icon: const Icon(Icons
                                                                .play_arrow)),
                                                    IconButton(
                                                        onPressed: () {
                                                          c.stopAudio(ayat!);
                                                        },
                                                        icon: const Icon(
                                                            Icons.stop))
                                                  ],
                                                )
                                        ],
                                      ),
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
                              height: 20,
                            ),
                          ],
                        );
                      });
                })
          ],
        ));
  }
}

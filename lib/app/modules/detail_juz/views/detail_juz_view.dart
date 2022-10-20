import 'package:alquran/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/models/juz/juz.dart' as juz;
import '../../../data/models/surah/surah.dart';
import '../controllers/detail_juz_controller.dart';

class DetailJuzView extends GetView<DetailJuzController> {
  const DetailJuzView({super.key});

  @override
  Widget build(BuildContext context) {
    final juz.Juz detailJuz = Get.arguments['juz'];
    final List<Surah> allSurahInJuz = Get.arguments['surah'];
    final homeC = Get.find<HomeController>();
    return Scaffold(
        appBar: AppBar(
          title: Text('JUZ ${detailJuz.juz}',
              style: TextStyle(
                  color: Get.isDarkMode ? Colors.white : Colors.black)),
          iconTheme: IconThemeData(
            color: Get.isDarkMode
                ? Colors.white
                : Colors.black, //change your color here
          ),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            ListView.builder(
              padding: const EdgeInsets.all(20),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: detailJuz.verses!.length,
              itemBuilder: (context, index) {
                if (detailJuz.verses?.length == 0 || detailJuz.verses == null) {
                  return const Center(
                    child: Text("Tidak ada data."),
                  );
                }
                juz.Verses ayat = detailJuz.verses![index];
                detailJuz.verses?[index].kondisiAudio = "stop";

                print(ayat.text?.transliteration?.en);

                if (index != 0) {
                  if (ayat.number?.inSurah == 1) {
                    controller.index++;
                  }
                }
                return Column(
                  children: [
                    if (ayat.number?.inSurah == 1)
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () => Get.defaultDialog(
                                contentPadding: const EdgeInsets.all(10),
                                title:
                                    "Tafsir ${allSurahInJuz[controller.index].name?.transliteration?.id}",
                                content: Text(
                                  allSurahInJuz.first.tafsir?.id ??
                                      "Tidak ada tafsir",
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                )),
                            child: Container(
                              width: Get.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: Get.isDarkMode
                                      ? const LinearGradient(colors: [
                                          Colors.black12,
                                          Colors.black
                                        ])
                                      : const LinearGradient(colors: [
                                          Colors.greenAccent,
                                          Colors.green
                                        ])),
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  children: [
                                    Text(
                                      "${allSurahInJuz[controller.index].name?.transliteration?.id?.toUpperCase()}",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Get.isDarkMode
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                    Text(
                                      "( ${allSurahInJuz[controller.index].name?.translation?.id?.toUpperCase()} )",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Get.isDarkMode
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    Column(
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(right: 10),
                                      height: 35,
                                      width: 35,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(Get.isDarkMode
                                                  ? "assets/images/list_dark.png"
                                                  : "assets/images/list2.png"))),
                                      child: Center(
                                        child: Text("${ayat.number?.inSurah}"),
                                      ),
                                    ),
                                    Text(
                                      "${allSurahInJuz[controller.index].name?.transliteration?.id}",
                                      style: const TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontSize: 16),
                                    )
                                  ],
                                ),
                                GetBuilder<DetailJuzController>(
                                  builder: (c) => Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            print("index_nih");
                                            print(index);
                                            print(allSurahInJuz[c.index].name?.transliteration?.id.toString());
                                            Get.defaultDialog(
                                                title: "BOOKMARK",
                                                middleText: "Tandai sebagai",
                                                actions: [
                                                  ElevatedButton(
                                                      onPressed: () async {
                                                        await c.addBookmark(
                                                            true,
                                                            "${allSurahInJuz[c.index].name?.transliteration?.id}",
                                                            int.parse(
                                                                allSurahInJuz[
                                                                        c.index]
                                                                    .number
                                                                    .toString()),
                                                            ayat,
                                                            c.index,
                                                            "juz");
                                                        homeC.update();
                                                      },
                                                      child: Text(
                                                          "TERAKHIR DIBACA")),
                                                  ElevatedButton(
                                                      onPressed: () async {
                                                        await c.addBookmark(
                                                            false,
                                                            "${allSurahInJuz[c.index].name?.transliteration?.id}",
                                                            int.parse(
                                                                allSurahInJuz[
                                                                        index]
                                                                    .number
                                                                    .toString()),
                                                            ayat,
                                                            c.index,
                                                            "juz");
                                                        homeC.update();
                                                      },
                                                      child: Text("BOOKMARK")),
                                                ]);
                                          },
                                          icon: const Icon(
                                              Icons.bookmark_add_outlined)),
                                      (ayat.kondisiAudio == "stop")
                                          ? IconButton(
                                              onPressed: () {
                                                c.playAudio(ayat);
                                              },
                                              icon:
                                                  const Icon(Icons.play_arrow))
                                          : Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                (ayat.kondisiAudio == "playing")
                                                    ? IconButton(
                                                        onPressed: () {
                                                          c.pauseAudio(ayat);
                                                        },
                                                        icon: const Icon(
                                                            Icons.pause))
                                                    : IconButton(
                                                        onPressed: () {
                                                          c.resumeAudio(ayat);
                                                        },
                                                        icon: const Icon(
                                                            Icons.play_arrow)),
                                                IconButton(
                                                    onPressed: () {
                                                      c.stopAudio(ayat);
                                                    },
                                                    icon:
                                                        const Icon(Icons.stop))
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
                          "${ayat.text?.arab}",
                          style: const TextStyle(fontSize: 25),
                          textAlign: TextAlign.end,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "${ayat.text?.transliteration?.en}",
                          style: const TextStyle(
                              fontSize: 18, fontStyle: FontStyle.italic),
                          textAlign: TextAlign.end,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "${ayat.translation?.id}",
                          style: const TextStyle(fontSize: 16),
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ],
        ));
  }
}

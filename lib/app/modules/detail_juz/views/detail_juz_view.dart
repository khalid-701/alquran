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
    allSurahInJuz.forEach((element) {
      print(element.name!.transliteration!.id);
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('JUZ ${detailJuz.juz}', style: TextStyle(color: Get.isDarkMode ? Colors.white : Colors.black)),
        iconTheme: IconThemeData(
          color: Get.isDarkMode ? Colors.white:Colors.black, //change your color here
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(20),
        itemCount: detailJuz.verses!.length,
        itemBuilder: (context, index) {
          if(detailJuz.verses?.length == 0 || detailJuz.verses == null) {
            return const Center(
              child: Text("Tidak ada data."),
            );
          }
          juz.Verses ayat = detailJuz.verses![index];
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
                        child: Text("${ayat.number?.inSurah}"),
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
              textAlign: TextAlign.justify,
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        );
      },)
    );
  }
}

import 'package:alquran/app/cosntants/color_constants.dart';
import 'package:alquran/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

import '../../../data/models/juz/juz.dart' as juz;
import '../../../data/models/surah/surah.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Get.isDarkMode) {
      controller.isDarkMode.value = true;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Al Quran Apps"),
        centerTitle: true,
        actions: [
          // Obx(() {
          //   return IconButton(
          //       onPressed: () => Get.toNamed(Routes.SEARCH),
          //       icon: Icon(
          //         Icons.search,
          //         color: controller.isDarkMode.isTrue
          //             ? Colors.white
          //             : Colors.black,
          //       ));
          // }),
          Obx(() {
            return Container(
              width: 100,
              height: 40,
              child: LiteRollingSwitch(
                //initial value
                value: controller.isDarkMode.value,
                textOn: 'Light',
                textOff: 'Dark',
                colorOn: Colors.green,
                colorOff: Colors.red,
                iconOn: Icons.light_mode,
                iconOff: Icons.dark_mode,
                textSize: 16.0,
                onChanged: (bool state) {
                  print('Current State of SWITCH IS: $state');
                },
                onTap: () {
                  controller.changeTheme();
                },
                onDoubleTap: () {
                  controller.changeTheme();
                },
                onSwipe: () {
                  controller.changeTheme();
                },
              ),
            );
            // return IconButton(
            //     onPressed: () {
            //       controller.changeTheme();
            //     },
            //     icon: Icon(
            //       Icons.color_lens,
            //       color: controller.isDarkMode.isTrue
            //           ? Colors.white
            //           : Colors.black,
            //     ));
          })
        ],
      ),
      body: DefaultTabController(
        length: 3,
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0, right: 20, left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Assalamualaikum"),
              const Text("Akhirnya kamu melihatku"),
              GetBuilder<HomeController>(builder: (c) {
                return FutureBuilder<Map<String, dynamic>?>(
                  future: c.getLastRead(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Obx(() {
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: controller.isDarkMode.isTrue
                                  ? const LinearGradient(
                                      colors: [Colors.black12, Colors.black])
                                  : const LinearGradient(colors: [
                                      Colors.greenAccent,
                                      Colors.green
                                    ])),
                          child: Material(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                            child: Stack(
                              children: [
                                Positioned(
                                  bottom: -15,
                                  right: 0,
                                  child: Opacity(
                                    opacity:
                                        controller.isDarkMode.isTrue ? 1 : 0.6,
                                    child: SizedBox(
                                        width: 150,
                                        height: 150,
                                        child: Image.asset(
                                          "assets/images/quran.png",
                                          fit: BoxFit.contain,
                                        )),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: const [
                                          Icon(
                                            Icons.menu_book_rounded,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "Terakhir dibaca",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      const Text("Loading...",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20)),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      const Text("",
                                          style: TextStyle(color: Colors.white))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                    }

                    Map<String, dynamic>? lastRead = snapshot.data;
                    return Obx(() {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: controller.isDarkMode.isTrue
                                ? const LinearGradient(
                                    colors: [Colors.black12, Colors.black])
                                : const LinearGradient(colors: [
                                    Colors.greenAccent,
                                    Colors.green
                                  ])),
                        child: Material(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20),
                            onLongPress: () {
                              if (lastRead != null) {
                                Get.defaultDialog(
                                    title: "Hapus Terakhir Dibaca",
                                    middleText:
                                        "Apakah kamu yakin ingin menghapusnya ?",
                                    actions: [
                                      OutlinedButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: Text("BATAL")),
                                      ElevatedButton(
                                          onPressed: () {
                                            c.deleteBookmark(
                                                lastRead['id'].toString());
                                          },
                                          child: Text("HAPUS")),
                                    ]);
                              }
                            },
                            onTap: () => Get.toNamed(Routes.LAST_READ),
                            child: Stack(
                              children: [
                                Positioned(
                                  bottom: -15,
                                  right: 0,
                                  child: Opacity(
                                    opacity:
                                        controller.isDarkMode.isTrue ? 1 : 0.6,
                                    child: SizedBox(
                                        width: 150,
                                        height: 150,
                                        child: Image.asset(
                                          "assets/images/quran.png",
                                          fit: BoxFit.contain,
                                        )),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: const [
                                          Icon(
                                            Icons.menu_book_rounded,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "Terakhir dibaca",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                          lastRead != null
                                              ? lastRead['surah']
                                                  .toString()
                                                  .replaceAll("+", "'")
                                              : "",
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20)),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                          lastRead == null
                                              ? "Belum ada yang dibaca"
                                              : "Juz ${lastRead['juz']} | Ayat ${lastRead['ayat']}",
                                          style: TextStyle(color: Colors.white))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
                  },
                );
              }),
              Obx(() {
                return TabBar(
                    indicatorColor: Colors.greenAccent,
                    labelColor: controller.isDarkMode.isTrue
                        ? Colors.greenAccent
                        : Colors.black,
                    unselectedLabelColor: Colors.grey,
                    tabs: const [
                      Tab(
                        text: "Surah",
                      ),
                      Tab(
                        text: "Juz",
                      ),
                      Tab(
                        text: "Bookmarks",
                      ),
                    ]);
              }),
              Expanded(
                  child: TabBarView(
                children: [
                  //SURAH
                  FutureBuilder<List<Surah>>(
                    future: controller.getAllSurah(),
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
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            Surah surah = snapshot.data![index];
                            return ListTile(
                              onTap: () {
                                Get.toNamed(Routes.DETAIL_SURAH, arguments: {
                                  "name": surah.name!.transliteration!.id,
                                  "number": surah.number
                                });
                              },
                              leading: Obx(() {
                                return Container(
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(controller
                                                  .isDarkMode.isTrue
                                              ? "assets/images/list_dark.png"
                                              : "assets/images/list2.png"))),
                                  child: Center(
                                    child: Text(surah.number.toString()),
                                  ),
                                );
                              }),
                              title: Text("${surah.name?.transliteration?.id}"),
                              subtitle: Text(
                                  "${surah.numberOfVerses} Ayat | ${surah.revelation?.id}"),
                              trailing: Text("${surah.name?.short}"),
                            );
                          });
                    },
                  ),
                  //JUZ
                  FutureBuilder<List<juz.Juz>>(
                    future: controller.getAllJuz(),
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
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          juz.Juz detailJuz = snapshot.data![index];

                          String nameStart =
                              detailJuz.juzStartInfo?.split(" - ").first ?? "";
                          String nameEnd =
                              detailJuz.juzEndInfo?.split(" - ").first ?? "";

                          List<Surah> rawAllSurahInJuz = [];
                          List<Surah> allSurahInJuz = [];
                          for (Surah item in controller.getSurah) {
                            rawAllSurahInJuz.add(item);
                            if (item.name!.transliteration!.id == nameEnd) {
                              break;
                            }
                          }

                          for (Surah item
                              in rawAllSurahInJuz.reversed.toList()) {
                            allSurahInJuz.add(item);
                            if (item.name!.transliteration!.id == nameStart) {
                              break;
                            }
                          }

                          return Obx(() {
                            return ListTile(
                              onTap: () {
                                Get.toNamed(Routes.DETAIL_JUZ, arguments: {
                                  "juz": detailJuz,
                                  "surah": allSurahInJuz.reversed.toList(),
                                });
                              },
                              leading: Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            controller.isDarkMode.isTrue
                                                ? "assets/images/list_dark.png"
                                                : "assets/images/list2.png"))),
                                child: Center(
                                  child: Text("${index + 1}"),
                                ),
                              ),
                              title: Text("Juz ${index + 1}"),
                              isThreeLine: true,
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Mulai dari ${detailJuz.juzStartInfo}",
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                  Text(
                                    "Sampai ${detailJuz.juzEndInfo}",
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            );
                          });
                        },
                      );
                    },
                  ),
                  //BOOKMARK
                  GetBuilder<HomeController>(
                    builder: (c) {
                      return FutureBuilder<List<Map<String, dynamic>>>(
                        future: controller.getBookmark(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (snapshot.data?.length == 0) {
                            return const Center(
                              child: Text("Belum ada data"),
                            );
                          }

                          return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              Map<String, dynamic> data = snapshot.data![index];

                              print(data['surah']);
                              return Obx(() {
                                return ListTile(
                                  onTap: () {
                                    Get.toNamed(Routes.DETAIL_SURAH,
                                        arguments: {
                                          "name": data['surah']
                                              .toString()
                                              .replaceAll("+", "'"),
                                          "number": data['number_surah'],
                                          "bookmark": data,
                                        });
                                  },
                                  leading: Container(
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(controller
                                                    .isDarkMode.isTrue
                                                ? "assets/images/list_dark.png"
                                                : "assets/images/list2.png"))),
                                    child: Center(
                                      child: Text("${index + 1}"),
                                    ),
                                  ),
                                  title: Text(data["surah"]
                                      .toString()
                                      .replaceAll("+", "'")),
                                  subtitle: Text(
                                      "Ayat ${data["ayat"]} | via : ${data["via"]}"),
                                  trailing: IconButton(
                                    onPressed: () {
                                      c.deleteBookmark(data['id'].toString());
                                    },
                                    icon: const Icon(Icons.delete),
                                  ),
                                );
                              });
                            },
                          );
                        },
                      );
                    },
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}

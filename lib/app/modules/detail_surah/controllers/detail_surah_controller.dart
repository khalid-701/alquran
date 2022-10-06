import 'dart:convert';

import 'package:alquran/app/data/models/detail_surah/detail_surah.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';

class DetailSurahController extends GetxController {
  final player = AudioPlayer();

  Future<DetailSurah> detailSurah(String id) async {
    Uri url = Uri.parse("https://api.quran.gading.dev/surah/$id");
    var res = await http.get(url);
    Map<String, dynamic> data =
        (json.decode(res.body) as Map<String, dynamic>)["data"];

    return DetailSurah.fromJson(data);
  }

  void playAudio(String url) async {
    if (url != null) {
      try {
        await player.setUrl(url);
        await player.play();
      } on PlayerException catch (e) {
        Get.defaultDialog(
            title: "Terjadi Kesalahan.", middleText: "${e.message}");
      } on PlayerInterruptedException catch (e) {
        Get.defaultDialog(
            title: "Terjadi Kesalahan.", middleText: "${e.message}");
      } catch (e) {
        // Fallback for all other errors
        Get.defaultDialog(
            title: "Terjadi Kesalahan.", middleText: "${e}");
      }
      player.playbackEventStream.listen((event) {},
          onError: (Object e, StackTrace st) {
        if (e is PlayerException) {
          Get.defaultDialog(
              title: "Terjadi Kesalahan.", middleText: "${e.message}");
        } else {
        }
      });
    } else {
      Get.defaultDialog(
          title: "Terjadi Kesalahan.", middleText: "URL Audio tidak ada.");
    }
  }

  @override
  void onClose() {
    player.stop();
    player.dispose();
    super.onClose();
  }
}

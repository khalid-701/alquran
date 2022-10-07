import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

import '../../../data/models/juz/juz.dart';

class DetailJuzController extends GetxController {
  int index = 0;
  final player = AudioPlayer();

  Verses? lastVerse;

  void playAudio(Verses ayat) async {
    if (ayat.audio?.primary != null) {
      try {
     
        lastVerse ??= ayat;
        lastVerse!.kondisiAudio = "stop";
        lastVerse = ayat;
        lastVerse!.kondisiAudio = "stop";
        update();


        await player.stop();
        await player.setUrl(ayat.audio!.primary!);
        ayat.kondisiAudio ="playing";
        update();
        await player.play();
        ayat.kondisiAudio ="stop";
        update();
        await player.stop();


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
  void pauseAudio(Verses ayat) async {
    try {
      await player.pause();
      ayat.kondisiAudio  ="pause";
      update();
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
  }
  void resumeAudio(Verses ayat) async {
    try {

      ayat.kondisiAudio  ="playing";
      update();
      await player.play();
      ayat.kondisiAudio  ="stop";
      update();
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
  }
  void stopAudio(Verses ayat) async {
    try {

      ayat.kondisiAudio ="stop";
      update();
      await player.stop();

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
  }

  @override
  void onClose() {
    player.stop();
    player.dispose();
    super.onClose();
  }

}

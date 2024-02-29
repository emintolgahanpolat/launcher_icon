import 'dart:io';
import 'dart:typed_data';

import 'package:image/image.dart';
import 'package:launcher_icon/logger.dart';
import 'package:launcher_icon/src/icon_template.dart';
import 'package:launcher_icon/src/image+.dart';
import 'package:launcher_icon/src/launcher_interface.dart';

class LauncherAndroid implements LauncherInterface {
  final List<IconTemplate> adaptiveForegroundIcons = <IconTemplate>[
    IconTemplate(name: 'drawable-mdpi', size: 108),
    IconTemplate(name: 'drawable-hdpi', size: 162),
    IconTemplate(name: 'drawable-xhdpi', size: 216),
    IconTemplate(name: 'drawable-xxhdpi', size: 324),
    IconTemplate(name: 'drawable-xxxhdpi', size: 432),
  ];

  List<IconTemplate> androidIcons = <IconTemplate>[
    IconTemplate(name: 'mipmap-mdpi', size: 48),
    IconTemplate(name: 'mipmap-hdpi', size: 72),
    IconTemplate(name: 'mipmap-xhdpi', size: 96),
    IconTemplate(name: 'mipmap-xxhdpi', size: 144),
    IconTemplate(name: 'mipmap-xxxhdpi', size: 192),
  ];

  @override
  void createIconsFromConfig(Map<String, dynamic> config,
      {String? flavor}) async {
    Log.i("• Android icons created.", level: 1);
    Image? image =
        decodeImage(File(config["android_foreground_path"]).readAsBytesSync());

    if (image == null) {
      return;
    }
    Image? imagefg = image.clone();
    String assetsName = config["android_assets_name"] ?? "ic_launcher";
    if (flavor != null && flavor.split("-").length > 1) {
      assetsName = 'ic_launcher-' + flavor.split("-").last;
      flavor = flavor.split("-").first;
    }

    String? iconPath = config["android_foreground_path"];
    if (iconPath == null) {
      Log.e("android_image_path is not defined in the config file.", level: 2);
    }

    String? iconBackground = config["android_background"];
    Uint8List? iconBackgroundByte;
    if (iconBackground == null) {
      Log.e("android_background is not defined in the config file.", level: 2);
    } else if (iconBackground.startsWith("#")) {
      iconBackgroundByte = creteImage(iconBackground);
      final pixel = image.getPixel(0, 0);
      do {
        pixel.set(alphaBlend(pixel, hexToColor(iconBackground)));
      } while (pixel.moveNext());
    } else {
      iconBackgroundByte = await File(iconBackground).readAsBytes();
      var bg = decodeImage(iconBackgroundByte);
      if (bg == null) {
        throw Exception("Background image could not be decoded.");
      }

      final pixel = image.getPixel(0, 0);
      do {
        pixel.set(alphaBlend(pixel, bg.getPixel(pixel.x, pixel.y)));
      } while (pixel.moveNext());
    }

    androidIcons.forEach((element) {
      if (config["android_circle"] == true) {
        saveIcon(
            element, copyCropCircle(image, radius: 512), assetsName + "-circle",
            flavor: flavor);
      }
      if (config["android_rounded"] == true) {
        saveIcon(
            element, cornerRadius(image, radius: 86), assetsName + "-rounded",
            flavor: flavor);
      }
      if (config["android_foreground"] == true) {
        saveIcon(element, imagefg, assetsName + "-foreground", flavor: flavor);
      }
      saveIcon(element, image, assetsName, flavor: flavor);
    });
    adaptiveForegroundIcons.forEach((element) {
      if (config["android_adaptive_circle"] == true) {
        saveIcon(
            element, copyCropCircle(image, radius: 512), assetsName + "-circle",
            flavor: flavor);
      }
      if (config["android_adaptive_rounded"] == true) {
        saveIcon(
            element, cornerRadius(image, radius: 86), assetsName + "-rounded",
            flavor: flavor);
      }
      if (config["android_adaptive_foreground"] == true) {
        saveIcon(element, imagefg, assetsName + "-foreground", flavor: flavor);
      }
      saveIcon(element, image, assetsName, flavor: flavor);
    });
  }

  Future<void> saveIcon(IconTemplate template, Image image, String newIconName,
      {String? flavor}) async {
    final String newIconFolder = androidResFolder(flavor) + template.name + "/";
    final Image newFile = createResizedImage(template, image);
    File(newIconFolder + newIconName + '.webp')
        .create(recursive: true)
        .then((File file) {
      file.writeAsBytesSync(encodePng(newFile));
    });
  }
}

String androidResFolder(String? flavor) =>
    "android/app/src/${flavor ?? 'main'}/res/";

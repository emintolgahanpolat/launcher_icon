import 'dart:io';
import 'dart:typed_data';

import 'package:image/image.dart';
import 'package:launcher_icon/logger.dart';
import 'package:launcher_icon/src/icon_template.dart';
import 'package:launcher_icon/src/image+.dart';
import 'package:launcher_icon/src/launcher_interface.dart';

const String iosAssetFolder = 'ios/Runner/Assets.xcassets/';

class LauncherIOS implements LauncherInterface {
  List<IconTemplate> iosIcons = <IconTemplate>[
    IconTemplate(name: '-20x20@1x', size: 20),
    IconTemplate(name: '-20x20@2x', size: 40),
    IconTemplate(name: '-20x20@3x', size: 60),
    IconTemplate(name: '-29x29@1x', size: 29),
    IconTemplate(name: '-29x29@2x', size: 58),
    IconTemplate(name: '-29x29@3x', size: 87),
    IconTemplate(name: '-40x40@1x', size: 40),
    IconTemplate(name: '-40x40@2x', size: 80),
    IconTemplate(name: '-40x40@3x', size: 120),
    IconTemplate(name: '-50x50@1x', size: 50),
    IconTemplate(name: '-50x50@2x', size: 100),
    IconTemplate(name: '-57x57@1x', size: 57),
    IconTemplate(name: '-57x57@2x', size: 114),
    IconTemplate(name: '-60x60@2x', size: 120),
    IconTemplate(name: '-60x60@3x', size: 180),
    IconTemplate(name: '-72x72@1x', size: 72),
    IconTemplate(name: '-72x72@2x', size: 144),
    IconTemplate(name: '-76x76@1x', size: 76),
    IconTemplate(name: '-76x76@2x', size: 152),
    IconTemplate(name: '-83.5x83.5@2x', size: 167),
    IconTemplate(name: '-1024x1024@1x', size: 1024),
  ];

  @override
  void createIconsFromConfig(Map<String, dynamic> config,
      {String? flavor}) async {
    Log.i("• iOS icons created.", level: 1);
    Image? image =
        decodeImage(File(config["ios_foreground"]).readAsBytesSync());
    if (image == null) {
      return;
    }

    String assetsName = config["ios_assets_name"] ?? "AppIcon";
    if (config["ios_assets_name"] == null && flavor != null) {
      assetsName = 'AppIcon-' + flavor;
    }

    String? iconPath = config["ios_foreground"];
    if (iconPath == null) {
      Log.e("ios_image_path is not defined in the config file.", level: 2);
    }

    String? iconBackground = config["ios_background"];
    Uint8List? iconBackgroundByte;
    if (iconBackground == null) {
      Log.e("ios_background is not defined in the config file.", level: 2);
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

    if (image.hasAlpha) {
      Log.w(
        '\nWARNING: Icons with alpha channel are not allowed in the Apple App Store.\nSet "remove_alpha_ios: true" to remove it.\n',
      );
    }
    // File("$assetsName.png").writeAsBytesSync(encodePng(image));
    iosIcons.forEach((element) {
      saveIcon(element, image, assetsName);
    });
    //Log.i("$assetsName $iconPath $iconBackground", level: 1);
    // Log.i(config.toString(), level: 2);
  }

  Future<void> saveIcon(
      IconTemplate template, Image image, String newIconName) async {
    final String newIconFolder = iosAssetFolder + newIconName + '.appiconset/';
    final Image newFile = createResizedImage(template, image);
    File(newIconFolder + newIconName + template.name + '.png')
        .create(recursive: true)
        .then((File file) {
      file.writeAsBytesSync(encodePng(newFile));
    });
  }
}

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:image/image.dart';
import 'package:launcher_icon/logger.dart';
import 'package:launcher_icon/src/icon_template.dart';
import 'package:launcher_icon/src/image+.dart';
import 'package:launcher_icon/src/launcher_interface.dart';

const String iosAssetFolder = 'ios/Runner/Assets.xcassets/';
String intToString(double number) {
  if (number == number.toInt().toDouble()) {
    return number.toInt().toString();
  } else {
    return number.toString();
  }
}

class AppleIconTemplate extends IconTemplate {
  String idiom;
  int scale;
  String? role;
  String? subtype;
  AppleIconTemplate(
      {required int size,
      required this.idiom,
      required this.scale,
      this.role,
      this.subtype})
      : super(
            name:
                "${intToString(size / scale)}x${intToString(size / scale)}@${scale}x",
            size: size);

  Map<String, String> toJson() {
    var mSize = intToString(size / scale);
    return <String, String>{
      'size': "${mSize}x${mSize}",
      'idiom': idiom,
      'filename': "${name}.png",
      'scale': "${scale}x",
      if (role != null) 'role': role!,
      if (subtype != null) 'subtype': subtype!,
    };
  }
}

class LauncherIOS implements LauncherInterface {
  List<AppleIconTemplate> iosIcons = <AppleIconTemplate>[
    AppleIconTemplate(idiom: "iphone", scale: 3, size: 180),
    AppleIconTemplate(idiom: "iphone", scale: 2, size: 80),
    AppleIconTemplate(idiom: "iphone", scale: 3, size: 120),
    AppleIconTemplate(idiom: "iphone", scale: 2, size: 120),
    AppleIconTemplate(idiom: "iphone", scale: 1, size: 57),
    AppleIconTemplate(idiom: "iphone", scale: 2, size: 58),
    AppleIconTemplate(idiom: "iphone", scale: 1, size: 29),
    AppleIconTemplate(idiom: "iphone", scale: 3, size: 87),
    AppleIconTemplate(idiom: "iphone", scale: 2, size: 114),
    AppleIconTemplate(idiom: "iphone", scale: 2, size: 40),
    AppleIconTemplate(idiom: "iphone", scale: 3, size: 60),
    AppleIconTemplate(idiom: "ios-marketing", scale: 1, size: 1024),
    AppleIconTemplate(idiom: "ipad", scale: 2, size: 80),
    AppleIconTemplate(idiom: "ipad", scale: 1, size: 72),
    AppleIconTemplate(idiom: "ipad", scale: 2, size: 152),
    AppleIconTemplate(idiom: "ipad", scale: 2, size: 100),
    AppleIconTemplate(idiom: "ipad", scale: 2, size: 58),
    AppleIconTemplate(idiom: "ipad", scale: 1, size: 76),
    AppleIconTemplate(idiom: "ipad", scale: 1, size: 29),
    AppleIconTemplate(idiom: "ipad", scale: 1, size: 50),
    AppleIconTemplate(idiom: "ipad", scale: 2, size: 144),
    AppleIconTemplate(idiom: "ipad", scale: 1, size: 40),
    AppleIconTemplate(idiom: "ipad", scale: 2, size: 167),
    AppleIconTemplate(idiom: "ipad", scale: 1, size: 20),
    AppleIconTemplate(idiom: "ipad", scale: 2, size: 40),
    AppleIconTemplate(
        idiom: "watch",
        scale: 2,
        size: 172,
        role: "quickLook",
        subtype: "38mm"),
    AppleIconTemplate(
        idiom: "watch",
        scale: 2,
        size: 80,
        role: "appLauncher",
        subtype: "38mm"),
    AppleIconTemplate(
        idiom: "watch",
        scale: 2,
        size: 88,
        role: "appLauncher",
        subtype: "40mm"),
    AppleIconTemplate(
        idiom: "watch",
        scale: 2,
        size: 92,
        role: "appLauncher",
        subtype: "41mm"),
    AppleIconTemplate(
        idiom: "watch",
        scale: 2,
        size: 100,
        role: "appLauncher",
        subtype: "44mm"),
    AppleIconTemplate(
        idiom: "watch",
        scale: 2,
        size: 196,
        role: "quickLook",
        subtype: "42mm"),
    AppleIconTemplate(
        idiom: "watch",
        scale: 2,
        size: 216,
        role: "quickLook",
        subtype: "44mm"),
    AppleIconTemplate(
        idiom: "watch",
        scale: 2,
        size: 48,
        role: "notificationCenter",
        subtype: "38mm"),
    AppleIconTemplate(
        idiom: "watch",
        scale: 2,
        size: 55,
        role: "notificationCenter",
        subtype: "42mm"),
    AppleIconTemplate(
        idiom: "watch",
        scale: 2,
        size: 66,
        role: "notificationCenter",
        subtype: "45mm"),
    AppleIconTemplate(idiom: "watch-marketing", scale: 1, size: 1024),
    AppleIconTemplate(idiom: "mac", scale: 1, size: 128),
    AppleIconTemplate(idiom: "mac", scale: 1, size: 256),
    AppleIconTemplate(idiom: "mac", scale: 2, size: 256),
    AppleIconTemplate(idiom: "mac", scale: 1, size: 32),
    AppleIconTemplate(idiom: "mac", scale: 1, size: 512),
    AppleIconTemplate(idiom: "mac", scale: 1, size: 16),
    AppleIconTemplate(idiom: "mac", scale: 2, size: 32),
    AppleIconTemplate(idiom: "mac", scale: 2, size: 64),
    AppleIconTemplate(idiom: "mac", scale: 2, size: 512),
    AppleIconTemplate(
        idiom: "watch",
        scale: 2,
        size: 234,
        role: "quickLook",
        subtype: "45mm"),
    AppleIconTemplate(
        idiom: "watch",
        scale: 2,
        size: 258,
        role: "quickLook",
        subtype: "49mm"),
    AppleIconTemplate(
        idiom: "watch",
        scale: 2,
        size: 102,
        role: "appLauncher",
        subtype: "45mm"),
    AppleIconTemplate(
        idiom: "watch",
        scale: 2,
        size: 108,
        role: "appLauncher",
        subtype: "49mm"),
    AppleIconTemplate(
      idiom: "watch",
      scale: 2,
      size: 58,
      role: "companionSettings",
    ),
    AppleIconTemplate(
      idiom: "watch",
      scale: 3,
      size: 87,
      role: "companionSettings",
    ),
  ];

  @override
  void createIconsFromConfig(Map<String, dynamic> config,
      {String? flavor}) async {
    Log.i("• iOS icons created.", level: 1);
    Image? image =
        decodeImage(File(config["ios_foreground_path"]).readAsBytesSync());

    if (image == null) {
      return;
    }
    // Image? imagefg = image.clone();

    String assetsName = config["ios_assets_name"] ?? "AppIcon";
    if (config["ios_assets_name"] == null && flavor != null) {
      assetsName = 'AppIcon-' + flavor;
    }

    String? iconPath = config["ios_foreground_path"];
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
    if (config["ios_launcher"] == true) {
      Log.i("• iOS launcher icon created.", level: 1);
      String launcherName = config["ios_launcher_name"] ?? "LaunchImage";
      if (config["ios_launcher_name"] == null && flavor != null) {
        launcherName = 'LaunchImage-' + flavor;
      }
      saveIcon(IconTemplate(size: 1024, name: ""), image, launcherName);
    }

    if (image.hasAlpha) {
      Log.w(
        '\nWARNING: Icons with alpha channel are not allowed in the Apple App Store.\nSet"remove_alpha_ios: true" to remove it.\n',
      );
    }
    // File("$assetsName.png").writeAsBytesSync(encodePng(image));
    iosIcons.forEach((element) {
      saveIcon(element, image, assetsName);
    });
    //Log.i("$assetsName $iconPath $iconBackground", level: 1);
    // Log.i(config.toString(), level: 2);
    modifyContentsFile(assetsName, iosIcons);
  }

  Future<void> saveIcon(
      IconTemplate template, Image image, String assetsName) async {
    final String newIconFolder = iosAssetFolder + assetsName + '.appiconset/';
    final Image newFile = createResizedImage(template, image);
    File(newIconFolder + template.name + '.png')
        .create(recursive: true)
        .then((File file) {
      file.writeAsBytesSync(encodePng(newFile));
    });
  }

  void modifyContentsFile(String assetsName, List<AppleIconTemplate> iosIcons) {
    final String newIconFolder =
        iosAssetFolder + assetsName + '.appiconset/Contents.json';
    File(newIconFolder).create(recursive: true).then((File contentsJsonFile) {
      final String contentsFileContent = generateContentsFileAsString(iosIcons);
      contentsJsonFile.writeAsString(contentsFileContent);
    });
  }

  String generateContentsFileAsString(List<AppleIconTemplate> iosIcons) {
    final Map<String, dynamic> contentJson = <String, dynamic>{
      'images': iosIcons.map((e) => e.toJson()).toList(),
      'info': {
        'version': 1,
        'author': "xcode",
      },
    };
    return json.encode(contentJson);
  }
}

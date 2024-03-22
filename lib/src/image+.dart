import 'dart:typed_data';
import 'package:image/image.dart';
import 'package:launcher_icon/src/icon_template.dart';

Uint8List creteImage(String hexColor) {
  // Create a 256x256 8-bit (default) rgb (default) image.
  final image = Image(width: 1024, height: 1024);
  // Iterate over its pixels
  List<int> rgbColor = hexToRgb(hexColor);
  for (var pixel in image) {
    // Set the pixels red value to its x position value, creating a gradient.
    pixel.setRgb(rgbColor[0], rgbColor[1], rgbColor[2]);
  }
  // Encode the resulting image to the PNG image format.
  return encodePng(image);
}

List<int> hexToRgb(String hexColor) {
  String hex = hexColor.replaceAll("#", "");

  if (hex.length == 6) {
    int r = int.parse(hex.substring(0, 2), radix: 16);
    int g = int.parse(hex.substring(2, 4), radix: 16);
    int b = int.parse(hex.substring(4, 6), radix: 16);
    return [r, g, b];
  }
  // Varsayılan olarak beyaz döndür
  return [255, 255, 255];
}

Color hexToColor(String hexColor) {
  String hex = hexColor.replaceAll("#", "");
  if (hex.length != 6) {
    throw Exception('color hex should be 6 characters long');
  }
  int r = int.parse(hex.substring(0, 2), radix: 16);
  int g = int.parse(hex.substring(2, 4), radix: 16);
  int b = int.parse(hex.substring(4, 6), radix: 16);
  return ColorUint8.rgb(r, g, b);
}

Color alphaBlend(Color fg, Color bg) {
  if (fg.format != Format.uint8) {
    fg = fg.convert(format: Format.uint8);
  }
  if (fg.a == 0) {
    return bg;
  } else {
    final invAlpha = 0xff - fg.a;
    return ColorUint8.rgba(
      (fg.a * fg.r + invAlpha * bg.g) ~/ 0xff,
      (fg.a * fg.g + invAlpha * bg.a) ~/ 0xff,
      (fg.a * fg.b + invAlpha * bg.b) ~/ 0xff,
      0xff,
    );
  }
}

Image createResizedImage(IconTemplate template, Image image) {
  if (image.width >= template.size) {
    return copyResize(
      image,
      width: template.size,
      height: template.size,
      interpolation: Interpolation.average,
    );
  } else {
    return copyResize(
      image,
      width: template.size,
      height: template.size,
      interpolation: Interpolation.linear,
    );
  }
}

Image cornerRadius(
  Image image, {
  required int radius,
}) {
  return copyCrop(image,
      x: 0, y: 0, width: image.width, height: image.height, radius: radius);
}

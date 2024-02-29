import 'dart:io';

import 'package:launcher_icon/constaint.dart';
import 'package:launcher_icon/logger.dart';
import 'package:launcher_icon/src/android.dart';
import 'package:launcher_icon/src/ios.dart';
import 'package:launcher_icon/string+.dart';
import 'package:launcher_icon/version.dart';
import 'package:yaml/yaml.dart';
import 'package:path/path.dart' as path;

const String _configFileName = 'launcher_icon';
const String flavorConfigFilePattern = r'^launcher_icon-(.*).yaml$';
void main(List<String> arguments) {
  print(introMessage(packageVersion));
  List<String> flavors = _getFlavors();

  if (flavors.isNotEmpty) {
    flavors.forEach((flavor) {
      Log.i('Flavor : $flavor');
      _createIconsFromConfig(_getConfig(flavor: flavor), flavor: flavor);
    });
  } else {
    var config = _getConfig();
    if (config.isNotEmpty) {
      Log.i('Creating icons for default flavor.');
      _createIconsFromConfig(_getConfig());
    }
  }
  return;
}

Future<void> _createIconsFromConfig(Map<String, dynamic> config,
    {String? flavor}) {
  if (config["android"] == true) {
    LauncherAndroid().createIconsFromConfig(config, flavor: flavor);
  }
  if (config["ios"] == true) {
    LauncherIOS().createIconsFromConfig(config, flavor: flavor);
  }
  return Future.value();
}

/// Get all flavors
List<String> _getFlavors() {
  final List<String> flavors = [];
  for (var item in Directory('.').listSync()) {
    if (item is File) {
      final name = path.basename(item.path);
      final match = RegExp(flavorConfigFilePattern).firstMatch(name);
      if (match != null) {
        flavors.add(match.group(1)!);
      }
    }
  }
  return flavors;
}

/// Get config
Map<String, dynamic> _getConfig({String? flavor}) {
  String path = 'pubspec.yaml';
  if (flavor.isNotNullOrEmpty) {
    path = "$_configFileName-${flavor}.yaml";
  }
  final yamlMap = loadYaml(File(path).readAsStringSync()) as Map;
  return _yamlToMap(yamlMap["launcher_icon"] as YamlMap);
}

/// Convert yaml to map
Map<String, dynamic> _yamlToMap(YamlMap yamlMap) {
  final map = <String, dynamic>{};
  for (final entry in yamlMap.entries) {
    if (entry.value is YamlList) {
      final list = <String>[];
      for (final value in entry.value as YamlList) {
        if (value is String) {
          list.add(value);
        }
      }
      map[entry.key as String] = list;
    } else if (entry.value is YamlMap) {
      map[entry.key as String] = _yamlToMap(entry.value as YamlMap);
    } else {
      map[entry.key as String] = entry.value;
    }
  }
  return map;
}
/*
create folder
  new Directory('android/app/src')
      .create(recursive: true)
      .then((Directory directory) {
    print(directory.path);
  });
*/
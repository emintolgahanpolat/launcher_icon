# 📖 Guide

1. Setup the config file

Add your Launcher Icon configuration yo your pubspec.yaml or create anew config file called `launcher_icon-{flavor}.yaml`. An example is shown below.

```yaml
dev_dependencies:
  launcher_icon: "^0.0.1"

launcher_icon:
  android: true #enable android
  android_rounded: true
  android_circle: true
  android_foreground: true
  android_adaptive_rounded: true
  android_adaptive_circle: true
  android_adaptive_foreground: true
  android_assets_name: "ic_launcher_noel" # build file name
  android_foreground_path: "assets/logo_fg.png" # 1024x1024 png
  android_background: "#FF0000" # hex code or 1024x1024 png
  ios: true #enable ios
  ios_launcher: true #enable ios launcher
  ios_launcher_name: "LauncherName"
  ios_assets_name: "AppIcon-noel" #build file name
  ios_foreground_path: "assets/logo_fg.png" # 1024x1024 png
  ios_background: "#FF0000" # hex code or 1024x1024 png
```

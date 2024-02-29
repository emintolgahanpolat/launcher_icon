class Log {
  // This class is not meant to be instantiated or extended; this constructor
  Log._();

  //Error
  static void e(String msg, {String? tag, int? level}) {
    _printLog("\x1B[31m", msg, tag: tag, level: level);
  }

  //Warning
  static void w(String msg, {String? tag, int? level}) {
    _printLog("\x1B[33m", msg, tag: tag, level: level);
  }

  //Info
  static void i(String msg, {String? tag, int? level}) {
    _printLog("\x1B[36m", msg, tag: tag, level: level);
  }

  //Debug
  static void d(String msg, {String? tag, int? level}) {
    _printLog("\x1B[32m", msg, tag: tag, level: level);
  }

  //Verbose
  static void v(String msg, {String? tag, int? level}) {
    _printLog("\x1B[35m", msg, tag: tag, level: level);
  }

  //What a Terrible Failure
  static void wtf(String msg, {String? tag, int? level}) {
    _printLog("\x1B[37m", msg, tag: tag, level: level);
  }

  static void _printLog(String color, String msg,
      {String? tag, int? level}) async {
    print("${color}${_getLevel(level: level)}${tag ?? ""} $msg");
  }

  static String _getLevel({int? level}) {
    if (level == null) {
      return "";
    } else {
      return List.generate(level, (index) => "  ").join("");
    }
  }
}

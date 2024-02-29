extension StringExtension on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
  bool get isNotNullOrEmpty => this != null && this!.isNotEmpty;
  bool get isNotNull => this != null;
  bool get isNull => this == null;
  String get toCamelCase {
    if (this.isNullOrEmpty) return '';
    return this!
        .split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  String get toTitleCase {
    if (this.isNullOrEmpty) return '';
    return this!
        .split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  String get toSnakeCase {
    if (this.isNullOrEmpty) return '';
    return this!.split(' ').map((word) => word.toLowerCase()).join('_');
  }

  String get toKebabCase {
    if (this.isNullOrEmpty) return '';
    return this!.split(' ').map((word) => word.toLowerCase()).join('-');
  }

  String get toConstantCase {
    if (this.isNullOrEmpty) return '';
    return this!.split(' ').map((word) => word.toUpperCase()).join('_');
  }

  String get toPascalCase {
    if (this.isNullOrEmpty) return '';
    return this!
        .split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join('');
  }

  String get toDotCase {
    if (this.isNullOrEmpty) return '';
    return this!.split(' ').map((word) => word.toLowerCase()).join('.');
  }

  String get toPathCase {
    if (this.isNullOrEmpty) return '';
    return this!.split(' ').map((word) => word.toLowerCase()).join('/');
  }

  String get toSentenceCase {
    if (this.isNullOrEmpty) return '';
    return this!
            .split(' ')
            .map((word) => word[0].toUpperCase() + word.substring(1))
            .join(' ') +
        '.';
  }

  String get toCapitalCase {
    if (this.isNullOrEmpty) return '';
    return this!
        .split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  String get toHeaderCase {
    if (this.isNullOrEmpty) return '';
    return this!
        .split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join('-');
  }

  String get toParamCase {
    if (this.isNullOrEmpty) return '';
    return this!.split(' ').map((word) => word.toLowerCase()).join('-');
  }

  String get toNonDelimiterCase {
    if (this.isNullOrEmpty) return '';
    return this!.replaceAll(' ', '');
  }

  String get toNonDelimiterLowerCase {
    if (this.isNullOrEmpty) return '';
    return this!.replaceAll(' ', '').toLowerCase();
  }

  String get toNonDelimiterUpperCase {
    if (this.isNullOrEmpty) return '';
    return this!.replaceAll(' ', '').toUpperCase();
  }

  String get toNonDelimiterCamelCase {
    if (this.isNullOrEmpty) return '';
    return this!
        .replaceAll(' ', '')
        .split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  String get toNonDelimiterTitleCase {
    if (this.isNullOrEmpty) return '';
    return this!
        .replaceAll(' ', '')
        .split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  String get toNonDelimiterSnakeCase {
    if (this.isNullOrEmpty) return '';
    return this!.replaceAll(' ', '_').toLowerCase();
  }

  String get toNonDelimiterKebabCase {
    if (this.isNullOrEmpty) return '';
    return this!.replaceAll(' ', '-').toLowerCase();
  }

  String get toNonDelimiterConstantCase {
    if (this.isNullOrEmpty) return '';
    return this!.replaceAll(' ', '_').toUpperCase();
  }

  String get toNonDelimiterPascalCase {
    if (this.isNullOrEmpty) return '';
    return this!
        .replaceAll(' ', '')
        .split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join('');
  }

  String get toNonDelimiterDotCase {
    if (this.isNullOrEmpty) return '';
    return this!.replaceAll(' ', '.').toLowerCase();
  }

  String get toNonDelimiterPathCase {
    if (this.isNullOrEmpty) return '';
    return this!.replaceAll(' ', '/').toLowerCase();
  }

  String get toNonDelimiterSentenceCase {
    if (this.isNullOrEmpty) return '';
    return this!
            .replaceAll(' ', '')
            .split(' ')
            .map((word) => word[0].toUpperCase() + word.substring(1))
            .join(' ') +
        '.';
  }

  String get toNonDelimiterCapitalCase {
    if (this.isNullOrEmpty) return '';
    return this!
        .replaceAll(' ', '')
        .split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  String get toNonDelimiterHeaderCase {
    if (this.isNullOrEmpty) return '';
    return this!
        .replaceAll(' ', '')
        .split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join('-');
  }

  String get toNonDelimiterParamCase {
    if (this.isNullOrEmpty) return '';
    return this!.replaceAll(' ', '-').toLowerCase();
  }
}

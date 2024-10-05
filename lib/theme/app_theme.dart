import "package:flutter/material.dart";

class AppTheme {
  final TextTheme textTheme;

  const AppTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff01677d),
      surfaceTint: Color(0xff01677d),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffb3ebff),
      onPrimaryContainer: Color(0xff001f27),
      secondary: Color(0xff4b626a),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffcee6f0),
      onSecondaryContainer: Color(0xff061e25),
      tertiary: Color(0xff595c7e),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffdfe0ff),
      onTertiaryContainer: Color(0xff151937),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      surface: Color(0xfff5fafd),
      onSurface: Color(0xff171c1e),
      onSurfaceVariant: Color(0xff40484b),
      outline: Color(0xff70787c),
      outlineVariant: Color(0xffbfc8cc),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2c3133),
      inversePrimary: Color(0xff86d1ea),
      primaryFixed: Color(0xffb3ebff),
      onPrimaryFixed: Color(0xff001f27),
      primaryFixedDim: Color(0xff86d1ea),
      onPrimaryFixedVariant: Color(0xff004e5f),
      secondaryFixed: Color(0xffcee6f0),
      onSecondaryFixed: Color(0xff061e25),
      secondaryFixedDim: Color(0xffb3cad3),
      onSecondaryFixedVariant: Color(0xff344a52),
      tertiaryFixed: Color(0xffdfe0ff),
      onTertiaryFixed: Color(0xff151937),
      tertiaryFixedDim: Color(0xffc1c4eb),
      onTertiaryFixedVariant: Color(0xff414465),
      surfaceDim: Color(0xffd6dbdd),
      surfaceBright: Color(0xfff5fafd),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff4f7),
      surfaceContainer: Color(0xffeaeff1),
      surfaceContainerHigh: Color(0xffe4e9eb),
      surfaceContainerHighest: Color(0xffdee3e6),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff004a5a),
      surfaceTint: Color(0xff01677d),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff2c7e94),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff30464e),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff617880),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff3d4061),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff6f7295),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff8c0009),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffda342e),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff5fafd),
      onSurface: Color(0xff171c1e),
      onSurfaceVariant: Color(0xff3c4447),
      outline: Color(0xff586064),
      outlineVariant: Color(0xff737c80),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2c3133),
      inversePrimary: Color(0xff86d1ea),
      primaryFixed: Color(0xff2c7e94),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff00657a),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff617880),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff495f67),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff6f7295),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff565a7b),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd6dbdd),
      surfaceBright: Color(0xfff5fafd),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff4f7),
      surfaceContainer: Color(0xffeaeff1),
      surfaceContainerHigh: Color(0xffe4e9eb),
      surfaceContainerHighest: Color(0xffdee3e6),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff002630),
      surfaceTint: Color(0xff01677d),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff004a5a),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff0e252c),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff30464e),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff1c203e),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff3d4061),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff4e0002),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff8c0009),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff5fafd),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff1d2528),
      outline: Color(0xff3c4447),
      outlineVariant: Color(0xff3c4447),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2c3133),
      inversePrimary: Color(0xffcef2ff),
      primaryFixed: Color(0xff004a5a),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff00323d),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff30464e),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff193037),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff3d4061),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff272a49),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd6dbdd),
      surfaceBright: Color(0xfff5fafd),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff4f7),
      surfaceContainer: Color(0xffeaeff1),
      surfaceContainerHigh: Color(0xffe4e9eb),
      surfaceContainerHighest: Color(0xffdee3e6),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff86d1ea),
      surfaceTint: Color(0xff86d1ea),
      onPrimary: Color(0xff003642),
      primaryContainer: Color(0xff004e5f),
      onPrimaryContainer: Color(0xffb3ebff),
      secondary: Color(0xffb3cad3),
      onSecondary: Color(0xff1d343b),
      secondaryContainer: Color(0xff344a52),
      onSecondaryContainer: Color(0xffcee6f0),
      tertiary: Color(0xffc1c4eb),
      onTertiary: Color(0xff2a2e4d),
      tertiaryContainer: Color(0xff414465),
      onTertiaryContainer: Color(0xffdfe0ff),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff0f1416),
      onSurface: Color(0xffdee3e6),
      onSurfaceVariant: Color(0xffbfc8cc),
      outline: Color(0xff899296),
      outlineVariant: Color(0xff40484b),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdee3e6),
      inversePrimary: Color(0xff01677d),
      primaryFixed: Color(0xffb3ebff),
      onPrimaryFixed: Color(0xff001f27),
      primaryFixedDim: Color(0xff86d1ea),
      onPrimaryFixedVariant: Color(0xff004e5f),
      secondaryFixed: Color(0xffcee6f0),
      onSecondaryFixed: Color(0xff061e25),
      secondaryFixedDim: Color(0xffb3cad3),
      onSecondaryFixedVariant: Color(0xff344a52),
      tertiaryFixed: Color(0xffdfe0ff),
      onTertiaryFixed: Color(0xff151937),
      tertiaryFixedDim: Color(0xffc1c4eb),
      onTertiaryFixedVariant: Color(0xff414465),
      surfaceDim: Color(0xff0f1416),
      surfaceBright: Color(0xff343a3c),
      surfaceContainerLowest: Color(0xff090f11),
      surfaceContainerLow: Color(0xff171c1e),
      surfaceContainer: Color(0xff1b2023),
      surfaceContainerHigh: Color(0xff252b2d),
      surfaceContainerHighest: Color(0xff303638),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff8bd5ee),
      surfaceTint: Color(0xff86d1ea),
      onPrimary: Color(0xff001920),
      primaryContainer: Color(0xff4e9bb2),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffb7cfd8),
      onSecondary: Color(0xff021920),
      secondaryContainer: Color(0xff7d949d),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffc5c8ef),
      onTertiary: Color(0xff101331),
      tertiaryContainer: Color(0xff8b8eb3),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffbab1),
      onError: Color(0xff370001),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff0f1416),
      onSurface: Color(0xfff6fbfe),
      onSurfaceVariant: Color(0xffc3ccd0),
      outline: Color(0xff9ca4a8),
      outlineVariant: Color(0xff7c8488),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdee3e6),
      inversePrimary: Color(0xff004f60),
      primaryFixed: Color(0xffb3ebff),
      onPrimaryFixed: Color(0xff00141a),
      primaryFixedDim: Color(0xff86d1ea),
      onPrimaryFixedVariant: Color(0xff003c49),
      secondaryFixed: Color(0xffcee6f0),
      onSecondaryFixed: Color(0xff00141a),
      secondaryFixedDim: Color(0xffb3cad3),
      onSecondaryFixedVariant: Color(0xff233941),
      tertiaryFixed: Color(0xffdfe0ff),
      onTertiaryFixed: Color(0xff0a0e2c),
      tertiaryFixedDim: Color(0xffc1c4eb),
      onTertiaryFixedVariant: Color(0xff303453),
      surfaceDim: Color(0xff0f1416),
      surfaceBright: Color(0xff343a3c),
      surfaceContainerLowest: Color(0xff090f11),
      surfaceContainerLow: Color(0xff171c1e),
      surfaceContainer: Color(0xff1b2023),
      surfaceContainerHigh: Color(0xff252b2d),
      surfaceContainerHighest: Color(0xff303638),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xfff5fcff),
      surfaceTint: Color(0xff86d1ea),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xff8bd5ee),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xfff5fcff),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffb7cfd8),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xfffdf9ff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffc5c8ef),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xfffff9f9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffbab1),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff0f1416),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xfff5fcff),
      outline: Color(0xffc3ccd0),
      outlineVariant: Color(0xffc3ccd0),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdee3e6),
      inversePrimary: Color(0xff002f3a),
      primaryFixed: Color(0xffc0eeff),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xff8bd5ee),
      onPrimaryFixedVariant: Color(0xff001920),
      secondaryFixed: Color(0xffd3ebf4),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffb7cfd8),
      onSecondaryFixedVariant: Color(0xff021920),
      tertiaryFixed: Color(0xffe4e5ff),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffc5c8ef),
      onTertiaryFixedVariant: Color(0xff101331),
      surfaceDim: Color(0xff0f1416),
      surfaceBright: Color(0xff343a3c),
      surfaceContainerLowest: Color(0xff090f11),
      surfaceContainerLow: Color(0xff171c1e),
      surfaceContainer: Color(0xff1b2023),
      surfaceContainerHigh: Color(0xff252b2d),
      surfaceContainerHighest: Color(0xff303638),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        textTheme: textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        scaffoldBackgroundColor: colorScheme.surface,
        canvasColor: colorScheme.surface,
      );

  List<ExtendedColor> get extendedColors => [];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}

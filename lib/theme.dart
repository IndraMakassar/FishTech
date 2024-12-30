import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4283194514),
      surfaceTint: Color(4283194514),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4292665855),
      onPrimaryContainer: Color(4278392651),
      secondary: Color(4284046962),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4292796921),
      onSecondaryContainer: Color(4279638828),
      tertiary: Color(4285879408),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4294957046),
      onTertiaryContainer: Color(4281078314),
      error: Color(4290386458),
      onError: Color(4294967295),
      errorContainer: Color(4294957782),
      onErrorContainer: Color(4282449922),
      surface: Color(4294637823),
      onSurface: Color(4279900961),
      onSurfaceVariant: Color(4282730063),
      outline: Color(4285953664),
      outlineVariant: Color(4291217104),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281282614),
      inversePrimary: Color(4290168063),
      primaryFixed: Color(4292665855),
      onPrimaryFixed: Color(4278392651),
      primaryFixedDim: Color(4290168063),
      onPrimaryFixedVariant: Color(4281615481),
      secondaryFixed: Color(4292796921),
      onSecondaryFixed: Color(4279638828),
      secondaryFixedDim: Color(4290954717),
      onSecondaryFixedVariant: Color(4282467929),
      tertiaryFixed: Color(4294957046),
      onTertiaryFixed: Color(4281078314),
      tertiaryFixedDim: Color(4293114586),
      onTertiaryFixedVariant: Color(4284169559),
      surfaceDim: Color(4292532704),
      surfaceBright: Color(4294637823),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294243322),
      surfaceContainer: Color(4293848564),
      surfaceContainerHigh: Color(4293519343),
      surfaceContainerHighest: Color(4293124585),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4281352308),
      surfaceTint: Color(4283194514),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4284707498),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4282204757),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4285494408),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4283906387),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4287392390),
      onTertiaryContainer: Color(4294967295),
      error: Color(4287365129),
      onError: Color(4294967295),
      errorContainer: Color(4292490286),
      onErrorContainer: Color(4294967295),
      surface: Color(4294637823),
      onSurface: Color(4279900961),
      onSurfaceVariant: Color(4282466891),
      outline: Color(4284309095),
      outlineVariant: Color(4286151299),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281282614),
      inversePrimary: Color(4290168063),
      primaryFixed: Color(4284707498),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4283062671),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4285494408),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4283915119),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4287392390),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4285682285),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292532704),
      surfaceBright: Color(4294637823),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294243322),
      surfaceContainer: Color(4293848564),
      surfaceContainerHigh: Color(4293519343),
      surfaceContainerHighest: Color(4293124585),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4278918738),
      surfaceTint: Color(4283194514),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4281352308),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4280099123),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4282204757),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4281538865),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4283906387),
      onTertiaryContainer: Color(4294967295),
      error: Color(4283301890),
      onError: Color(4294967295),
      errorContainer: Color(4287365129),
      onErrorContainer: Color(4294967295),
      surface: Color(4294637823),
      onSurface: Color(4278190080),
      onSurfaceVariant: Color(4280427563),
      outline: Color(4282466891),
      outlineVariant: Color(4282466891),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281282614),
      inversePrimary: Color(4293520383),
      primaryFixed: Color(4281352308),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4279773533),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4282204757),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4280757310),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4283906387),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4282327868),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292532704),
      surfaceBright: Color(4294637823),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294243322),
      surfaceContainer: Color(4293848564),
      surfaceContainerHigh: Color(4293519343),
      surfaceContainerHighest: Color(4293124585),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4290168063),
      surfaceTint: Color(4290168063),
      onPrimary: Color(4280102241),
      primaryContainer: Color(4281615481),
      onPrimaryContainer: Color(4292665855),
      secondary: Color(4290954717),
      onSecondary: Color(4281020482),
      secondaryContainer: Color(4282467929),
      onSecondaryContainer: Color(4292796921),
      tertiary: Color(4293114586),
      onTertiary: Color(4282591040),
      tertiaryContainer: Color(4284169559),
      onTertiaryContainer: Color(4294957046),
      error: Color(4294948011),
      onError: Color(4285071365),
      errorContainer: Color(4287823882),
      onErrorContainer: Color(4294957782),
      surface: Color(4279374616),
      onSurface: Color(4293124585),
      onSurfaceVariant: Color(4291217104),
      outline: Color(4287598746),
      outlineVariant: Color(4282730063),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293124585),
      inversePrimary: Color(4283194514),
      primaryFixed: Color(4292665855),
      onPrimaryFixed: Color(4278392651),
      primaryFixedDim: Color(4290168063),
      onPrimaryFixedVariant: Color(4281615481),
      secondaryFixed: Color(4292796921),
      onSecondaryFixed: Color(4279638828),
      secondaryFixedDim: Color(4290954717),
      onSecondaryFixedVariant: Color(4282467929),
      tertiaryFixed: Color(4294957046),
      onTertiaryFixed: Color(4281078314),
      tertiaryFixedDim: Color(4293114586),
      onTertiaryFixedVariant: Color(4284169559),
      surfaceDim: Color(4279374616),
      surfaceBright: Color(4281874751),
      surfaceContainerLowest: Color(4279045651),
      surfaceContainerLow: Color(4279900961),
      surfaceContainer: Color(4280164133),
      surfaceContainerHigh: Color(4280887855),
      surfaceContainerHighest: Color(4281611322),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4290497023),
      surfaceTint: Color(4290168063),
      onPrimary: Color(4278194499),
      primaryContainer: Color(4286549704),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4291218145),
      onSecondary: Color(4279309862),
      secondaryContainer: Color(4287402149),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4293378015),
      onTertiary: Color(4280683812),
      tertiaryContainer: Color(4289365411),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294949553),
      onError: Color(4281794561),
      errorContainer: Color(4294923337),
      onErrorContainer: Color(4278190080),
      surface: Color(4279374616),
      onSurface: Color(4294769407),
      onSurfaceVariant: Color(4291480276),
      outline: Color(4288848556),
      outlineVariant: Color(4286743180),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293124585),
      inversePrimary: Color(4281746810),
      primaryFixed: Color(4292665855),
      onPrimaryFixed: Color(4278193463),
      primaryFixedDim: Color(4290168063),
      onPrimaryFixedVariant: Color(4280496999),
      secondaryFixed: Color(4292796921),
      onSecondaryFixed: Color(4278915105),
      secondaryFixedDim: Color(4290954717),
      onSecondaryFixedVariant: Color(4281414984),
      tertiaryFixed: Color(4294957046),
      onTertiaryFixed: Color(4280289055),
      tertiaryFixedDim: Color(4293114586),
      onTertiaryFixedVariant: Color(4282985542),
      surfaceDim: Color(4279374616),
      surfaceBright: Color(4281874751),
      surfaceContainerLowest: Color(4279045651),
      surfaceContainerLow: Color(4279900961),
      surfaceContainer: Color(4280164133),
      surfaceContainerHigh: Color(4280887855),
      surfaceContainerHighest: Color(4281611322),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4294769407),
      surfaceTint: Color(4290168063),
      onPrimary: Color(4278190080),
      primaryContainer: Color(4290497023),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4294769407),
      onSecondary: Color(4278190080),
      secondaryContainer: Color(4291218145),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4294965754),
      onTertiary: Color(4278190080),
      tertiaryContainer: Color(4293378015),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294965753),
      onError: Color(4278190080),
      errorContainer: Color(4294949553),
      onErrorContainer: Color(4278190080),
      surface: Color(4279374616),
      onSurface: Color(4294967295),
      onSurfaceVariant: Color(4294769407),
      outline: Color(4291480276),
      outlineVariant: Color(4291480276),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293124585),
      inversePrimary: Color(4279576154),
      primaryFixed: Color(4293060351),
      onPrimaryFixed: Color(4278190080),
      primaryFixedDim: Color(4290497023),
      onPrimaryFixedVariant: Color(4278194499),
      secondaryFixed: Color(4293060350),
      onSecondaryFixed: Color(4278190080),
      secondaryFixedDim: Color(4291218145),
      onSecondaryFixedVariant: Color(4279309862),
      tertiaryFixed: Color(4294958582),
      onTertiaryFixed: Color(4278190080),
      tertiaryFixedDim: Color(4293378015),
      onTertiaryFixedVariant: Color(4280683812),
      surfaceDim: Color(4279374616),
      surfaceBright: Color(4281874751),
      surfaceContainerLowest: Color(4279045651),
      surfaceContainerLow: Color(4279900961),
      surfaceContainer: Color(4280164133),
      surfaceContainerHigh: Color(4280887855),
      surfaceContainerHighest: Color(4281611322),
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
     scaffoldBackgroundColor: colorScheme.background,
     canvasColor: colorScheme.surface,
  );


  List<ExtendedColor> get extendedColors => [
  ];
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

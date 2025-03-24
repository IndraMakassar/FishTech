import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static MaterialScheme lightScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(4282146960),
      surfaceTint: Color(4282146960),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4292142079),
      onPrimaryContainer: Color(4278197306),
      secondary: Color(4283719537),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4292404216),
      onSecondaryContainer: Color(4279311403),
      tertiary: Color(4285421174),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4294433023),
      onTertiaryContainer: Color(4280751152),
      error: Color(4290386458),
      onError: Color(4294967295),
      errorContainer: Color(4294957782),
      onErrorContainer: Color(4282449922),
      background: Color(4294572543),
      onBackground: Color(4279835680),
      surface: Color(4294572543),
      onSurface: Color(4279835680),
      surfaceVariant: Color(4292928236),
      onSurfaceVariant: Color(4282599246),
      outline: Color(4285822847),
      outlineVariant: Color(4291020495),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281217077),
      inverseOnSurface: Color(4293980407),
      inversePrimary: Color(4289054975),
      primaryFixed: Color(4292142079),
      onPrimaryFixed: Color(4278197306),
      primaryFixedDim: Color(4289054975),
      onPrimaryFixedVariant: Color(4280436854),
      secondaryFixed: Color(4292404216),
      onSecondaryFixed: Color(4279311403),
      secondaryFixedDim: Color(4290562012),
      onSecondaryFixedVariant: Color(4282206040),
      tertiaryFixed: Color(4294433023),
      onTertiaryFixed: Color(4280751152),
      tertiaryFixedDim: Color(4292525538),
      onTertiaryFixedVariant: Color(4283776861),
      surfaceDim: Color(4292467424),
      surfaceBright: Color(4294572543),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294177786),
      surfaceContainer: Color(4293783028),
      surfaceContainerHigh: Color(4293388526),
      surfaceContainerHighest: Color(4292993769),
    );
  }

  ThemeData light() {
    return theme(lightScheme().toColorScheme());
  }

  static MaterialScheme lightMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(4280108146),
      surfaceTint: Color(4282146960),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4283659943),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4281942868),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4285232520),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4283513689),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4286934157),
      onTertiaryContainer: Color(4294967295),
      error: Color(4287365129),
      onError: Color(4294967295),
      errorContainer: Color(4292490286),
      onErrorContainer: Color(4294967295),
      background: Color(4294572543),
      onBackground: Color(4279835680),
      surface: Color(4294572543),
      onSurface: Color(4279835680),
      surfaceVariant: Color(4292928236),
      onSurfaceVariant: Color(4282336074),
      outline: Color(4284178279),
      outlineVariant: Color(4286020483),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281217077),
      inverseOnSurface: Color(4293980407),
      inversePrimary: Color(4289054975),
      primaryFixed: Color(4283659943),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4282015117),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4285232520),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4283587694),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4286934157),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4285224052),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292467424),
      surfaceBright: Color(4294572543),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294177786),
      surfaceContainer: Color(4293783028),
      surfaceContainerHigh: Color(4293388526),
      surfaceContainerHighest: Color(4292993769),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme lightHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(4278198854),
      surfaceTint: Color(4282146960),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4280108146),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4279771954),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4281942868),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4281211447),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4283513689),
      onTertiaryContainer: Color(4294967295),
      error: Color(4283301890),
      onError: Color(4294967295),
      errorContainer: Color(4287365129),
      onErrorContainer: Color(4294967295),
      background: Color(4294572543),
      onBackground: Color(4279835680),
      surface: Color(4294572543),
      onSurface: Color(4278190080),
      surfaceVariant: Color(4292928236),
      onSurfaceVariant: Color(4280296491),
      outline: Color(4282336074),
      outlineVariant: Color(4282336074),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281217077),
      inverseOnSurface: Color(4294967295),
      inversePrimary: Color(4293192959),
      primaryFixed: Color(4280108146),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4278201688),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4281942868),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4280495421),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4283513689),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4281935170),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292467424),
      surfaceBright: Color(4294572543),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294177786),
      surfaceContainer: Color(4293783028),
      surfaceContainerHigh: Color(4293388526),
      surfaceContainerHighest: Color(4292993769),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme().toColorScheme());
  }

  static MaterialScheme darkScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(4289054975),
      surfaceTint: Color(4289054975),
      onPrimary: Color(4278202718),
      primaryContainer: Color(4280436854),
      onPrimaryContainer: Color(4292142079),
      secondary: Color(4290562012),
      onSecondary: Color(4280758593),
      secondaryContainer: Color(4282206040),
      onSecondaryContainer: Color(4292404216),
      tertiary: Color(4292525538),
      onTertiary: Color(4282198342),
      tertiaryContainer: Color(4283776861),
      onTertiaryContainer: Color(4294433023),
      error: Color(4294948011),
      onError: Color(4285071365),
      errorContainer: Color(4287823882),
      onErrorContainer: Color(4294957782),
      background: Color(4279309080),
      onBackground: Color(4292993769),
      surface: Color(4279309080),
      onSurface: Color(4292993769),
      surfaceVariant: Color(4282599246),
      onSurfaceVariant: Color(4291020495),
      outline: Color(4287467929),
      outlineVariant: Color(4282599246),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4292993769),
      inverseOnSurface: Color(4281217077),
      inversePrimary: Color(4282146960),
      primaryFixed: Color(4292142079),
      onPrimaryFixed: Color(4278197306),
      primaryFixedDim: Color(4289054975),
      onPrimaryFixedVariant: Color(4280436854),
      secondaryFixed: Color(4292404216),
      onSecondaryFixed: Color(4279311403),
      secondaryFixedDim: Color(4290562012),
      onSecondaryFixedVariant: Color(4282206040),
      tertiaryFixed: Color(4294433023),
      onTertiaryFixed: Color(4280751152),
      tertiaryFixedDim: Color(4292525538),
      onTertiaryFixedVariant: Color(4283776861),
      surfaceDim: Color(4279309080),
      surfaceBright: Color(4281809214),
      surfaceContainerLowest: Color(4278980115),
      surfaceContainerLow: Color(4279835680),
      surfaceContainer: Color(4280098852),
      surfaceContainerHigh: Color(4280822319),
      surfaceContainerHighest: Color(4281480506),
    );
  }

  ThemeData dark() {
    return theme(darkScheme().toColorScheme());
  }

  static MaterialScheme darkMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(4289580287),
      surfaceTint: Color(4289054975),
      onPrimary: Color(4278195761),
      primaryContainer: Color(4285567686),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4290890720),
      onSecondary: Color(4278982438),
      secondaryContainer: Color(4287074725),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4292788711),
      onTertiary: Color(4280356394),
      tertiaryContainer: Color(4288841899),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294949553),
      onError: Color(4281794561),
      errorContainer: Color(4294923337),
      onErrorContainer: Color(4278190080),
      background: Color(4279309080),
      onBackground: Color(4292993769),
      surface: Color(4279309080),
      onSurface: Color(4294703871),
      surfaceVariant: Color(4282599246),
      onSurfaceVariant: Color(4291349204),
      outline: Color(4288717739),
      outlineVariant: Color(4286612363),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4292993769),
      inverseOnSurface: Color(4280822319),
      inversePrimary: Color(4280502648),
      primaryFixed: Color(4292142079),
      onPrimaryFixed: Color(4278194472),
      primaryFixedDim: Color(4289054975),
      onPrimaryFixedVariant: Color(4278859620),
      secondaryFixed: Color(4292404216),
      onSecondaryFixed: Color(4278653216),
      secondaryFixedDim: Color(4290562012),
      onSecondaryFixedVariant: Color(4281087815),
      tertiaryFixed: Color(4294433023),
      onTertiaryFixed: Color(4280027429),
      tertiaryFixedDim: Color(4292525538),
      onTertiaryFixedVariant: Color(4282592844),
      surfaceDim: Color(4279309080),
      surfaceBright: Color(4281809214),
      surfaceContainerLowest: Color(4278980115),
      surfaceContainerLow: Color(4279835680),
      surfaceContainer: Color(4280098852),
      surfaceContainerHigh: Color(4280822319),
      surfaceContainerHighest: Color(4281480506),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme darkHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(4294703871),
      surfaceTint: Color(4289054975),
      onPrimary: Color(4278190080),
      primaryContainer: Color(4289580287),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4294703871),
      onSecondary: Color(4278190080),
      secondaryContainer: Color(4290890720),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4294965755),
      onTertiary: Color(4278190080),
      tertiaryContainer: Color(4292788711),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294965753),
      onError: Color(4278190080),
      errorContainer: Color(4294949553),
      onErrorContainer: Color(4278190080),
      background: Color(4279309080),
      onBackground: Color(4292993769),
      surface: Color(4279309080),
      onSurface: Color(4294967295),
      surfaceVariant: Color(4282599246),
      onSurfaceVariant: Color(4294703871),
      outline: Color(4291349204),
      outlineVariant: Color(4291349204),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4292993769),
      inverseOnSurface: Color(4278190080),
      inversePrimary: Color(4278200915),
      primaryFixed: Color(4292601855),
      onPrimaryFixed: Color(4278190080),
      primaryFixedDim: Color(4289580287),
      onPrimaryFixedVariant: Color(4278195761),
      secondaryFixed: Color(4292732925),
      onSecondaryFixed: Color(4278190080),
      secondaryFixedDim: Color(4290890720),
      onSecondaryFixedVariant: Color(4278982438),
      tertiaryFixed: Color(4294565631),
      onTertiaryFixed: Color(4278190080),
      tertiaryFixedDim: Color(4292788711),
      onTertiaryFixedVariant: Color(4280356394),
      surfaceDim: Color(4279309080),
      surfaceBright: Color(4281809214),
      surfaceContainerLowest: Color(4278980115),
      surfaceContainerLow: Color(4279835680),
      surfaceContainer: Color(4280098852),
      surfaceContainerHigh: Color(4280822319),
      surfaceContainerHighest: Color(4281480506),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme().toColorScheme());
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


  List<ExtendedColor> get extendedColors => [
  ];
}

class MaterialScheme {
  const MaterialScheme({
    required this.brightness,
    required this.primary, 
    required this.surfaceTint, 
    required this.onPrimary, 
    required this.primaryContainer, 
    required this.onPrimaryContainer, 
    required this.secondary, 
    required this.onSecondary, 
    required this.secondaryContainer, 
    required this.onSecondaryContainer, 
    required this.tertiary, 
    required this.onTertiary, 
    required this.tertiaryContainer, 
    required this.onTertiaryContainer, 
    required this.error, 
    required this.onError, 
    required this.errorContainer, 
    required this.onErrorContainer, 
    required this.background, 
    required this.onBackground, 
    required this.surface, 
    required this.onSurface, 
    required this.surfaceVariant, 
    required this.onSurfaceVariant, 
    required this.outline, 
    required this.outlineVariant, 
    required this.shadow, 
    required this.scrim, 
    required this.inverseSurface, 
    required this.inverseOnSurface, 
    required this.inversePrimary, 
    required this.primaryFixed, 
    required this.onPrimaryFixed, 
    required this.primaryFixedDim, 
    required this.onPrimaryFixedVariant, 
    required this.secondaryFixed, 
    required this.onSecondaryFixed, 
    required this.secondaryFixedDim, 
    required this.onSecondaryFixedVariant, 
    required this.tertiaryFixed, 
    required this.onTertiaryFixed, 
    required this.tertiaryFixedDim, 
    required this.onTertiaryFixedVariant, 
    required this.surfaceDim, 
    required this.surfaceBright, 
    required this.surfaceContainerLowest, 
    required this.surfaceContainerLow, 
    required this.surfaceContainer, 
    required this.surfaceContainerHigh, 
    required this.surfaceContainerHighest, 
  });

  final Brightness brightness;
  final Color primary;
  final Color surfaceTint;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;
  final Color tertiary;
  final Color onTertiary;
  final Color tertiaryContainer;
  final Color onTertiaryContainer;
  final Color error;
  final Color onError;
  final Color errorContainer;
  final Color onErrorContainer;
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;
  final Color surfaceVariant;
  final Color onSurfaceVariant;
  final Color outline;
  final Color outlineVariant;
  final Color shadow;
  final Color scrim;
  final Color inverseSurface;
  final Color inverseOnSurface;
  final Color inversePrimary;
  final Color primaryFixed;
  final Color onPrimaryFixed;
  final Color primaryFixedDim;
  final Color onPrimaryFixedVariant;
  final Color secondaryFixed;
  final Color onSecondaryFixed;
  final Color secondaryFixedDim;
  final Color onSecondaryFixedVariant;
  final Color tertiaryFixed;
  final Color onTertiaryFixed;
  final Color tertiaryFixedDim;
  final Color onTertiaryFixedVariant;
  final Color surfaceDim;
  final Color surfaceBright;
  final Color surfaceContainerLowest;
  final Color surfaceContainerLow;
  final Color surfaceContainer;
  final Color surfaceContainerHigh;
  final Color surfaceContainerHighest;
}

extension MaterialSchemeUtils on MaterialScheme {
  ColorScheme toColorScheme() {
    return ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      tertiary: tertiary,
      onTertiary: onTertiary,
      tertiaryContainer: tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer,
      error: error,
      onError: onError,
      errorContainer: errorContainer,
      onErrorContainer: onErrorContainer,
      surface: surface,
      onSurface: onSurface,
      onSurfaceVariant: onSurfaceVariant,
      surfaceContainerHighest: surfaceContainerHighest,
      outline: outline,
      outlineVariant: outlineVariant,
      shadow: shadow,
      scrim: scrim,
      inverseSurface: inverseSurface,
      onInverseSurface: inverseOnSurface,
      inversePrimary: inversePrimary,
    );
  }
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

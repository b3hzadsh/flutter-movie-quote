class AppConfig {
  static bool _isDevMode = false;

  static bool get isDevMode => _isDevMode;

  /// Initializes the config from --dart-define flags.
  /// Pass `--dart-define=devMode=true` when running or building.
  static void init() {
    _isDevMode = const bool.fromEnvironment('devMode', defaultValue: false);
  }
}

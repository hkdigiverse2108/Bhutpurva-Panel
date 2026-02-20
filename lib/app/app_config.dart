class AppConfig {
  // App Info
  static const String appName = "Gurukul Bhutpurva Penal";
  static const String version = "1.0.0";

  // Network
  static const Duration apiTimeout = Duration(seconds: 30);

  // Limits
  static const int otpLength = 6;

  // Features
  static const bool enableReferral = true;
}

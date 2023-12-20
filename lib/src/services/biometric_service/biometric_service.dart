/// This interface defines a Biometric service.
abstract class BiometricService {
  /// The default, const constructor. Used by subclasses.
  const BiometricService();

  /// Check if Biometrics is available on the device.
  Future<bool> isAvailable() {
    throw UnimplementedError('isAvailable() is not implemented.');
  }

  /// Check if the session is locked by Biometrics.
  Future<bool> isLocked() {
    throw UnimplementedError('isLocked() is not implemented.');
  }

  /// Check if the device is enrolled in Biometrics.
  Future<bool> isOptIn() {
    throw UnimplementedError('isOptIn() is not implemented.');
  }

  /// Opt into biometrics.
  ///
  /// The [parameters] passed in here is for the GigyaInfoPrompt. (Only for Android)
  /// The Map that needs to be passed is as follows:
  ///
  /// {
  ///   'title': SampleTitle,
  ///   'subtitle': SampleSubtitle,
  ///   'description': SampleDescription,
  /// }
  ///
  /// For more details, see [Android Documentation](https://sap.github.io/gigya-android-sdk/sdk-biometric/#gigyapromptinfo-class)
  Future<void> optIn({
    Map<String, dynamic> parameters = const <String, dynamic>{},
  }) {
    throw UnimplementedError('optIn() is not implemented.');
  }

  /// Opt out of biometrics.
  ///
  /// The [parameters] passed in here is for the GigyaInfoPrompt. (Only for Android)
  /// The Map that needs to be passed is as follows:
  ///
  /// {
  ///   'title': 'SampleTitle',
  ///   'subtitle': 'SampleSubtitle',
  ///   'description': 'SampleDescription',
  /// }
  ///
  /// For more details, see [Android Documentation](https://sap.github.io/gigya-android-sdk/sdk-biometric/#gigyapromptinfo-class)
  Future<void> optOut({
    Map<String, dynamic> parameters = const <String, dynamic>{},
  }) {
    throw UnimplementedError('optOut() is not implemented.');
  }

  /// Lock the session with biometrics.
  Future<void> lockSession() {
    throw UnimplementedError('lockSession() is not implemented.');
  }

  /// Unlock the session with biometrics.
  ///
  /// The [parameters] passed in here is for the GigyaInfoPrompt. (Only for Android)
  /// The Map that needs to be passed is as follows:
  /// {
  ///   'title': 'SampleTitle',
  ///   'subtitle': 'SampleSubtitle',
  ///   'description': 'SampleDescription',
  /// }
  ///
  /// For more details, see [Android Documentation](https://sap.github.io/gigya-android-sdk/sdk-biometric/#gigyapromptinfo-class)
  Future<void> unlockSession({
    Map<String, dynamic> parameters = const <String, dynamic>{},
  }) {
    throw UnimplementedError('unlockSession() is not implemented.');
  }
}

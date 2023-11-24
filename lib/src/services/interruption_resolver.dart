import '../models/conflicting_account.dart';
import '../models/enums/social_provider.dart';
import '../models/gigya_error.dart';

/// This interface represents the base interruption resolver.
abstract class InterruptionResolver {
  /// The default constructor.
  const InterruptionResolver();
}

/// The resolver factory for interruptions.
abstract class InterruptionResolverFactory {
  /// The default constructor.
  const InterruptionResolverFactory();

  /// Get an [InterruptionResolver] for the given [GigyaError.errorCode].
  InterruptionResolver? fromErrorCode(GigyaError exception) {
    throw UnimplementedError('fromErrorCode() is not implemented.');
  }
}

/// The resolver for a link account flow interruption.
abstract class LinkAccountResolver extends InterruptionResolver {
  /// Get the conflicting accounts of the user.
  Future<ConflictingAccount>? get conflictingAccount {
    throw UnimplementedError('conflictingAccounts is not implemented.');
  }

  /// Link a social account to an existing site account.
  Future<Map<String, dynamic>> linkToSite({
    required String loginId,
    required String password,
  }) {
    throw UnimplementedError('linkToSite() is not implemented.');
  }

  /// Link a site account to an existing social account.
  Future<Map<String, dynamic>> linkToSocial(SocialProvider provider) {
    throw UnimplementedError('linkToSocial() is not implemented.');
  }
}

/// The resolver for a registration interruption.
abstract class PendingRegistrationResolver extends InterruptionResolver {
  /// The default constructor.
  const PendingRegistrationResolver();

  /// Set the user account using the given [parameters].
  Future<Map<String, dynamic>> setAccount(Map<String, dynamic> parameters) {
    throw UnimplementedError('setAccount() is not implemented.');
  }
}

/// The resolver for a pending verification interruption.
class PendingVerificationResolver extends InterruptionResolver {
  /// The default constructor.
  const PendingVerificationResolver(this.registrationToken);

  /// The registration token of this resolver.
  ///
  /// This token can be used to resolve the registration interruption.
  final String registrationToken;
}

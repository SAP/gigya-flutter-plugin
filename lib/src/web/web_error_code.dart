/// This enum defines the error codes for the Gigya Web SDK.
///
/// See also: https://help.sap.com/docs/SAP_CUSTOMER_DATA_CLOUD/8b8d6fffe113457094a17701f63e3d6a/416d41b170b21014bbc5a10ce4041860.html#error-code-definitions-table
enum WebErrorCode {
  /// This value indicates that an unspecified error occurred.
  genericError(-1),

  /// This value indicates a success result.
  success(0),

  /// This value indicates that a user has no valid session.
  unauthorizedUser(403005);

  /// The default constructor.
  const WebErrorCode(this.errorCode);

  /// Create a [WebErrorCode] from the given [errorCode].
  factory WebErrorCode.fromErrorCode(int errorCode) {
    switch (errorCode) {
      case 0:
        return success;
      case 403005:
        return unauthorizedUser;
      default:
        return genericError;
    }
  }

  /// The error code for this enum value.
  final int errorCode;
}

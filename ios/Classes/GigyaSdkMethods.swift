/// This enum defines the different methods
/// that can be invoked by the Gigya Flutter Plugin.
public enum GigyaSdkMethods: String {
    // Initialization.
    case initSdk

    // Credential based Authentication.
    case loginWithCredentials
    case registerWithCredentials

    // One-Time-Password Authentication.
    case otpLogin
    case otpUpdate
    case otpVerify

    // Login using a Social Provider / Single-Sign-On.
    case socialLogin
    case sso
    case getAuthCode

    // Web Authentication.
    case webAuthnLogin
    case webAuthnRegister
    case webAuthnRevoke
    case passkeyRevoke
    case passkeyGetCredentials

    // Querying login state / Logging out.
    case isLoggedIn
    case logOut

    // User Accounts.
    case getAccount
    case setAccount

    // Sessions.
    case getSession
    case setSession

    // Social connections.
    case addConnection
    case removeConnection

    // Generic Requests API / Show ScreenSet API.
    case sendRequest
    case showScreenSet
    case dismissScreenSet
    
    // Interruption types.
    case forgotPassword
    case getConflictingAccounts
    case linkToSite
    case linkToSocial
    case resolveSetAccount
    
    // Biometrics.
    case biometricIsAvailable
    case biometricIsLocked
    case biometricIsOptIn
    case biometricOptIn
    case biometricOptOut
    case biometricLockSession
    case biometricUnlockSession
}

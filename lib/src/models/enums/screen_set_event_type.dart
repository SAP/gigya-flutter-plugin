/// The event type for a screen set event.
///
/// Each [name] matches the name of a screenset event.
enum ScreenSetEventType {
  /// The event that is fired after a screen has been loaded.
  onAfterScreenLoad,

  /// The event that is fired after a submit.
  onAfterSubmit,

  /// The event that is fired after validation.
  onAfterValidation,

  /// The event that is fired before a screen began loading.
  onBeforeScreenLoad,

  /// The event that is fired before a submit.
  onBeforeSubmit,

  /// The event that is fired before validation.
  onBeforeValidation,

  /// The event that is fired when a screen set has been canceled.
  onCancel,

  /// The event that is fired after a connection has been added.
  onConnectionAdded,

  /// The event that is fired after a connection has been removed.
  onConnectionRemoved,

  /// The event that is fired when an error occurred.
  onError,

  /// The event that is fired when a field has changed.
  onFieldChanged,

  /// The event that is fired when a screen set was hidden.
  onHide,

  /// The event that is fired when the user logged in.
  onLogin,

  /// The event that is fired when the user logged out.
  onLogout,

  /// The event that is fired when a submit occurs.
  onSubmit,
}

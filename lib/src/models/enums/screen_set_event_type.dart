/// The event type for a screen set event.
enum ScreenSetEventType {
  /// The event that is fired after a screen has been loaded.
  afterScreenLoad,

  /// The event that is fired after a submit.
  afterSubmit,

  /// The event that is fired after validation.
  afterValidation,

  /// The event that is fired before a screen began loading.
  beforeScreenLoad,

  /// The event that is fired before a submit.
  beforeSubmit,

  /// The event that is fired before validation.
  beforeValidation,

  /// The event that is fired when a screen set has been canceled.
  cancel,

  /// The event that is fired after a connection has been added.
  connectionAdded,

  /// The event that is fired after a connection has been removed.
  connectionRemoved,

  /// The event that is fired when an error occurred.
  error,

  /// The event that is fired when a field has changed.
  fieldChanged,

  /// The event that is fired when a screen set was hidden.
  hide,

  /// The event that is fired when the user logged in.
  login,

  /// The event that is fired when the user logged out.
  logout,

  /// The event that is fired when a submit occurs.
  submit,
}

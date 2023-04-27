// TODO: investigate if this can be a `final class` once Class Modifiers are available in Dart 3.0

/// The currently supported social providers.
///
/// Depending on the platform; some social providers might be unavailable.
class SocialProvider {
  /// The private constructor.
  const SocialProvider._(this.name);

  /// Create a new SAML-based [SocialProvider] from a given [value].
  ///
  /// The [value] will be prefixed by `saml-`.
  factory SocialProvider.saml(String value) {
    if (value.isEmpty) {
      throw ArgumentError.value(
        value,
        'value',
        'The value of a SAML SocialProvider should not be empty.',
      );
    }

    return SocialProvider._('saml-$value');
  }

  /// The name of this provider.
  final String name;

  /// The social provider for Amazon.
  static const SocialProvider amazon = SocialProvider._('amazon');

  /// The social provider for Apple.
  static const SocialProvider apple = SocialProvider._('apple');

  /// The social provider for Blogger.
  static const SocialProvider blogger = SocialProvider._('blogger');

  /// The social provider for Facebook.
  static const SocialProvider facebook = SocialProvider._('facebook');

  /// The social provider for Foursquare.
  static const SocialProvider foursquare = SocialProvider._('foursquare');

  /// The social provider for Google.
  static const SocialProvider google = SocialProvider._('google');

  /// The social provider for GooglePlus.
  static const SocialProvider googleplus = SocialProvider._('googleplus');

  /// The social provider for Kakao.
  static const SocialProvider kakao = SocialProvider._('kakao');

  /// The social provider for LINE.
  static const SocialProvider line = SocialProvider._('line');

  /// The social provider for LinkedIn.
  static const SocialProvider linkedin = SocialProvider._('linkedin');

  /// The social provider for Livedoor.
  static const SocialProvider livedoor = SocialProvider._('livedoor');

  /// The social provider for Microsoft Messenger.
  @Deprecated('Use SocialProvider.microsoft instead.')
  static const SocialProvider messenger = SocialProvider._('messenger');

  /// The social provider for Microsoft Messenger.
  static const SocialProvider microsoft = SocialProvider._('microsoft');

  /// The social provider for mixi.
  static const SocialProvider mixi = SocialProvider._('mixi');

  /// The social provider for Naver.
  static const SocialProvider naver = SocialProvider._('naver');

  /// The social provider for Netlog.
  static const SocialProvider netlog = SocialProvider._('netlog');

  /// The social provider for Odnoklassniki.
  static const SocialProvider odnoklassniki = SocialProvider._('odnoklassniki');

  /// The social provider for Paypal.
  static const SocialProvider paypal = SocialProvider._('paypaloauth');

  /// The social provider for TencentQQ.
  static const SocialProvider qq = SocialProvider._('qq');

  /// The social provider for renren.
  static const SocialProvider renren = SocialProvider._('renren');

  /// The social provider for SinaWeibo.
  static const SocialProvider sina = SocialProvider._('sina');

  /// The social provider for Spiceworks.
  static const SocialProvider spiceworks = SocialProvider._('spiceworks');

  /// The social provider for Twitter.
  static const SocialProvider twitter = SocialProvider._('twitter');

  /// The social provider for VKontakte.
  static const SocialProvider vkontakte = SocialProvider._('vkontakte');

  /// The social provider for WeChat.
  static const SocialProvider wechat = SocialProvider._('wechat');

  /// The social provider for WordPress.
  static const SocialProvider wordpress = SocialProvider._('wordpress');

  /// The social provider for Xing.
  static const SocialProvider xing = SocialProvider._('xing');

  /// The social provider for Yahoo!.
  static const SocialProvider yahoo = SocialProvider._('yahoo');

  /// The social provider for Yahoo! Japan.
  static const SocialProvider yahooJapan = SocialProvider._('yahoojapan');
}

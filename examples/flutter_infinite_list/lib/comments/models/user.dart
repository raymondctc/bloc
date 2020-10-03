///
/// User object
///
class User {
  User({
    this.userId,
    this.avatarUrl,
    this.displayName,
    this.emojiStatus,
    this.country,
    this.profileUrl,
    this.profileUrls,
    this.isActivePro,
    this.isActiveProPlus,
    this.isVerifiedAccount,
    this.accountId,
    this.hashedAccountId,
    this.activeTs,
    this.preferences
  });

  factory User.fromJson(Map<String, dynamic> json) {
    Map<String, String> profileUrls;
    if (json['profileUrls'] != null) {
      profileUrls = {};
      var parsed = json['profileUrls'] as Map<String, dynamic>;
      for (var key in parsed.keys) {
        profileUrls[key] = parsed[key] as String;
      }
    }



    return User(
      userId: json['userId'] as String,
      avatarUrl: json['avatarUrl'] as String,
      displayName: json['displayName'] as String,
      emojiStatus: json['emojiStatus'] as String,
      country: json['country'] as String,
      profileUrl: json['profileUrl'] as String,
      profileUrls: profileUrls,
      isActivePro: json['isActivePro'] as bool,
      isActiveProPlus: json['isActiveProPlus'] as bool,
      isVerifiedAccount: json['isVerifiedAccount'] as bool,
      accountId: json['accountId'] as String,
      hashedAccountId: json['hashedAccountId'] as String,
      activeTs: json['activeTs'] as int,
      preferences: json['preferences'] != null
        ? Preferences.fromJson(json['preferences'] as Map<String, dynamic>)
        : null
    );
  }

  String userId;
  String avatarUrl;
  String displayName;
  String emojiStatus;
  String country;
  String profileUrl;
  final Map<String, String> profileUrls;
  final bool isActivePro;
  final bool isActiveProPlus;
  final bool isVerifiedAccount;
  final String accountId;
  final String hashedAccountId;
  final int activeTs;
  final Preferences preferences;
}

///
/// Preferences
///
class Preferences {

  Preferences({
    this.hideProBadge,
    this.hideActiveTs,
    this.accentColor,
    this.backgroundColor
  });

  factory Preferences.fromJson(Map<String, dynamic> json) {
    return Preferences(
      hideProBadge: json['hideProBadge'] as int,
      hideActiveTs: json['hideActiveTs'] as int,
      accentColor: json['accentColor'] as String,
      backgroundColor: json['backgroundColor'] as String
    );
  }

  final int hideProBadge;
  final int hideActiveTs;
  final String accentColor;
  final String backgroundColor;
}
class Media {
  Media({
    this.imageMetaByType,
    this.sourceMeta,
    this.hash
  });

  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
        imageMetaByType: ImageMetaByType.fromJson(
            json['imageMetaByType'] as Map<String, dynamic>
        ),
        sourceMeta: SourceMeta.fromJson(
            json['sourceMeta'] as Map<String, dynamic>
        ),
        hash: json['hash'] as String
    );
  }

  final ImageMetaByType imageMetaByType;
  final SourceMeta sourceMeta;
  final String hash;
}

class EmbedMedia {
  EmbedMedia({
    this.width,
    this.height,
    this.url,
    this.webpUrl
  });

  factory EmbedMedia.fromJson(Map<String, dynamic> json) {
    return EmbedMedia(
      width: json['width'] as int,
      height: json['height'] as int,
      url: json['url'] as String,
      webpUrl: json['webpUrl'] as String
    );
  }

  final int width;
  final int height;
  final String url;
  final String webpUrl;

  String getImageUrl() {
    if (webpUrl != null) {
      return webpUrl;
    } else {
      return url;
    }
  }
}

class ImageMetaByType {
  ImageMetaByType({
    this.type,
    this.image,
    this.imageXLarge,
    this.animated,
    this.video
  });

  factory ImageMetaByType.fromJson(Map<String, dynamic> json) {
    return ImageMetaByType(
      type: json['type'] as String,
      image: json['image'] != null
          ? EmbedMedia.fromJson(json['image'] as Map<String, dynamic>)
          : null,
      imageXLarge: json['imageXLarge'] != null
          ? EmbedMedia.fromJson(json['imageXLarge'] as Map<String, dynamic>)
          : null,
      animated: json['animated'] != null
          ? EmbedMedia.fromJson(json['animated'] as Map<String, dynamic>)
          : null,
      video: json['video'] != null
          ? EmbedMedia.fromJson(json['video'] as Map<String, dynamic>)
          : null,
    );
  }

  final String type;
  final EmbedMedia image;
  final EmbedMedia imageXLarge;
  final EmbedMedia animated;
  final EmbedMedia video;
}

class SourceMeta {

  SourceMeta({
    this.accountKey,
    this.key,
    this.type,
    this.clazz,
    this.size,
    this.width,
    this.height,
    this.hash
  });

  factory SourceMeta.fromJson(Map<String, dynamic> json) {
    return SourceMeta(
        accountKey: json['accountKey'] as String,
        key: json['key'] as String,
        type: json['type'] as String,
        clazz: json['class'] as String,
        size: json['size'] as int,
        width: json['width'] as int,
        height: json['height'] as int,
        hash: json['hash'] as String
    );
  }

  final String accountKey;
  final String key;
  final String type;
  final String clazz;
  final int size;
  final int width;
  final int height;
  final String hash;
}
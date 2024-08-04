// To parse this JSON data, do
//
//     final apiMovieDataModel = apiMovieDataModelFromJson(jsonString);

import 'dart:convert';

ApiMovieDataModel apiMovieDataModelFromJson(String str) => ApiMovieDataModel.fromJson(json.decode(str));

String apiMovieDataModelToJson(ApiMovieDataModel data) => json.encode(data.toJson());

class ApiMovieDataModel {
  String? page;
  String? next;
  int? entries;
  List<Result>? results;

  ApiMovieDataModel({
    this.page,
    this.next,
    this.entries,
    this.results,
  });

  factory ApiMovieDataModel.fromJson(Map<String, dynamic> json) => ApiMovieDataModel(
    page: json["page"],
    next: json["next"],
    entries: json["entries"],
    results: json["results"] == null ? [] : List<Result>.from(json["results"]!.map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "next": next,
    "entries": entries,
    "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
  };
}

class Result {
  String? id;
  String? resultId;
  PrimaryImage? primaryImage;
  TitleType? titleType;
  TitleText? titleText;
  TitleText? originalTitleText;
  ReleaseYear? releaseYear;
  ReleaseDate? releaseDate;

  Result({
    this.id,
    this.resultId,
    this.primaryImage,
    this.titleType,
    this.titleText,
    this.originalTitleText,
    this.releaseYear,
    this.releaseDate,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["_id"],
    resultId: json["id"],
    primaryImage: json["primaryImage"] == null ? null : PrimaryImage.fromJson(json["primaryImage"]),
    titleType: json["titleType"] == null ? null : TitleType.fromJson(json["titleType"]),
    titleText: json["titleText"] == null ? null : TitleText.fromJson(json["titleText"]),
    originalTitleText: json["originalTitleText"] == null ? null : TitleText.fromJson(json["originalTitleText"]),
    releaseYear: json["releaseYear"] == null ? null : ReleaseYear.fromJson(json["releaseYear"]),
    releaseDate: json["releaseDate"] == null ? null : ReleaseDate.fromJson(json["releaseDate"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "id": resultId,
    "primaryImage": primaryImage?.toJson(),
    "titleType": titleType?.toJson(),
    "titleText": titleText?.toJson(),
    "originalTitleText": originalTitleText?.toJson(),
    "releaseYear": releaseYear?.toJson(),
    "releaseDate": releaseDate?.toJson(),
  };
}

class TitleText {
  String? text;
  OriginalTitleTextTypename? typename;

  TitleText({
    this.text,
    this.typename,
  });

  factory TitleText.fromJson(Map<String, dynamic> json) => TitleText(
    text: json["text"],
    typename: originalTitleTextTypenameValues.map[json["__typename"]]!,
  );

  Map<String, dynamic> toJson() => {
    "text": text,
    "__typename": originalTitleTextTypenameValues.reverse[typename],
  };
}

enum OriginalTitleTextTypename {
  TITLE_TEXT
}

final originalTitleTextTypenameValues = EnumValues({
  "TitleText": OriginalTitleTextTypename.TITLE_TEXT
});

class PrimaryImage {
  String? id;
  int? width;
  int? height;
  String? url;
  Caption? caption;
  PrimaryImageTypename? typename;

  PrimaryImage({
    this.id,
    this.width,
    this.height,
    this.url,
    this.caption,
    this.typename,
  });

  factory PrimaryImage.fromJson(Map<String, dynamic> json) => PrimaryImage(
    id: json["id"],
    width: json["width"],
    height: json["height"],
    url: json["url"],
    caption: json["caption"] == null ? null : Caption.fromJson(json["caption"]),
    typename: primaryImageTypenameValues.map[json["__typename"]]!,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "width": width,
    "height": height,
    "url": url,
    "caption": caption?.toJson(),
    "__typename": primaryImageTypenameValues.reverse[typename],
  };
}

class Caption {
  String? plainText;
  CaptionTypename? typename;

  Caption({
    this.plainText,
    this.typename,
  });

  factory Caption.fromJson(Map<String, dynamic> json) => Caption(
    plainText: json["plainText"],
    typename: captionTypenameValues.map[json["__typename"]]!,
  );

  Map<String, dynamic> toJson() => {
    "plainText": plainText,
    "__typename": captionTypenameValues.reverse[typename],
  };
}

enum CaptionTypename {
  MARKDOWN
}

final captionTypenameValues = EnumValues({
  "Markdown": CaptionTypename.MARKDOWN
});

enum PrimaryImageTypename {
  IMAGE
}

final primaryImageTypenameValues = EnumValues({
  "Image": PrimaryImageTypename.IMAGE
});

class ReleaseDate {
  int? day;
  int? month;
  int? year;
  ReleaseDateTypename? typename;

  ReleaseDate({
    this.day,
    this.month,
    this.year,
    this.typename,
  });

  factory ReleaseDate.fromJson(Map<String, dynamic> json) => ReleaseDate(
    day: json["day"],
    month: json["month"],
    year: json["year"],
    typename: releaseDateTypenameValues.map[json["__typename"]]!,
  );

  Map<String, dynamic> toJson() => {
    "day": day,
    "month": month,
    "year": year,
    "__typename": releaseDateTypenameValues.reverse[typename],
  };
}

enum ReleaseDateTypename {
  RELEASE_DATE
}

final releaseDateTypenameValues = EnumValues({
  "ReleaseDate": ReleaseDateTypename.RELEASE_DATE
});

class ReleaseYear {
  int? year;
  dynamic endYear;
  ReleaseYearTypename? typename;

  ReleaseYear({
    this.year,
    this.endYear,
    this.typename,
  });

  factory ReleaseYear.fromJson(Map<String, dynamic> json) => ReleaseYear(
    year: json["year"],
    endYear: json["endYear"],
    typename: releaseYearTypenameValues.map[json["__typename"]]!,
  );

  Map<String, dynamic> toJson() => {
    "year": year,
    "endYear": endYear,
    "__typename": releaseYearTypenameValues.reverse[typename],
  };
}

enum ReleaseYearTypename {
  YEAR_RANGE
}

final releaseYearTypenameValues = EnumValues({
  "YearRange": ReleaseYearTypename.YEAR_RANGE
});

class TitleType {
  DisplayableProperty? displayableProperty;
  String? text;
  String? id;
  bool? isSeries;
  bool? isEpisode;
  List<Category>? categories;
  bool? canHaveEpisodes;
  TitleTypeTypename? typename;

  TitleType({
    this.displayableProperty,
    this.text,
    this.id,
    this.isSeries,
    this.isEpisode,
    this.categories,
    this.canHaveEpisodes,
    this.typename,
  });

  factory TitleType.fromJson(Map<String, dynamic> json) => TitleType(
    displayableProperty: json["displayableProperty"] == null ? null : DisplayableProperty.fromJson(json["displayableProperty"]),
    text: json["text"],
    id: json["id"],
    isSeries: json["isSeries"],
    isEpisode: json["isEpisode"],
    categories: json["categories"] == null ? [] : List<Category>.from(json["categories"]!.map((x) => Category.fromJson(x))),
    canHaveEpisodes: json["canHaveEpisodes"],
    typename: titleTypeTypenameValues.map[json["__typename"]]!,
  );

  Map<String, dynamic> toJson() => {
    "displayableProperty": displayableProperty?.toJson(),
    "text": text,
    "id": id,
    "isSeries": isSeries,
    "isEpisode": isEpisode,
    "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x.toJson())),
    "canHaveEpisodes": canHaveEpisodes,
    "__typename": titleTypeTypenameValues.reverse[typename],
  };
}

class Category {
  Value? value;
  CategoryTypename? typename;

  Category({
    this.value,
    this.typename,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    value: valueValues.map[json["value"]]!,
    typename: categoryTypenameValues.map[json["__typename"]]!,
  );

  Map<String, dynamic> toJson() => {
    "value": valueValues.reverse[value],
    "__typename": categoryTypenameValues.reverse[typename],
  };
}

enum CategoryTypename {
  TITLE_TYPE_CATEGORY
}

final categoryTypenameValues = EnumValues({
  "TitleTypeCategory": CategoryTypename.TITLE_TYPE_CATEGORY
});

enum Value {
  GAMING,
  MOVIE,
  TV,
  VIDEO
}

final valueValues = EnumValues({
  "gaming": Value.GAMING,
  "movie": Value.MOVIE,
  "tv": Value.TV,
  "video": Value.VIDEO
});

class DisplayableProperty {
  Caption? value;
  DisplayablePropertyTypename? typename;

  DisplayableProperty({
    this.value,
    this.typename,
  });

  factory DisplayableProperty.fromJson(Map<String, dynamic> json) => DisplayableProperty(
    value: json["value"] == null ? null : Caption.fromJson(json["value"]),
    typename: displayablePropertyTypenameValues.map[json["__typename"]]!,
  );

  Map<String, dynamic> toJson() => {
    "value": value?.toJson(),
    "__typename": displayablePropertyTypenameValues.reverse[typename],
  };
}

enum DisplayablePropertyTypename {
  DISPLAYABLE_TITLE_TYPE_PROPERTY
}

final displayablePropertyTypenameValues = EnumValues({
  "DisplayableTitleTypeProperty": DisplayablePropertyTypename.DISPLAYABLE_TITLE_TYPE_PROPERTY
});

enum TitleTypeTypename {
  TITLE_TYPE
}

final titleTypeTypenameValues = EnumValues({
  "TitleType": TitleTypeTypename.TITLE_TYPE
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

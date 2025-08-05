class RegionModel {
  RegionModel({
    required this.regions,
    required this.count,
    required this.offset,
    required this.limit,
  });

  final List<Region> regions;
  final num count;
  final num offset;
  final num limit;

  factory RegionModel.fromJson(Map<String, dynamic> json) {
    return RegionModel(
      regions: json["regions"] == null
          ? []
          : List<Region>.from(json["regions"]!.map((x) => Region.fromJson(x))),
      count: json["count"] ?? 0,
      offset: json["offset"] ?? 0,
      limit: json["limit"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "regions": regions.map((x) => x?.toJson()).toList(),
    "count": count,
    "offset": offset,
    "limit": limit,
  };
}

class Region {
  Region({
    required this.id,
    required this.name,
    required this.currencyCode,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.metadata,
    required this.countries,
  });

  final String id;
  final String name;
  final String currencyCode;
  final String createdAt;
  final String updatedAt;
  final dynamic deletedAt;
  final dynamic metadata;
  final List<Country> countries;

  factory Region.fromJson(Map<String, dynamic> json) {
    return Region(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      currencyCode: json["currency_code"] ?? "",
      createdAt: json["created_at"] ?? "",
      updatedAt: json["updated_at"] ?? "",
      deletedAt: json["deleted_at"],
      metadata: json["metadata"],
      countries: json["countries"] == null
          ? []
          : List<Country>.from(
              json["countries"]!.map((x) => Country.fromJson(x)),
            ),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "currency_code": currencyCode,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "deleted_at": deletedAt,
    "metadata": metadata,
    "countries": countries.map((x) => x?.toJson()).toList(),
  };
}

class Country {
  Country({
    required this.iso2,
    required this.iso3,
    required this.numCode,
    required this.name,
    required this.displayName,
    required this.regionId,
    required this.metadata,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  final String iso2;
  final String iso3;
  final String numCode;
  final String name;
  final String displayName;
  final String regionId;
  final dynamic metadata;
  final String createdAt;
  final String updatedAt;
  final dynamic deletedAt;

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      iso2: json["iso_2"] ?? "",
      iso3: json["iso_3"] ?? "",
      numCode: json["num_code"] ?? "",
      name: json["name"] ?? "",
      displayName: json["display_name"] ?? "",
      regionId: json["region_id"] ?? "",
      metadata: json["metadata"],
      createdAt: json["created_at"] ?? "",
      updatedAt: json["updated_at"] ?? "",
      deletedAt: json["deleted_at"],
    );
  }

  Map<String, dynamic> toJson() => {
    "iso_2": iso2,
    "iso_3": iso3,
    "num_code": numCode,
    "name": name,
    "display_name": displayName,
    "region_id": regionId,
    "metadata": metadata,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "deleted_at": deletedAt,
  };
}

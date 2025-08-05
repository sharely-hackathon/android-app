class ProductModel {
  ProductModel({
    required this.products,
    required this.count,
    required this.offset,
    required this.limit,
  });

  final List<Product> products;
  final num count;
  final num offset;
  final num limit;

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      products: json["products"] == null
          ? []
          : List<Product>.from(
              json["products"]!.map((x) => Product.fromJson(x)),
            ),
      count: json["count"] ?? 0,
      offset: json["offset"] ?? 0,
      limit: json["limit"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "products": products.map((x) => x?.toJson()).toList(),
    "count": count,
    "offset": offset,
    "limit": limit,
  };
}

class Product {
  Product({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.handle,
    required this.isGiftcard,
    required this.discountable,
    required this.thumbnail,
    required this.collectionId,
    required this.typeId,
    required this.weight,
    required this.length,
    required this.height,
    required this.width,
    required this.hsCode,
    required this.originCountry,
    required this.midCode,
    required this.material,
    required this.createdAt,
    required this.updatedAt,
    required this.type,
    required this.collection,
    required this.options,
    required this.tags,
    required this.images,
    required this.variants,
    required this.seller,
  });

  final String id;
  final String title;
  final String subtitle;
  final String description;
  final String handle;
  final bool isGiftcard;
  final bool discountable;
  final String thumbnail;
  final String collectionId;
  final dynamic typeId;
  final dynamic weight;
  final dynamic length;
  final dynamic height;
  final dynamic width;
  final dynamic hsCode;
  final dynamic originCountry;
  final dynamic midCode;
  final dynamic material;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic type;
  final Tion? collection;
  final List<OptionsModel> options;
  final List<dynamic> tags;
  final List<ImageModel> images;
  final List<Variant> variants;
  final Seller? seller;
  
  // 基于产品ID生成固定的评分（3.5-5.0）
  double get rating {
    final hash = id.hashCode.abs();
    final normalizedHash = (hash % 1000) / 1000.0;
    return 3.5 + normalizedHash * 1.5;
  }
  
  // 基于产品ID生成固定的评论数量（500-10000）
  int get reviewCount {
    final hash = (id + "reviews").hashCode.abs();
    return 500 + (hash % 9501);
  }
  
  // 基于产品ID生成固定的分享收益百分比（5-12）
  int get shareEarnPercent {
    final hash = (id + "share").hashCode.abs();
    return 5 + (hash % 8);
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["id"] ?? "",
      title: json["title"] ?? "",
      subtitle: json["subtitle"] ?? "",
      description: json["description"] ?? "",
      handle: json["handle"] ?? "",
      isGiftcard: json["is_giftcard"] ?? false,
      discountable: json["discountable"] ?? false,
      thumbnail: json["thumbnail"] ?? "",
      collectionId: json["collection_id"] ?? "",
      typeId: json["type_id"],
      weight: json["weight"],
      length: json["length"],
      height: json["height"],
      width: json["width"],
      hsCode: json["hs_code"],
      originCountry: json["origin_country"],
      midCode: json["mid_code"],
      material: json["material"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      type: json["type"],
      collection: json["collection"] == null
          ? null
          : Tion.fromJson(json["collection"]),
      options: json["options"] == null
          ? []
          : List<OptionsModel>.from(
              json["options"]!.map((x) => OptionsModel.fromJson(x)),
            ),
      tags: json["tags"] == null
          ? []
          : List<dynamic>.from(json["tags"]!.map((x) => x)),
      images: json["images"] == null
          ? []
          : List<ImageModel>.from(json["images"]!.map((x) => ImageModel.fromJson(x))),
      variants: json["variants"] == null
          ? []
          : List<Variant>.from(
              json["variants"]!.map((x) => Variant.fromJson(x)),
            ),
      seller: json["seller"] == null ? null : Seller.fromJson(json["seller"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "subtitle": subtitle,
    "description": description,
    "handle": handle,
    "is_giftcard": isGiftcard,
    "discountable": discountable,
    "thumbnail": thumbnail,
    "collection_id": collectionId,
    "type_id": typeId,
    "weight": weight,
    "length": length,
    "height": height,
    "width": width,
    "hs_code": hsCode,
    "origin_country": originCountry,
    "mid_code": midCode,
    "material": material,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "type": type,
    "collection": collection?.toJson(),
    "options": options.map((x) => x?.toJson()).toList(),
    "tags": tags.map((x) => x).toList(),
    "images": images.map((x) => x?.toJson()).toList(),
    "variants": variants.map((x) => x?.toJson()).toList(),
    "seller": seller?.toJson(),
  };
}

class Tion {
  Tion({
    required this.id,
    required this.title,
    required this.handle,
    required this.metadata,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.productId,
  });

  final String id;
  final String title;
  final String handle;
  final dynamic metadata;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final String productId;

  factory Tion.fromJson(Map<String, dynamic> json) {
    return Tion(
      id: json["id"] ?? "",
      title: json["title"] ?? "",
      handle: json["handle"] ?? "",
      metadata: json["metadata"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      deletedAt: json["deleted_at"],
      productId: json["product_id"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "handle": handle,
    "metadata": metadata,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "product_id": productId,
  };
}

class OptionsModel {
  OptionsModel({
    required this.id,
    required this.title,
    required this.metadata,
    required this.productId,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.values,
  });

  final String id;
  final String title;
  final Metadata? metadata;
  final String productId;
  final String createdAt;
  final String updatedAt;
  final dynamic deletedAt;
  final List<Value> values;

  factory OptionsModel.fromJson(Map<String, dynamic> json) {
    return OptionsModel(
      id: json["id"] ?? "",
      title: json["title"] ?? "",
      metadata: json["metadata"] == null
          ? null
          : Metadata.fromJson(json["metadata"]),
      productId: json["product_id"] ?? "",
      createdAt: json["created_at"] ?? "",
      updatedAt: json["updated_at"] ?? "",
      deletedAt: json["deleted_at"],
      values: json["values"] == null
          ? []
          : List<Value>.from(json["values"]!.map((x) => Value.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "metadata": metadata?.toJson(),
    "product_id": productId,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "deleted_at": deletedAt,
    "values": values.map((x) => x.toJson()).toList(),
  };
}

class Metadata {
  Metadata({required this.hexVal});

  final String hexVal;

  factory Metadata.fromJson(Map<String, dynamic> json) {
    return Metadata(hexVal: json["hexVal"] ?? "");
  }

  Map<String, dynamic> toJson() => {"hexVal": hexVal};
}

class ImageModel {
  ImageModel({
    required this.id,
    required this.url,
    required this.metadata,
    required this.rank,
    required this.productId,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.title,
    required this.values,
  });

  final String id;
  final String url;
  final dynamic metadata;
  final num rank;
  final String productId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final String title;
  final List<Value> values;

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json["id"] ?? "",
      url: json["url"] ?? "",
      metadata: json["metadata"],
      rank: json["rank"] ?? 0,
      productId: json["product_id"] ?? "",
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      deletedAt: json["deleted_at"],
      title: json["title"] ?? "",
      values: json["values"] == null
          ? []
          : List<Value>.from(json["values"]!.map((x) => Value.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "url": url,
    "metadata": metadata,
    "rank": rank,
    "product_id": productId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "title": title,
    "values": values.map((x) => x?.toJson()).toList(),
  };
}

class Value {
  Value({
    required this.id,
    required this.value,
    required this.metadata,
    required this.optionId,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.option,
  });

  final String id;
  final String value;
  final Metadata? metadata;
  final String optionId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final Tion? option;

  factory Value.fromJson(Map<String, dynamic> json) {
    return Value(
      id: json["id"] ?? "",
      value: json["value"] ?? "",
      metadata: json["metadata"] == null
          ? null
          : Metadata.fromJson(json["metadata"]),
      optionId: json["option_id"] ?? "",
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      deletedAt: json["deleted_at"],
      option: json["option"] == null ? null : Tion.fromJson(json["option"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "value": value,
    "metadata": metadata?.toJson(),
    "option_id": optionId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "option": option?.toJson(),
  };
}

class Seller {
  Seller({
    required this.id,
    required this.reviews,
    required this.photo,
    required this.name,
    required this.products,
  });

  final String id;
  final String photo;
  final String name;
  final List<dynamic> reviews;
  final List<SellerProduct> products;

  factory Seller.fromJson(Map<String, dynamic> json) {
    return Seller(
      id: json["id"] ?? "",
      photo: json["photo"] ?? "",
      name: json["name"] ?? "",
      reviews: json["reviews"] == null
          ? []
          : List<dynamic>.from(json["reviews"]!.map((x) => x)),
      products: json["products"] == null
          ? []
          : List<SellerProduct>.from(
              json["products"]!.map((x) => SellerProduct.fromJson(x)),
            ),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "reviews": reviews.map((x) => x).toList(),
    "products": products.map((x) => x?.toJson()).toList(),
  };
}

class SellerProduct {
  SellerProduct({required this.id, required this.variants});

  final String id;
  final List<Variant> variants;

  factory SellerProduct.fromJson(Map<String, dynamic> json) {
    return SellerProduct(
      id: json["id"] ?? "",
      variants: json["variants"] == null
          ? []
          : List<Variant>.from(
              json["variants"]!.map((x) => Variant.fromJson(x)),
            ),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "variants": variants.map((x) => x?.toJson()).toList(),
  };
}

class Variant {
  Variant({
    required this.id,
    required this.title,
    required this.sku,
    required this.barcode,
    required this.ean,
    required this.upc,
    required this.allowBackorder,
    required this.manageInventory,
    required this.hsCode,
    required this.originCountry,
    required this.midCode,
    required this.material,
    required this.weight,
    required this.length,
    required this.height,
    required this.width,
    required this.metadata,
    required this.variantRank,
    required this.productId,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.options,
    required this.calculatedPrice,
    required this.inventoryQuantity,
  });

  final String id;
  final String title;
  final dynamic sku;
  final dynamic barcode;
  final dynamic ean;
  final dynamic upc;
  final bool allowBackorder;
  final bool manageInventory;
  final dynamic hsCode;
  final dynamic originCountry;
  final dynamic midCode;
  final dynamic material;
  final dynamic weight;
  final dynamic length;
  final dynamic height;
  final dynamic width;
  final dynamic metadata;
  final num variantRank;
  final String productId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final List<Value> options;
  final CalculatedPrice? calculatedPrice;
  final num inventoryQuantity;

  factory Variant.fromJson(Map<String, dynamic> json) {
    return Variant(
      id: json["id"] ?? "",
      title: json["title"] ?? "",
      sku: json["sku"],
      barcode: json["barcode"],
      ean: json["ean"],
      upc: json["upc"],
      allowBackorder: json["allow_backorder"] ?? false,
      manageInventory: json["manage_inventory"] ?? false,
      hsCode: json["hs_code"],
      originCountry: json["origin_country"],
      midCode: json["mid_code"],
      material: json["material"],
      weight: json["weight"],
      length: json["length"],
      height: json["height"],
      width: json["width"],
      metadata: json["metadata"],
      variantRank: json["variant_rank"] ?? 0,
      productId: json["product_id"] ?? "",
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      deletedAt: json["deleted_at"],
      options: json["options"] == null
          ? []
          : List<Value>.from(json["options"]!.map((x) => Value.fromJson(x))),
      calculatedPrice: json["calculated_price"] == null
          ? null
          : CalculatedPrice.fromJson(json["calculated_price"]),
      inventoryQuantity: json["inventory_quantity"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "sku": sku,
    "barcode": barcode,
    "ean": ean,
    "upc": upc,
    "allow_backorder": allowBackorder,
    "manage_inventory": manageInventory,
    "hs_code": hsCode,
    "origin_country": originCountry,
    "mid_code": midCode,
    "material": material,
    "weight": weight,
    "length": length,
    "height": height,
    "width": width,
    "metadata": metadata,
    "variant_rank": variantRank,
    "product_id": productId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "options": options.map((x) => x?.toJson()).toList(),
    "calculated_price": calculatedPrice?.toJson(),
    "inventory_quantity": inventoryQuantity,
  };
}

class CalculatedPrice {
  CalculatedPrice({
    required this.id,
    required this.isCalculatedPricePriceList,
    required this.isCalculatedPriceTaxInclusive,
    required this.calculatedAmount,
    required this.rawCalculatedAmount,
    required this.isOriginalPricePriceList,
    required this.isOriginalPriceTaxInclusive,
    required this.originalAmount,
    required this.rawOriginalAmount,
    required this.currencyCode,
    required this.calculatedPrice,
    required this.originalPrice,
  });

  final String id;
  final bool isCalculatedPricePriceList;
  final bool isCalculatedPriceTaxInclusive;
  final num calculatedAmount;
  final RawAmount? rawCalculatedAmount;
  final bool isOriginalPricePriceList;
  final bool isOriginalPriceTaxInclusive;
  final num originalAmount;
  final RawAmount? rawOriginalAmount;
  final String currencyCode;
  final Price? calculatedPrice;
  final Price? originalPrice;

  factory CalculatedPrice.fromJson(Map<String, dynamic> json) {
    return CalculatedPrice(
      id: json["id"] ?? "",
      isCalculatedPricePriceList:
          json["is_calculated_price_price_list"] ?? false,
      isCalculatedPriceTaxInclusive:
          json["is_calculated_price_tax_inclusive"] ?? false,
      calculatedAmount: json["calculated_amount"] ?? 0,
      rawCalculatedAmount: json["raw_calculated_amount"] == null
          ? null
          : RawAmount.fromJson(json["raw_calculated_amount"]),
      isOriginalPricePriceList: json["is_original_price_price_list"] ?? false,
      isOriginalPriceTaxInclusive:
          json["is_original_price_tax_inclusive"] ?? false,
      originalAmount: json["original_amount"] ?? 0,
      rawOriginalAmount: json["raw_original_amount"] == null
          ? null
          : RawAmount.fromJson(json["raw_original_amount"]),
      currencyCode: json["currency_code"] ?? "",
      calculatedPrice: json["calculated_price"] == null
          ? null
          : Price.fromJson(json["calculated_price"]),
      originalPrice: json["original_price"] == null
          ? null
          : Price.fromJson(json["original_price"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "is_calculated_price_price_list": isCalculatedPricePriceList,
    "is_calculated_price_tax_inclusive": isCalculatedPriceTaxInclusive,
    "calculated_amount": calculatedAmount,
    "raw_calculated_amount": rawCalculatedAmount?.toJson(),
    "is_original_price_price_list": isOriginalPricePriceList,
    "is_original_price_tax_inclusive": isOriginalPriceTaxInclusive,
    "original_amount": originalAmount,
    "raw_original_amount": rawOriginalAmount?.toJson(),
    "currency_code": currencyCode,
    "calculated_price": calculatedPrice?.toJson(),
    "original_price": originalPrice?.toJson(),
  };
}

class Price {
  Price({
    required this.id,
    required this.priceListId,
    required this.priceListType,
    required this.minQuantity,
    required this.maxQuantity,
  });

  final String id;
  final String priceListId;
  final String priceListType;
  final dynamic minQuantity;
  final dynamic maxQuantity;

  factory Price.fromJson(Map<String, dynamic> json) {
    return Price(
      id: json["id"] ?? "",
      priceListId: json["price_list_id"] ?? "",
      priceListType: json["price_list_type"] ?? "",
      minQuantity: json["min_quantity"],
      maxQuantity: json["max_quantity"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "price_list_id": priceListId,
    "price_list_type": priceListType,
    "min_quantity": minQuantity,
    "max_quantity": maxQuantity,
  };
}

class RawAmount {
  RawAmount({required this.value, required this.precision});

  final String value;
  final num precision;

  factory RawAmount.fromJson(Map<String, dynamic> json) {
    return RawAmount(
      value: json["value"] ?? "",
      precision: json["precision"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {"value": value, "precision": precision};
}

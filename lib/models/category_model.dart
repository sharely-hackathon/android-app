class CategoryModel {
  CategoryModel({
    required this.productCategories,
    required this.count,
    required this.offset,
    required this.limit,
  });

  final List<ProductCategory> productCategories;
  final num count;
  final num offset;
  final num limit;

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      productCategories: json["product_categories"] == null
          ? []
          : List<ProductCategory>.from(
              json["product_categories"]!.map(
                (x) => ProductCategory.fromJson(x),
              ),
            ),
      count: json["count"] ?? 0,
      offset: json["offset"] ?? 0,
      limit: json["limit"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "product_categories": productCategories.map((x) => x.toJson()).toList(),
    "count": count,
    "offset": offset,
    "limit": limit,
  };
}

class ProductCategory {
  ProductCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.handle,
    required this.rank,
    required this.parentCategoryId,
    required this.createdAt,
    required this.updatedAt,
    required this.metadata,
    required this.parentCategory,
    required this.categoryChildren,
  });

  final String id;
  final String name;
  final String description;
  final String handle;
  final num rank;
  final dynamic parentCategoryId;
  final String createdAt;
  final String updatedAt;
  final Metadata? metadata;
  final dynamic parentCategory;
  final List<dynamic> categoryChildren;

  factory ProductCategory.fromJson(Map<String, dynamic> json) {
    return ProductCategory(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      description: json["description"] ?? "",
      handle: json["handle"] ?? "",
      rank: json["rank"] ?? 0,
      parentCategoryId: json["parent_category_id"],
      createdAt: json["created_at"] ?? "",
      updatedAt: json["updated_at"] ?? "",
      metadata: json["metadata"] == null
          ? null
          : Metadata.fromJson(json["metadata"]),
      parentCategory: json["parent_category"],
      categoryChildren: json["category_children"] == null
          ? []
          : List<dynamic>.from(json["category_children"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "handle": handle,
    "rank": rank,
    "parent_category_id": parentCategoryId,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "metadata": metadata,
    "parent_category": parentCategory,
    "category_children": categoryChildren.map((x) => x).toList(),
  };
}

class Metadata {
  Metadata({required this.thumbnailImage});

  final String thumbnailImage;

  factory Metadata.fromJson(Map<String, dynamic> json) {
    return Metadata(thumbnailImage: json["thumbnail_image"] ?? "");
  }

  Map<String, dynamic> toJson() => {"thumbnail_image": thumbnailImage};
}

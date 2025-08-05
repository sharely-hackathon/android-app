class CartModel {
  CartModel({required this.cart});

  final Cart? cart;

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      cart: json["cart"] == null ? null : Cart.fromJson(json["cart"]),
    );
  }

  Map<String, dynamic> toJson() => {"cart": cart?.toJson()};
}

class Cart {
  Cart({
    required this.id,
    required this.currencyCode,
    required this.email,
    required this.regionId,
    required this.createdAt,
    required this.updatedAt,
    required this.completedAt,
    required this.total,
    required this.subtotal,
    required this.taxTotal,
    required this.discountTotal,
    required this.discountSubtotal,
    required this.discountTaxTotal,
    required this.originalTotal,
    required this.originalTaxTotal,
    required this.itemTotal,
    required this.itemSubtotal,
    required this.itemTaxTotal,
    required this.originalItemTotal,
    required this.originalItemSubtotal,
    required this.originalItemTaxTotal,
    required this.shippingTotal,
    required this.shippingSubtotal,
    required this.shippingTaxTotal,
    required this.originalShippingTaxTotal,
    required this.originalShippingSubtotal,
    required this.originalShippingTotal,
    required this.creditLineSubtotal,
    required this.creditLineTaxTotal,
    required this.creditLineTotal,
    required this.metadata,
    required this.salesChannelId,
    required this.customerId,
    required this.items,
    required this.shippingMethods,
    required this.shippingAddress,
    required this.billingAddress,
    required this.creditLines,
    required this.customer,
    required this.region,
    required this.promotions,
  });

  final String id;
  final String currencyCode;
  final String email;
  final String regionId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic completedAt;
  final num total;
  final num subtotal;
  final num taxTotal;
  final num discountTotal;
  final num discountSubtotal;
  final num discountTaxTotal;
  final num originalTotal;
  final num originalTaxTotal;
  final num itemTotal;
  final num itemSubtotal;
  final num itemTaxTotal;
  final num originalItemTotal;
  final num originalItemSubtotal;
  final num originalItemTaxTotal;
  final num shippingTotal;
  final num shippingSubtotal;
  final num shippingTaxTotal;
  final num originalShippingTaxTotal;
  final num originalShippingSubtotal;
  final num originalShippingTotal;
  final num creditLineSubtotal;
  final num creditLineTaxTotal;
  final num creditLineTotal;
  final dynamic metadata;
  final String salesChannelId;
  final String customerId;
  final List<ItemModel> items;
  final List<dynamic> shippingMethods;
  final dynamic shippingAddress;
  final dynamic billingAddress;
  final List<dynamic> creditLines;
  final Customer? customer;
  final Region? region;
  final List<dynamic> promotions;

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: json["id"] ?? "",
      currencyCode: json["currency_code"] ?? "",
      email: json["email"] ?? "",
      regionId: json["region_id"] ?? "",
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      completedAt: json["completed_at"],
      total: json["total"] ?? 0,
      subtotal: json["subtotal"] ?? 0,
      taxTotal: json["tax_total"] ?? 0,
      discountTotal: json["discount_total"] ?? 0,
      discountSubtotal: json["discount_subtotal"] ?? 0,
      discountTaxTotal: json["discount_tax_total"] ?? 0,
      originalTotal: json["original_total"] ?? 0,
      originalTaxTotal: json["original_tax_total"] ?? 0,
      itemTotal: json["item_total"] ?? 0,
      itemSubtotal: json["item_subtotal"] ?? 0,
      itemTaxTotal: json["item_tax_total"] ?? 0,
      originalItemTotal: json["original_item_total"] ?? 0,
      originalItemSubtotal: json["original_item_subtotal"] ?? 0,
      originalItemTaxTotal: json["original_item_tax_total"] ?? 0,
      shippingTotal: json["shipping_total"] ?? 0,
      shippingSubtotal: json["shipping_subtotal"] ?? 0,
      shippingTaxTotal: json["shipping_tax_total"] ?? 0,
      originalShippingTaxTotal: json["original_shipping_tax_total"] ?? 0,
      originalShippingSubtotal: json["original_shipping_subtotal"] ?? 0,
      originalShippingTotal: json["original_shipping_total"] ?? 0,
      creditLineSubtotal: json["credit_line_subtotal"] ?? 0,
      creditLineTaxTotal: json["credit_line_tax_total"] ?? 0,
      creditLineTotal: json["credit_line_total"] ?? 0,
      metadata: json["metadata"],
      salesChannelId: json["sales_channel_id"] ?? "",
      customerId: json["customer_id"] ?? "",
      items: json["items"] == null
          ? []
          : List<ItemModel>.from(
              json["items"]!.map((x) => ItemModel.fromJson(x)),
            ),
      shippingMethods: json["shipping_methods"] == null
          ? []
          : List<dynamic>.from(json["shipping_methods"]!.map((x) => x)),
      shippingAddress: json["shipping_address"],
      billingAddress: json["billing_address"],
      creditLines: json["credit_lines"] == null
          ? []
          : List<dynamic>.from(json["credit_lines"]!.map((x) => x)),
      customer: json["customer"] == null
          ? null
          : Customer.fromJson(json["customer"]),
      region: json["region"] == null ? null : Region.fromJson(json["region"]),
      promotions: json["promotions"] == null
          ? []
          : List<dynamic>.from(json["promotions"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "currency_code": currencyCode,
    "email": email,
    "region_id": regionId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "completed_at": completedAt,
    "total": total,
    "subtotal": subtotal,
    "tax_total": taxTotal,
    "discount_total": discountTotal,
    "discount_subtotal": discountSubtotal,
    "discount_tax_total": discountTaxTotal,
    "original_total": originalTotal,
    "original_tax_total": originalTaxTotal,
    "item_total": itemTotal,
    "item_subtotal": itemSubtotal,
    "item_tax_total": itemTaxTotal,
    "original_item_total": originalItemTotal,
    "original_item_subtotal": originalItemSubtotal,
    "original_item_tax_total": originalItemTaxTotal,
    "shipping_total": shippingTotal,
    "shipping_subtotal": shippingSubtotal,
    "shipping_tax_total": shippingTaxTotal,
    "original_shipping_tax_total": originalShippingTaxTotal,
    "original_shipping_subtotal": originalShippingSubtotal,
    "original_shipping_total": originalShippingTotal,
    "credit_line_subtotal": creditLineSubtotal,
    "credit_line_tax_total": creditLineTaxTotal,
    "credit_line_total": creditLineTotal,
    "metadata": metadata,
    "sales_channel_id": salesChannelId,
    "customer_id": customerId,
    "items": items.map((x) => x?.toJson()).toList(),
    "shipping_methods": shippingMethods.map((x) => x).toList(),
    "shipping_address": shippingAddress,
    "billing_address": billingAddress,
    "credit_lines": creditLines.map((x) => x).toList(),
    "customer": customer?.toJson(),
    "region": region?.toJson(),
    "promotions": promotions.map((x) => x).toList(),
  };
}

class Customer {
  Customer({required this.id, required this.email, required this.groups});

  final String id;
  final String email;
  final List<dynamic> groups;

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json["id"] ?? "",
      email: json["email"] ?? "",
      groups: json["groups"] == null
          ? []
          : List<dynamic>.from(json["groups"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "groups": groups.map((x) => x).toList(),
  };
}

class ItemModel {
  ItemModel({
    required this.id,
    required this.thumbnail,
    required this.variantId,
    required this.productId,
    required this.productTypeId,
    required this.productTitle,
    required this.productDescription,
    required this.productSubtitle,
    required this.productType,
    required this.productCollection,
    required this.productHandle,
    required this.variantSku,
    required this.variantBarcode,
    required this.variantTitle,
    required this.requiresShipping,
    required this.metadata,
    required this.createdAt,
    required this.updatedAt,
    required this.title,
    required this.quantity,
    required this.unitPrice,
    required this.compareAtUnitPrice,
    required this.isTaxInclusive,
    required this.taxLines,
    required this.adjustments,
    required this.product,
  });

  final String id;
  final String thumbnail;
  final String variantId;
  final String productId;
  final dynamic productTypeId;
  final String productTitle;
  final String productDescription;
  final String productSubtitle;
  final dynamic productType;
  final String productCollection;
  final String productHandle;
  final dynamic variantSku;
  final dynamic variantBarcode;
  final String variantTitle;
  final bool requiresShipping;
  final Metadata? metadata;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String title;
  num quantity;
  final num unitPrice;
  final num compareAtUnitPrice;
  final bool isTaxInclusive;
  final List<dynamic> taxLines;
  final List<dynamic> adjustments;
  final ProductCartModel? product;

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json["id"] ?? "",
      thumbnail: json["thumbnail"] ?? "",
      variantId: json["variant_id"] ?? "",
      productId: json["product_id"] ?? "",
      productTypeId: json["product_type_id"],
      productTitle: json["product_title"] ?? "",
      productDescription: json["product_description"] ?? "",
      productSubtitle: json["product_subtitle"] ?? "",
      productType: json["product_type"],
      productCollection: json["product_collection"] ?? "",
      productHandle: json["product_handle"] ?? "",
      variantSku: json["variant_sku"],
      variantBarcode: json["variant_barcode"],
      variantTitle: json["variant_title"] ?? "",
      requiresShipping: json["requires_shipping"] ?? false,
      metadata: json["metadata"] == null
          ? null
          : Metadata.fromJson(json["metadata"]),
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      title: json["title"] ?? "",
      quantity: json["quantity"] ?? 0,
      unitPrice: json["unit_price"] ?? 0,
      compareAtUnitPrice: json["compare_at_unit_price"] ?? 0,
      isTaxInclusive: json["is_tax_inclusive"] ?? false,
      taxLines: json["tax_lines"] == null
          ? []
          : List<dynamic>.from(json["tax_lines"]!.map((x) => x)),
      adjustments: json["adjustments"] == null
          ? []
          : List<dynamic>.from(json["adjustments"]!.map((x) => x)),
      product: json["product"] == null
          ? null
          : ProductCartModel.fromJson(json["product"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "thumbnail": thumbnail,
    "variant_id": variantId,
    "product_id": productId,
    "product_type_id": productTypeId,
    "product_title": productTitle,
    "product_description": productDescription,
    "product_subtitle": productSubtitle,
    "product_type": productType,
    "product_collection": productCollection,
    "product_handle": productHandle,
    "variant_sku": variantSku,
    "variant_barcode": variantBarcode,
    "variant_title": variantTitle,
    "requires_shipping": requiresShipping,
    "metadata": metadata?.toJson(),
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "title": title,
    "quantity": quantity,
    "unit_price": unitPrice,
    "compare_at_unit_price": compareAtUnitPrice,
    "is_tax_inclusive": isTaxInclusive,
    "tax_lines": taxLines.map((x) => x).toList(),
    "adjustments": adjustments.map((x) => x).toList(),
    "product": product?.toJson(),
  };
}

class Metadata {
  Metadata({required this.json});

  final Map<String, dynamic> json;

  factory Metadata.fromJson(Map<String, dynamic> json) {
    return Metadata(json: json);
  }

  Map<String, dynamic> toJson() => {};
}

class ProductCartModel {
  ProductCartModel({
    required this.id,
    required this.collectionId,
    required this.typeId,
    required this.categories,
    required this.tags,
  });

  final String id;
  final String collectionId;
  final dynamic typeId;
  final List<Category> categories;
  final List<dynamic> tags;

  factory ProductCartModel.fromJson(Map<String, dynamic> json) {
    return ProductCartModel(
      id: json["id"] ?? "",
      collectionId: json["collection_id"] ?? "",
      typeId: json["type_id"],
      categories: json["categories"] == null
          ? []
          : List<Category>.from(
              json["categories"]!.map((x) => Category.fromJson(x)),
            ),
      tags: json["tags"] == null
          ? []
          : List<dynamic>.from(json["tags"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "collection_id": collectionId,
    "type_id": typeId,
    "categories": categories.map((x) => x?.toJson()).toList(),
    "tags": tags.map((x) => x).toList(),
  };
}

class Category {
  Category({required this.id});

  final String id;

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(id: json["id"] ?? "");
  }

  Map<String, dynamic> toJson() => {"id": id};
}

class Region {
  Region({
    required this.id,
    required this.name,
    required this.currencyCode,
    required this.automaticTaxes,
    required this.countries,
  });

  final String id;
  final String name;
  final String currencyCode;
  final bool automaticTaxes;
  final List<Country> countries;

  factory Region.fromJson(Map<String, dynamic> json) {
    return Region(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      currencyCode: json["currency_code"] ?? "",
      automaticTaxes: json["automatic_taxes"] ?? false,
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
    "automatic_taxes": automaticTaxes,
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
  final DateTime? createdAt;
  final DateTime? updatedAt;
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
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
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
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
  };
}

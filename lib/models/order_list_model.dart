class OrderListModel {
  OrderListModel({
    required this.orders,
    required this.count,
    required this.offset,
    required this.limit,
  });

  final List<Order> orders;
  final num count;
  final num offset;
  final num limit;

  factory OrderListModel.fromJson(Map<String, dynamic> json) {
    return OrderListModel(
      orders: json["orders"] == null
          ? []
          : List<Order>.from(json["orders"]!.map((x) => Order.fromJson(x))),
      count: json["count"] ?? 0,
      offset: json["offset"] ?? 0,
      limit: json["limit"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "orders": orders.map((x) => x?.toJson()).toList(),
    "count": count,
    "offset": offset,
    "limit": limit,
  };
}

class Order {
  Order({
    required this.id,
    required this.status,
    required this.summary,
    required this.displayId,
    required this.total,
    required this.currencyCode,
    required this.metadata,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
    required this.items,
    required this.paymentStatus,
    required this.fulfillmentStatus,
    required this.seller,
  });

  final String id;
  final String status;
  final Summary? summary;
  final int displayId;
  final num total;
  final String currencyCode;
  final dynamic metadata;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final num version;
  final List<Item> items;
  final Seller? seller;
  final String paymentStatus;
  final String fulfillmentStatus;

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json["id"] ?? "",
      status: json["status"] ?? "",
      summary: json["summary"] == null
          ? null
          : Summary.fromJson(json["summary"]),
      displayId: json["display_id"] ?? 0,
      total: json["total"] ?? 0,
      currencyCode: json["currency_code"] ?? "",
      metadata: json["metadata"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      version: json["version"] ?? 0,
      items: json["items"] == null
          ? []
          : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
      paymentStatus: json["payment_status"] ?? "",
      fulfillmentStatus: json["fulfillment_status"] ?? "",
      seller: json["seller"] == null ? null : Seller.fromJson(json["seller"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "status": status,
    "summary": summary?.toJson(),
    "display_id": displayId,
    "total": total,
    "currency_code": currencyCode,
    "metadata": metadata,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "version": version,
    "items": items.map((x) => x?.toJson()).toList(),
    "payment_status": paymentStatus,
    "fulfillment_status": fulfillmentStatus,
  };
}

class Item {
  Item({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.thumbnail,
    required this.variantId,
    required this.productId,
    required this.productTitle,
    required this.productDescription,
    required this.productSubtitle,
    required this.productType,
    required this.productTypeId,
    required this.productCollection,
    required this.productHandle,
    required this.variantSku,
    required this.variantBarcode,
    required this.variantTitle,
    required this.variantOptionValues,
    required this.requiresShipping,
    required this.isGiftcard,
    required this.isDiscountable,
    required this.isTaxInclusive,
    required this.isCustomPrice,
    required this.metadata,
    required this.rawCompareAtUnitPrice,
    required this.rawUnitPrice,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.taxLines,
    required this.adjustments,
    required this.compareAtUnitPrice,
    required this.unitPrice,
    required this.quantity,
    required this.rawQuantity,
    required this.detail,
    required this.subtotal,
    required this.total,
    required this.originalTotal,
    required this.discountTotal,
    required this.discountSubtotal,
    required this.discountTaxTotal,
    required this.taxTotal,
    required this.originalTaxTotal,
    required this.refundableTotalPerUnit,
    required this.refundableTotal,
    required this.fulfilledTotal,
    required this.shippedTotal,
    required this.returnRequestedTotal,
    required this.returnReceivedTotal,
    required this.returnDismissedTotal,
    required this.writeOffTotal,
    required this.rawSubtotal,
    required this.rawTotal,
    required this.rawOriginalTotal,
    required this.rawDiscountTotal,
    required this.rawDiscountSubtotal,
    required this.rawDiscountTaxTotal,
    required this.rawTaxTotal,
    required this.rawOriginalTaxTotal,
    required this.rawRefundableTotalPerUnit,
    required this.rawRefundableTotal,
    required this.rawFulfilledTotal,
    required this.rawShippedTotal,
    required this.rawReturnRequestedTotal,
    required this.rawReturnReceivedTotal,
    required this.rawReturnDismissedTotal,
    required this.rawWriteOffTotal,
  });

  final String id;
  final String title;
  final String subtitle;
  final String thumbnail;
  final String variantId;
  final String productId;
  final String productTitle;
  final String productDescription;
  final String productSubtitle;
  final dynamic productType;
  final dynamic productTypeId;
  final String productCollection;
  final String productHandle;
  final dynamic variantSku;
  final dynamic variantBarcode;
  final String variantTitle;
  final dynamic variantOptionValues;
  final bool requiresShipping;
  final bool isGiftcard;
  final bool isDiscountable;
  final bool isTaxInclusive;
  final bool isCustomPrice;
  final Metadata? metadata;
  final Raw? rawCompareAtUnitPrice;
  final Raw? rawUnitPrice;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final List<dynamic> taxLines;
  final List<dynamic> adjustments;
  final num compareAtUnitPrice;
  final num unitPrice;
  final num quantity;
  final Raw? rawQuantity;
  final Detail? detail;
  final num subtotal;
  final num total;
  final num originalTotal;
  final num discountTotal;
  final num discountSubtotal;
  final num discountTaxTotal;
  final num taxTotal;
  final num originalTaxTotal;
  final num refundableTotalPerUnit;
  final num refundableTotal;
  final num fulfilledTotal;
  final num shippedTotal;
  final num returnRequestedTotal;
  final num returnReceivedTotal;
  final num returnDismissedTotal;
  final num writeOffTotal;
  final Raw? rawSubtotal;
  final Raw? rawTotal;
  final Raw? rawOriginalTotal;
  final Raw? rawDiscountTotal;
  final Raw? rawDiscountSubtotal;
  final Raw? rawDiscountTaxTotal;
  final Raw? rawTaxTotal;
  final Raw? rawOriginalTaxTotal;
  final Raw? rawRefundableTotalPerUnit;
  final Raw? rawRefundableTotal;
  final Raw? rawFulfilledTotal;
  final Raw? rawShippedTotal;
  final Raw? rawReturnRequestedTotal;
  final Raw? rawReturnReceivedTotal;
  final Raw? rawReturnDismissedTotal;
  final Raw? rawWriteOffTotal;

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json["id"] ?? "",
      title: json["title"] ?? "",
      subtitle: json["subtitle"] ?? "",
      thumbnail: json["thumbnail"] ?? "",
      variantId: json["variant_id"] ?? "",
      productId: json["product_id"] ?? "",
      productTitle: json["product_title"] ?? "",
      productDescription: json["product_description"] ?? "",
      productSubtitle: json["product_subtitle"] ?? "",
      productType: json["product_type"],
      productTypeId: json["product_type_id"],
      productCollection: json["product_collection"] ?? "",
      productHandle: json["product_handle"] ?? "",
      variantSku: json["variant_sku"],
      variantBarcode: json["variant_barcode"],
      variantTitle: json["variant_title"] ?? "",
      variantOptionValues: json["variant_option_values"],
      requiresShipping: json["requires_shipping"] ?? false,
      isGiftcard: json["is_giftcard"] ?? false,
      isDiscountable: json["is_discountable"] ?? false,
      isTaxInclusive: json["is_tax_inclusive"] ?? false,
      isCustomPrice: json["is_custom_price"] ?? false,
      metadata: json["metadata"] == null
          ? null
          : Metadata.fromJson(json["metadata"]),
      rawCompareAtUnitPrice: json["raw_compare_at_unit_price"] == null
          ? null
          : Raw.fromJson(json["raw_compare_at_unit_price"]),
      rawUnitPrice: json["raw_unit_price"] == null
          ? null
          : Raw.fromJson(json["raw_unit_price"]),
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      deletedAt: json["deleted_at"],
      taxLines: json["tax_lines"] == null
          ? []
          : List<dynamic>.from(json["tax_lines"]!.map((x) => x)),
      adjustments: json["adjustments"] == null
          ? []
          : List<dynamic>.from(json["adjustments"]!.map((x) => x)),
      compareAtUnitPrice: json["compare_at_unit_price"] ?? 0,
      unitPrice: json["unit_price"] ?? 0,
      quantity: json["quantity"] ?? 0,
      rawQuantity: json["raw_quantity"] == null
          ? null
          : Raw.fromJson(json["raw_quantity"]),
      detail: json["detail"] == null ? null : Detail.fromJson(json["detail"]),
      subtotal: json["subtotal"] ?? 0,
      total: json["total"] ?? 0,
      originalTotal: json["original_total"] ?? 0,
      discountTotal: json["discount_total"] ?? 0,
      discountSubtotal: json["discount_subtotal"] ?? 0,
      discountTaxTotal: json["discount_tax_total"] ?? 0,
      taxTotal: json["tax_total"] ?? 0,
      originalTaxTotal: json["original_tax_total"] ?? 0,
      refundableTotalPerUnit: json["refundable_total_per_unit"] ?? 0,
      refundableTotal: json["refundable_total"] ?? 0,
      fulfilledTotal: json["fulfilled_total"] ?? 0,
      shippedTotal: json["shipped_total"] ?? 0,
      returnRequestedTotal: json["return_requested_total"] ?? 0,
      returnReceivedTotal: json["return_received_total"] ?? 0,
      returnDismissedTotal: json["return_dismissed_total"] ?? 0,
      writeOffTotal: json["write_off_total"] ?? 0,
      rawSubtotal: json["raw_subtotal"] == null
          ? null
          : Raw.fromJson(json["raw_subtotal"]),
      rawTotal: json["raw_total"] == null
          ? null
          : Raw.fromJson(json["raw_total"]),
      rawOriginalTotal: json["raw_original_total"] == null
          ? null
          : Raw.fromJson(json["raw_original_total"]),
      rawDiscountTotal: json["raw_discount_total"] == null
          ? null
          : Raw.fromJson(json["raw_discount_total"]),
      rawDiscountSubtotal: json["raw_discount_subtotal"] == null
          ? null
          : Raw.fromJson(json["raw_discount_subtotal"]),
      rawDiscountTaxTotal: json["raw_discount_tax_total"] == null
          ? null
          : Raw.fromJson(json["raw_discount_tax_total"]),
      rawTaxTotal: json["raw_tax_total"] == null
          ? null
          : Raw.fromJson(json["raw_tax_total"]),
      rawOriginalTaxTotal: json["raw_original_tax_total"] == null
          ? null
          : Raw.fromJson(json["raw_original_tax_total"]),
      rawRefundableTotalPerUnit: json["raw_refundable_total_per_unit"] == null
          ? null
          : Raw.fromJson(json["raw_refundable_total_per_unit"]),
      rawRefundableTotal: json["raw_refundable_total"] == null
          ? null
          : Raw.fromJson(json["raw_refundable_total"]),
      rawFulfilledTotal: json["raw_fulfilled_total"] == null
          ? null
          : Raw.fromJson(json["raw_fulfilled_total"]),
      rawShippedTotal: json["raw_shipped_total"] == null
          ? null
          : Raw.fromJson(json["raw_shipped_total"]),
      rawReturnRequestedTotal: json["raw_return_requested_total"] == null
          ? null
          : Raw.fromJson(json["raw_return_requested_total"]),
      rawReturnReceivedTotal: json["raw_return_received_total"] == null
          ? null
          : Raw.fromJson(json["raw_return_received_total"]),
      rawReturnDismissedTotal: json["raw_return_dismissed_total"] == null
          ? null
          : Raw.fromJson(json["raw_return_dismissed_total"]),
      rawWriteOffTotal: json["raw_write_off_total"] == null
          ? null
          : Raw.fromJson(json["raw_write_off_total"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "subtitle": subtitle,
    "thumbnail": thumbnail,
    "variant_id": variantId,
    "product_id": productId,
    "product_title": productTitle,
    "product_description": productDescription,
    "product_subtitle": productSubtitle,
    "product_type": productType,
    "product_type_id": productTypeId,
    "product_collection": productCollection,
    "product_handle": productHandle,
    "variant_sku": variantSku,
    "variant_barcode": variantBarcode,
    "variant_title": variantTitle,
    "variant_option_values": variantOptionValues,
    "requires_shipping": requiresShipping,
    "is_giftcard": isGiftcard,
    "is_discountable": isDiscountable,
    "is_tax_inclusive": isTaxInclusive,
    "is_custom_price": isCustomPrice,
    "metadata": metadata?.toJson(),
    "raw_compare_at_unit_price": rawCompareAtUnitPrice?.toJson(),
    "raw_unit_price": rawUnitPrice?.toJson(),
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "tax_lines": taxLines.map((x) => x).toList(),
    "adjustments": adjustments.map((x) => x).toList(),
    "compare_at_unit_price": compareAtUnitPrice,
    "unit_price": unitPrice,
    "quantity": quantity,
    "raw_quantity": rawQuantity?.toJson(),
    "detail": detail?.toJson(),
    "subtotal": subtotal,
    "total": total,
    "original_total": originalTotal,
    "discount_total": discountTotal,
    "discount_subtotal": discountSubtotal,
    "discount_tax_total": discountTaxTotal,
    "tax_total": taxTotal,
    "original_tax_total": originalTaxTotal,
    "refundable_total_per_unit": refundableTotalPerUnit,
    "refundable_total": refundableTotal,
    "fulfilled_total": fulfilledTotal,
    "shipped_total": shippedTotal,
    "return_requested_total": returnRequestedTotal,
    "return_received_total": returnReceivedTotal,
    "return_dismissed_total": returnDismissedTotal,
    "write_off_total": writeOffTotal,
    "raw_subtotal": rawSubtotal?.toJson(),
    "raw_total": rawTotal?.toJson(),
    "raw_original_total": rawOriginalTotal?.toJson(),
    "raw_discount_total": rawDiscountTotal?.toJson(),
    "raw_discount_subtotal": rawDiscountSubtotal?.toJson(),
    "raw_discount_tax_total": rawDiscountTaxTotal?.toJson(),
    "raw_tax_total": rawTaxTotal?.toJson(),
    "raw_original_tax_total": rawOriginalTaxTotal?.toJson(),
    "raw_refundable_total_per_unit": rawRefundableTotalPerUnit?.toJson(),
    "raw_refundable_total": rawRefundableTotal?.toJson(),
    "raw_fulfilled_total": rawFulfilledTotal?.toJson(),
    "raw_shipped_total": rawShippedTotal?.toJson(),
    "raw_return_requested_total": rawReturnRequestedTotal?.toJson(),
    "raw_return_received_total": rawReturnReceivedTotal?.toJson(),
    "raw_return_dismissed_total": rawReturnDismissedTotal?.toJson(),
    "raw_write_off_total": rawWriteOffTotal?.toJson(),
  };
}

class Detail {
  Detail({
    required this.id,
    required this.version,
    required this.metadata,
    required this.orderId,
    required this.rawUnitPrice,
    required this.rawCompareAtUnitPrice,
    required this.rawQuantity,
    required this.rawFulfilledQuantity,
    required this.rawDeliveredQuantity,
    required this.rawShippedQuantity,
    required this.rawReturnRequestedQuantity,
    required this.rawReturnReceivedQuantity,
    required this.rawReturnDismissedQuantity,
    required this.rawWrittenOffQuantity,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.itemId,
    required this.unitPrice,
    required this.compareAtUnitPrice,
    required this.quantity,
    required this.fulfilledQuantity,
    required this.deliveredQuantity,
    required this.shippedQuantity,
    required this.returnRequestedQuantity,
    required this.returnReceivedQuantity,
    required this.returnDismissedQuantity,
    required this.writtenOffQuantity,
  });

  final String id;
  final num version;
  final dynamic metadata;
  final String orderId;
  final dynamic rawUnitPrice;
  final dynamic rawCompareAtUnitPrice;
  final Raw? rawQuantity;
  final Raw? rawFulfilledQuantity;
  final Raw? rawDeliveredQuantity;
  final Raw? rawShippedQuantity;
  final Raw? rawReturnRequestedQuantity;
  final Raw? rawReturnReceivedQuantity;
  final Raw? rawReturnDismissedQuantity;
  final Raw? rawWrittenOffQuantity;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final String itemId;
  final dynamic unitPrice;
  final dynamic compareAtUnitPrice;
  final num quantity;
  final num fulfilledQuantity;
  final num deliveredQuantity;
  final num shippedQuantity;
  final num returnRequestedQuantity;
  final num returnReceivedQuantity;
  final num returnDismissedQuantity;
  final num writtenOffQuantity;

  factory Detail.fromJson(Map<String, dynamic> json) {
    return Detail(
      id: json["id"] ?? "",
      version: json["version"] ?? 0,
      metadata: json["metadata"],
      orderId: json["order_id"] ?? "",
      rawUnitPrice: json["raw_unit_price"],
      rawCompareAtUnitPrice: json["raw_compare_at_unit_price"],
      rawQuantity: json["raw_quantity"] == null
          ? null
          : Raw.fromJson(json["raw_quantity"]),
      rawFulfilledQuantity: json["raw_fulfilled_quantity"] == null
          ? null
          : Raw.fromJson(json["raw_fulfilled_quantity"]),
      rawDeliveredQuantity: json["raw_delivered_quantity"] == null
          ? null
          : Raw.fromJson(json["raw_delivered_quantity"]),
      rawShippedQuantity: json["raw_shipped_quantity"] == null
          ? null
          : Raw.fromJson(json["raw_shipped_quantity"]),
      rawReturnRequestedQuantity: json["raw_return_requested_quantity"] == null
          ? null
          : Raw.fromJson(json["raw_return_requested_quantity"]),
      rawReturnReceivedQuantity: json["raw_return_received_quantity"] == null
          ? null
          : Raw.fromJson(json["raw_return_received_quantity"]),
      rawReturnDismissedQuantity: json["raw_return_dismissed_quantity"] == null
          ? null
          : Raw.fromJson(json["raw_return_dismissed_quantity"]),
      rawWrittenOffQuantity: json["raw_written_off_quantity"] == null
          ? null
          : Raw.fromJson(json["raw_written_off_quantity"]),
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      deletedAt: json["deleted_at"],
      itemId: json["item_id"] ?? "",
      unitPrice: json["unit_price"],
      compareAtUnitPrice: json["compare_at_unit_price"],
      quantity: json["quantity"] ?? 0,
      fulfilledQuantity: json["fulfilled_quantity"] ?? 0,
      deliveredQuantity: json["delivered_quantity"] ?? 0,
      shippedQuantity: json["shipped_quantity"] ?? 0,
      returnRequestedQuantity: json["return_requested_quantity"] ?? 0,
      returnReceivedQuantity: json["return_received_quantity"] ?? 0,
      returnDismissedQuantity: json["return_dismissed_quantity"] ?? 0,
      writtenOffQuantity: json["written_off_quantity"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "version": version,
    "metadata": metadata,
    "order_id": orderId,
    "raw_unit_price": rawUnitPrice,
    "raw_compare_at_unit_price": rawCompareAtUnitPrice,
    "raw_quantity": rawQuantity?.toJson(),
    "raw_fulfilled_quantity": rawFulfilledQuantity?.toJson(),
    "raw_delivered_quantity": rawDeliveredQuantity?.toJson(),
    "raw_shipped_quantity": rawShippedQuantity?.toJson(),
    "raw_return_requested_quantity": rawReturnRequestedQuantity?.toJson(),
    "raw_return_received_quantity": rawReturnReceivedQuantity?.toJson(),
    "raw_return_dismissed_quantity": rawReturnDismissedQuantity?.toJson(),
    "raw_written_off_quantity": rawWrittenOffQuantity?.toJson(),
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "item_id": itemId,
    "unit_price": unitPrice,
    "compare_at_unit_price": compareAtUnitPrice,
    "quantity": quantity,
    "fulfilled_quantity": fulfilledQuantity,
    "delivered_quantity": deliveredQuantity,
    "shipped_quantity": shippedQuantity,
    "return_requested_quantity": returnRequestedQuantity,
    "return_received_quantity": returnReceivedQuantity,
    "return_dismissed_quantity": returnDismissedQuantity,
    "written_off_quantity": writtenOffQuantity,
  };
}

class Raw {
  Raw({required this.value, required this.precision});

  final String value;
  final num precision;

  factory Raw.fromJson(Map<String, dynamic> json) {
    return Raw(value: json["value"] ?? "", precision: json["precision"] ?? 0);
  }

  Map<String, dynamic> toJson() => {"value": value, "precision": precision};
}

class Metadata {
  Metadata({
    required this.addedAt,
    required this.trackingCode,
    required this.utmDeviceId,
    required this.utmSessionId,
    required this.utmTrackedAt,
    required this.addedToCartWithUtm,
  });

  final DateTime? addedAt;
  final String trackingCode;
  final String utmDeviceId;
  final String utmSessionId;
  final DateTime? utmTrackedAt;
  final bool addedToCartWithUtm;

  factory Metadata.fromJson(Map<String, dynamic> json) {
    return Metadata(
      addedAt: DateTime.tryParse(json["added_at"] ?? ""),
      trackingCode: json["tracking_code"] ?? "",
      utmDeviceId: json["utm_device_id"] ?? "",
      utmSessionId: json["utm_session_id"] ?? "",
      utmTrackedAt: DateTime.tryParse(json["utm_tracked_at"] ?? ""),
      addedToCartWithUtm: json["added_to_cart_with_utm"] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    "added_at": addedAt?.toIso8601String(),
    "tracking_code": trackingCode,
    "utm_device_id": utmDeviceId,
    "utm_session_id": utmSessionId,
    "utm_tracked_at": utmTrackedAt?.toIso8601String(),
    "added_to_cart_with_utm": addedToCartWithUtm,
  };
}

class Summary {
  Summary({
    required this.paidTotal,
    required this.rawPaidTotal,
    required this.refundedTotal,
    required this.accountingTotal,
    required this.creditLineTotal,
    required this.transactionTotal,
    required this.pendingDifference,
    required this.rawRefundedTotal,
    required this.currentOrderTotal,
    required this.originalOrderTotal,
    required this.rawAccountingTotal,
    required this.rawCreditLineTotal,
    required this.rawTransactionTotal,
    required this.rawPendingDifference,
    required this.rawCurrentOrderTotal,
    required this.rawOriginalOrderTotal,
  });

  final int paidTotal;
  final Raw? rawPaidTotal;
  final num refundedTotal;
  final num accountingTotal;
  final num creditLineTotal;
  final num transactionTotal;
  final num pendingDifference;
  final Raw? rawRefundedTotal;
  final num currentOrderTotal;
  final num originalOrderTotal;
  final Raw? rawAccountingTotal;
  final Raw? rawCreditLineTotal;
  final Raw? rawTransactionTotal;
  final Raw? rawPendingDifference;
  final Raw? rawCurrentOrderTotal;
  final Raw? rawOriginalOrderTotal;

  factory Summary.fromJson(Map<String, dynamic> json) {
    return Summary(
      paidTotal: json["paid_total"] ?? 0,
      rawPaidTotal: json["raw_paid_total"] == null
          ? null
          : Raw.fromJson(json["raw_paid_total"]),
      refundedTotal: json["refunded_total"] ?? 0,
      accountingTotal: json["accounting_total"] ?? 0,
      creditLineTotal: json["credit_line_total"] ?? 0,
      transactionTotal: json["transaction_total"] ?? 0,
      pendingDifference: json["pending_difference"] ?? 0,
      rawRefundedTotal: json["raw_refunded_total"] == null
          ? null
          : Raw.fromJson(json["raw_refunded_total"]),
      currentOrderTotal: json["current_order_total"] ?? 0,
      originalOrderTotal: json["original_order_total"] ?? 0,
      rawAccountingTotal: json["raw_accounting_total"] == null
          ? null
          : Raw.fromJson(json["raw_accounting_total"]),
      rawCreditLineTotal: json["raw_credit_line_total"] == null
          ? null
          : Raw.fromJson(json["raw_credit_line_total"]),
      rawTransactionTotal: json["raw_transaction_total"] == null
          ? null
          : Raw.fromJson(json["raw_transaction_total"]),
      rawPendingDifference: json["raw_pending_difference"] == null
          ? null
          : Raw.fromJson(json["raw_pending_difference"]),
      rawCurrentOrderTotal: json["raw_current_order_total"] == null
          ? null
          : Raw.fromJson(json["raw_current_order_total"]),
      rawOriginalOrderTotal: json["raw_original_order_total"] == null
          ? null
          : Raw.fromJson(json["raw_original_order_total"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "paid_total": paidTotal,
    "raw_paid_total": rawPaidTotal?.toJson(),
    "refunded_total": refundedTotal,
    "accounting_total": accountingTotal,
    "credit_line_total": creditLineTotal,
    "transaction_total": transactionTotal,
    "pending_difference": pendingDifference,
    "raw_refunded_total": rawRefundedTotal?.toJson(),
    "current_order_total": currentOrderTotal,
    "original_order_total": originalOrderTotal,
    "raw_accounting_total": rawAccountingTotal?.toJson(),
    "raw_credit_line_total": rawCreditLineTotal?.toJson(),
    "raw_transaction_total": rawTransactionTotal?.toJson(),
    "raw_pending_difference": rawPendingDifference?.toJson(),
    "raw_current_order_total": rawCurrentOrderTotal?.toJson(),
    "raw_original_order_total": rawOriginalOrderTotal?.toJson(),
  };
}

class Seller {
  Seller({
    required this.id,
    required this.photo,
    required this.name,
  });

  final String id;
  final String photo;
  final String name;

  factory Seller.fromJson(Map<String, dynamic> json) {
    return Seller(
      id: json["id"] ?? "",
      photo: json["photo"] ?? "",
      name: json["name"] ?? "",
    );
  }
}

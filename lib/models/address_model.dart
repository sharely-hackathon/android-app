class AddressModel {
  AddressModel({
    required this.addresses,
    required this.count,
    required this.offset,
    required this.limit,
  });

  final List<Address> addresses;
  final num count;
  final num offset;
  final num limit;

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      addresses: json["addresses"] == null
          ? []
          : List<Address>.from(
              json["addresses"]!.map((x) => Address.fromJson(x)),
            ),
      count: json["count"] ?? 0,
      offset: json["offset"] ?? 0,
      limit: json["limit"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "addresses": addresses.map((x) => x?.toJson()).toList(),
    "count": count,
    "offset": offset,
    "limit": limit,
  };
}

class Address {
  Address({
    required this.id,
    required this.company,
    required this.customerId,
    required this.firstName,
    required this.lastName,
    required this.address1,
    required this.address2,
    required this.city,
    required this.province,
    required this.postalCode,
    required this.countryCode,
    required this.phone,
    required this.metadata,
    required this.isDefaultShipping,
    required this.isDefaultBilling,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String company;
  final String customerId;
  final String firstName;
  final String lastName;
  final String address1;
  final String address2;
  final String city;
  final String province;
  final String postalCode;
  final String countryCode;
  final String phone;
  final dynamic metadata;
  final bool isDefaultShipping;
  final bool isDefaultBilling;
  final String createdAt;
  final String updatedAt;

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json["id"] ?? "",
      company: json["company"] ?? "",
      customerId: json["customer_id"] ?? "",
      firstName: json["first_name"] ?? "",
      lastName: json["last_name"] ?? "",
      address1: json["address_1"] ?? "",
      address2: json["address_2"] ?? "",
      city: json["city"] ?? "",
      province: json["province"] ?? "",
      postalCode: json["postal_code"] ?? "",
      countryCode: json["country_code"] ?? "",
      phone: json["phone"] ?? "",
      metadata: json["metadata"],
      isDefaultShipping: json["is_default_shipping"] ?? false,
      isDefaultBilling: json["is_default_billing"] ?? false,
      createdAt: json["created_at"] ?? "",
      updatedAt: json["updated_at"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "company": company,
    "customer_id": customerId,
    "first_name": firstName,
    "last_name": lastName,
    "address_1": address1,
    "address_2": address2,
    "city": city,
    "province": province,
    "postal_code": postalCode,
    "country_code": countryCode,
    "phone": phone,
    "metadata": metadata,
    "is_default_shipping": isDefaultShipping,
    "is_default_billing": isDefaultBilling,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

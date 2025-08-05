class ProfileModel {
  ProfileModel({
    required this.id,
    required this.email,
    required this.companyName,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.metadata,
    required this.hasAccount,
    required this.addresses,
  });

  final String id;
  final String email;
  final dynamic companyName;
  final String firstName;
  final String lastName;
  final String phone;
  final Metadata? metadata;
  final bool hasAccount;
  final List<dynamic> addresses;

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json["id"] ?? "",
      email: json["email"] ?? "",
      companyName: json["company_name"],
      firstName: json["first_name"] ?? "",
      lastName: json["last_name"] ?? "",
      phone: json["phone"] ?? "",
      metadata: json["metadata"] == null
          ? null
          : Metadata.fromJson(json["metadata"]),
      hasAccount: json["has_account"] ?? false,
      addresses: json["addresses"] == null
          ? []
          : List<dynamic>.from(json["addresses"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "company_name": companyName,
    "first_name": firstName,
    "last_name": lastName,
    "phone": phone,
    "metadata": metadata,
    "has_account": hasAccount,
    "addresses": addresses.map((x) => x).toList(),
  };
}

class Metadata {
  Metadata({required this.avatar, required this.verified});

  final String avatar;
  final bool verified;

  factory Metadata.fromJson(Map<String, dynamic> json) {
    return Metadata(
      avatar: json["avatar"] ?? "",
      verified: json["verified"] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {"avatar": avatar};
}

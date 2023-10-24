class personalDetails {
  final String? firstName;
  final String? surName;
  final String? address;
  final String? city;
  final String? country;
  final String? postalCode;
  final String? phone;
  final String? email;
  final String? summary;

  personalDetails(
      {this.firstName,
      this.surName,
      this.address,
      this.city,
      this.country,
      this.postalCode,
      this.phone,
      this.email,
      this.summary});

  factory personalDetails.fromMap(Map<String, dynamic> map) {
    return personalDetails(
      firstName: map['firstName'],
      surName: map['surName'],
      address: map['address'],
      city: map['city'],
      country: map['country'],
      postalCode: map['postalCode'],
      phone: map['phone'],
      email: map['email'],
      summary: map['summary'],
    );
  }

  // Convert user object to a map for Firebase
  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'surName': surName,
      'address': address,
      'city': city,
      'country': country,
      'postalCode': postalCode,
      'phone': phone,
      'email': email,
      'summary': summary,
    };
  }
}

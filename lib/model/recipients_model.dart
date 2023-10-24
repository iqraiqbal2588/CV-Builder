class recipientDetails {
  final String? firstName;
  final String? surName;
  final String? companyName;
  final String? recipientPosition;
  final String? city;
  final String? country;
  final String? postalCode;

  recipientDetails(
      {this.firstName,
      this.surName,
      this.companyName,
      this.recipientPosition,
      this.city,
      this.country,
      this.postalCode});

  factory recipientDetails.fromMap(Map<String, dynamic> map) {
    return recipientDetails(
      firstName: map['firstName'],
      surName: map['surName'],
      companyName: map['companyName'],
      recipientPosition: map['recipientPosition'],
      city: map['city'],
      country: map['country'],
      postalCode: map['postalCode'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'surName': surName,
      'companyName': companyName,
      'recipientPosition': recipientPosition,
      'city': city,
      'country': country,
      'postalCode': postalCode,
    };
  }
}

class exp {
  String? jobTitle;
  String? companyName;
  String? city;
  String? country;
  String? description;
  String? startDate;
  String? endDate;

  exp({
    this.jobTitle,
    this.companyName,
    this.city,
    this.country,
    this.description,
    this.startDate,
    this.endDate,
  });

  factory exp.fromMap(Map<String, dynamic> map) {
    return exp(
      jobTitle: map['jobTitle'],
      companyName: map['companyName'],
      city: map['city'],
      country: map['country'],
      description: map['description'],
      startDate: map['startDate'],
      endDate: map['endDate'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'jobTitle': jobTitle,
      'companyName': companyName,
      'city': city,
      'country': country,
      'description': description,
      'startDate': startDate,
      'endDate': endDate,
    };
  }
}

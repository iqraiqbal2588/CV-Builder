class nameAndContactDetail {
  final String? firstName;
  final String? surName;
  final String? profession;
  final String? job;
  final String? exp;
  final String? city;
  final String? country;
  final String? postalCode;
  final String? phone;
  final String? email;
  final String? skill1;
  final String? skill2;
  final String? skill3;

  nameAndContactDetail(
      {this.firstName,
      this.surName,
      this.profession,
      this.job,
      this.exp,
      this.city,
      this.country,
      this.postalCode,
      this.phone,
      this.email,
      this.skill1,
      this.skill2,
      this.skill3});

  factory nameAndContactDetail.fromMap(Map<String, dynamic> map) {
    return nameAndContactDetail(
      firstName: map['firstName'],
      surName: map['surName'],
      profession: map['profession'],
      job: map['job'],
      exp: map['exp'],
      city: map['city'],
      country: map['country'],
      postalCode: map['postalCode'],
      phone: map['phone'],
      email: map['email'],
      skill1: map['skill1'],
      skill2: map['skill2'],
      skill3: map['skill3'],
    );
  }

  // Convert user object to a map for Firebase
  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'surName': surName,
      'profession': profession,
      'job': job,
      'exp': exp,
      'city': city,
      'country': country,
      'postalCode': postalCode,
      'phone': phone,
      'email': email,
      'skill1': skill1,
      'skill2': skill2,
      'skill3': skill3,
    };
  }
}

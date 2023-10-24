class edu {
  final String? schoolName;
  final String? schoolLocation;
  final String? degree;
  final String? fieldOfStudy;

  edu({
    this.schoolName,
    this.schoolLocation,
    this.degree,
    this.fieldOfStudy,
  });

  factory edu.fromMap(Map<String, dynamic> map) {
    return edu(
      schoolName: map['schoolName'],
      schoolLocation: map['schoolLocation'],
      degree: map['degree'],
      fieldOfStudy: map['fieldOfStudy'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'schoolName': schoolName,
      'schoolLocation': schoolLocation,
      'degree': degree,
      'fieldOfStudy': fieldOfStudy,
    };
  }
}

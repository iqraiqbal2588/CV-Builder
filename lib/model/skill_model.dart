class skills {
  String? skill1;
  String? skill2;
  String? skill3;
  String? skill4;

  skills({
    this.skill1,
    this.skill2,
    this.skill3,
    this.skill4,
  });

  factory skills.fromMap(Map<String, dynamic> map) {
    return skills(
      skill1: map['skill1'],
      skill2: map['skill2'],
      skill3: map['skill3'],
      skill4: map['skill4'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'skill1': skill1,
      'skill2': skill2,
      'skill3': skill3,
      'skill4': skill4,
    };
  }
}

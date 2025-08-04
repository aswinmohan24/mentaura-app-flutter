class UserDetails {
  final String name;
  final String? phoneNumber;
  final String age;
  final String? email;
  final String gender;

  UserDetails(
      {required this.name,
      this.phoneNumber,
      required this.age,
      this.email,
      required this.gender});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'phoneNumber': phoneNumber,
      'age': age,
      'email': email,
      'gender': gender,
    };
  }

  factory UserDetails.fromMap(Map<String, dynamic> map) {
    return UserDetails(
      name: map['name'] as String,
      phoneNumber: map['phoneNumber'],
      age: map['age'] as String,
      email: map['email'],
      gender: map['gender'] as String,
    );
  }

  UserDetails copyWith({
    String? name,
    String? phoneNumber,
    String? age,
    String? email,
    String? gender,
  }) {
    return UserDetails(
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      age: age ?? this.age,
      email: email ?? this.email,
      gender: gender ?? this.gender,
    );
  }
}

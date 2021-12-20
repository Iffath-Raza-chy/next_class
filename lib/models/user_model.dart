class UserModel {
  String? uid;
  String? email;
  String? name;
  String? dob;
  String? batch;

  UserModel({this.uid, this.email, this.name, this.dob, this.batch});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      name: map['name'],
      dob: map['dob'],
      batch: map['batch'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'dob': dob,
      'batch': batch,
    };
  }
}

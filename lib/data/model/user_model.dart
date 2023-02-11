import 'package:cloud_firestore/cloud_firestore.dart';

enum UserRole { customer, serviceProvider }

enum Gender { male, female, x }

class UserModel {
  String? name;
  String? email;
  String? profileUrl;
  String? userId;
  bool? isActive;
  Timestamp? createdDate;
  bool? isAdmin;
  UserRole? role;
  String? address;
  String? mobile;
  String? religion;
  String? nationality;
  String? comName;
  String? nic;
  String? mcTradeLicence;
  String? businessName;
  String? businessRegNumber;
  String? businessPhone;
  String? businessAddress;
  String? fax;
  String? businessType;
  Gender? gender;
  Timestamp? dateBusinessCommence;
  List<Gender>? interestedGender;
  bool? isDead;
  bool? isMember;

  UserModel(
      {this.name,
      this.email,
      this.profileUrl = '',
      this.userId,
      this.createdDate,
      this.isAdmin = false,
      this.mcTradeLicence,
      this.role,
      this.nationality,
      this.businessName,
      this.religion,
      this.address,
      this.comName,
      this.businessAddress,
      this.businessPhone,
      this.dateBusinessCommence,
      this.nic,
        this.mobile,
      this.businessRegNumber,
        this.businessType,
      this.fax,
      this.gender,
        this.isMember,
      this.interestedGender,
      this.isActive = true});

  UserModel.fromMap(Map<String, dynamic>? json) {
    name = json!['name'];
    email = json['email'];
    isMember = json['isMember'];
    profileUrl = json['profileUrl'];
    userId = json['userId'];
    role = json['role'] != null
        ? UserRole.values.elementAt(json['role'] ?? 0)
        : null;
    gender = json['gender'] != null
        ? Gender.values.elementAt(json['gender'] ?? 0)
        : null;
    if (json['interested_gender'] != null &&
        (json['interested_gender'] is List)) {
      interestedGender = <Gender>[];
      json['interested_gender'].forEach((v) {
        interestedGender!.add(Gender.values.elementAt(v));
      });
    } else {
      interestedGender = [];
    }
    fax = json['fax'];
    mobile = json['mobile'];
    mcTradeLicence = json['mcTradeLicence'];
    isActive = json['isActive'];
    isAdmin = json['isAdmin'];
    businessRegNumber = json['new_offers'];
    address = json['address'];

    createdDate = json['createdDate'];
    nationality = json['nationality'];
    religion = json['religion'];
    comName = json['comName'];
    address = json['address'];
    businessPhone = json['businessPhone'];
    businessAddress = json['businessAddress'];
    businessType = json['businessType'];
    businessName = json['businessName'];
    nic = json['nic'];
    dateBusinessCommence = json['dateBusinessCommence'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['profileUrl'] = profileUrl;
    data['userId'] = userId;
    data['isAdmin'] = isAdmin;
    data['isActive'] = isActive;
    data['isMember'] = isMember;
    data['role'] = role == null ? null : role!.index;
    data['gender'] = gender == null ? null : gender!.index;
    data['interested_gender'] = interestedGender == null
        ? []
        : interestedGender!.map((e) => e.index).toList();
    data['createdDate'] = createdDate;
    data['address'] = address;
    data['mcTradeLicence'] = mcTradeLicence;
    data['nationality'] = nationality;
    data['dateBusinessCommence'] = dateBusinessCommence;
    data['businessName'] = businessName;
    data['religion'] = religion;
    data['businessType'] = businessType;
    data['fax'] = fax;
    data['new_offers'] = businessRegNumber;
    data['nic'] = nic;
    data['comName'] = comName;
    data['address'] = address;
    data['mobile'] = mobile;
    data['businessAddress'] = businessAddress;
    data['businessPhone'] = businessPhone;
    return data;
  }

  UserModel.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data() as Map<String, dynamic>);
}

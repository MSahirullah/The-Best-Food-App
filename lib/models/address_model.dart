class AddressModel {
  late int? _id;
  late String _addressType;
  late String? _contactPersonName;
  late String? _contactPersonNumber;
  late String _address;
  late String _latitude;
  late String _logtitude;

  AddressModel({
    id,
    required addressType,
    contactPersonName,
    contactPersonNumber,
    required address,
    required latitude,
    required logtitude,
  }) {
    _id = id;
    _addressType = addressType;
    _contactPersonName = contactPersonName;
    _contactPersonNumber = contactPersonNumber;
    _address = address;
    _latitude = latitude;
    _logtitude = logtitude;
  }

  String get address => _address;
  String get addressType => _addressType;
  String get contactPersonName => _contactPersonNumber!;
  String get contactPersonNumber => _contactPersonNumber!;
  String get latitude => _latitude;
  String get logtitude => _logtitude;

  AddressModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _addressType = json['addressType'] ?? "";
    _contactPersonName = json['contactPersonName'] ?? "";
    _contactPersonNumber = json['contactPersonNumber'] ?? "";
    _address = json['address'];
    _latitude = json['latitude'];
    _logtitude = json['logtitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = _id;
    data['addressType'] = _addressType;
    data['contactPersonName'] = _contactPersonName;
    data['contactPersonNumber'] = _contactPersonNumber;
    data['address'] = _address;
    data['latitude'] = _latitude;
    data['logtitude'] = _logtitude;
    return data;
  }
}

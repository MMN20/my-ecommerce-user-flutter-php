class Address {
  int? addressesId;
  int? addressesUserid;
  String? addressesName;
  double? addressesLat;
  double? addressesLong;
  String? addressesDesc;

  Address(
      {this.addressesId,
      this.addressesUserid,
      this.addressesName,
      this.addressesLat,
      this.addressesLong,
      this.addressesDesc});

  Address.fromJson(Map<String, dynamic> json) {
    addressesId = json['addresses_id'];
    addressesUserid = json['addresses_userid'];
    addressesName = json['addresses_name'];
    addressesLat = double.parse(json['addresses_lat'].toString());
    addressesLong = double.parse(json['addresses_long'].toString());
    addressesDesc = json['addresses_desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['addresses_id'] = this.addressesId;
    data['addresses_userid'] = this.addressesUserid;
    data['addresses_name'] = this.addressesName;
    data['addresses_lat'] = this.addressesLat;
    data['addresses_long'] = this.addressesLong;
    data['addresses_desc'] = this.addressesDesc;
    return data;
  }
}

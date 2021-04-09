import 'package:hive/hive.dart';

part 'customer_model.g.dart';

@HiveType(typeId: 0)
class Customer extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String email;

  @HiveField(3)
  String cpfCnpj;

  @HiveField(4)
  String countryCode;

  @HiveField(5)
  String mobilePhone;

  @HiveField(6)
  String phone;

  @HiveField(7)
  bool pushNotificationsEnabled = false;

  Customer({
    this.id,
    this.name,
    this.email,
    this.cpfCnpj,
    this.countryCode,
    this.mobilePhone,
    this.phone,
    this.pushNotificationsEnabled,
  });

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    cpfCnpj = json['cpf_cnpj'];
    countryCode = json['country_code'];
    mobilePhone = json['mobile_phone'];
    phone = json['phone'];
    pushNotificationsEnabled = json['push_notifications_enabled'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['cpf_cnpj'] = this.cpfCnpj;
    data['country_code'] = this.countryCode;
    data['mobile_phone'] = this.mobilePhone;
    data['phone'] = this.phone;
    data['push_notifications_enabled'] = this.pushNotificationsEnabled;
    return data;
  }
}

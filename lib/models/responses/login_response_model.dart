import 'package:remessa_app/models/customer_model.dart';

class LoginResponseModel {
  String token;
  Customer customer;

  LoginResponseModel({this.token, this.customer});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.customer != null) {
      data['customer'] = this.customer.toJson();
    }
    return data;
  }
}

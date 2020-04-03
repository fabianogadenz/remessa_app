class ErrorResponseModel {
  String field;
  String message;
  String code;

  ErrorResponseModel({this.field, this.message, this.code});

  ErrorResponseModel.fromJson(Map<String, dynamic> json) {
    field = json['field'];
    message = json['message'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['field'] = this.field;
    data['message'] = this.message;
    data['code'] = this.code;
    return data;
  }
}

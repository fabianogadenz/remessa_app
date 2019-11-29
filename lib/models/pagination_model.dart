class PaginationModel {
  int size;
  int page;
  int totalItems;
  int totalPages;

  PaginationModel({this.size, this.page, this.totalItems, this.totalPages});

  PaginationModel.fromJson(Map<String, dynamic> json) {
    size = json['size'];
    page = json['page'];
    totalItems = json['totalItems'];
    totalPages = json['totalPages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['size'] = this.size;
    data['page'] = this.page;
    data['totalItems'] = this.totalItems;
    data['totalPages'] = this.totalPages;
    return data;
  }
}

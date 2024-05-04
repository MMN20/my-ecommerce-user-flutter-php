class CategoryModel {
  int? catId;
  String? catName;
  String? catDesc;
  String? catImageUrl;
  // for subcategories only
  int? catid;
  bool isSelected = true;

  CategoryModel({
    this.catId,
    this.catName,
    this.catDesc,
    this.catImageUrl,
  });

  CategoryModel.fromJson(Map<String, dynamic> json) {
    catId = json['cat_id'];
    catName = json['cat_name'];
    catDesc = json['cat_desc'];
    catImageUrl = json['cat_imageUrl'];
  }
  CategoryModel.subCategoryFromJson(Map<String, dynamic> json) {
    catId = json['subcat_id'];
    catName = json['subcat_name'];
    catDesc = json['subcat_desc'];
    catImageUrl = json['subcat_imageUrl'];
    catid = json['cat_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cat_id'] = catId;
    data['cat_name'] = catName;
    data['cat_desc'] = catDesc;
    data['cat_imageUrl'] = catImageUrl;
    data['cat_id'] = catId;
    return data;
  }
}

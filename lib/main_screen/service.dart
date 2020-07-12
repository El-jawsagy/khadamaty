class Service {
  int id, productCategoryId;
  String slug, name, image, description,createAt;
  bool status, featured;


  Service(this.id, this.productCategoryId, this.slug, this.name, this.image,
      this.description, this.status, this.featured,this.createAt);

  Service.fromJson(Map<String, dynamic> jsonObject) {
    this.id = jsonObject['id'];
    this.productCategoryId = jsonObject['product_category_id'];
    this.slug = jsonObject['slug'];
    this.name = jsonObject['name'];
    this.image = jsonObject['photo'];
    this.description = jsonObject['description'];
    this.status = jsonObject['status'];
    this.featured = jsonObject['featured'];
    this.createAt = jsonObject['updated_at'];
  }
}



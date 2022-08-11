class CatalogueModel {
  String? uuid;
  String? name;
  String? category;
  String? fabric;
  String? description;
  String? price;
  List<Item>? item;

  CatalogueModel({
    this.uuid,
    this.name,
    this.category,
    this.fabric,
    this.description,
    this.item,
    this.price,
  });

  factory CatalogueModel.fromJson(Map<String, dynamic> json) => CatalogueModel(
        uuid: json["uuid"],
        name: json["name"],
        category: json["category"],
        fabric: json["fabric"],
        description: json["description"],
        price: json["price"],
        item: List<Item>.from(json["item"].map((x) => Item.fromJson(x))),
      );
}

class Item {
  String? picture;
  Item({
    this.picture,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        picture: json["picture"],
      );
}

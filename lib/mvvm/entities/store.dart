class Store {
  String? id;
  String? name;
  String? address;
  String? contactInformation;
  bool? inventoryManagement;

  Store({
    this.id,
    this.name,
    this.address,
    this.contactInformation,
    this.inventoryManagement,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      contactInformation: json['contact_information'],
      inventoryManagement: json['inventory_management'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'contact_information': contactInformation,
      'inventory_management': inventoryManagement,
    };
  }
}

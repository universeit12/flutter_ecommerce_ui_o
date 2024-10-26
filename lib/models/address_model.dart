class Address {
  String name;
  String street;
  String city;
  String zipCode;

  Address({required this.name, required this.street, required this.city, required this.zipCode});

  Map<String, dynamic> toJson() => {
    'name': name,
    'street': street,
    'city': city,
    'zipCode': zipCode,
  };

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    name: json['name'],
    street: json['street'],
    city: json['city'],
    zipCode: json['zipCode'],
  );
}

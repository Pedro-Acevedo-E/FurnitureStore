class User {
  final int id;
  final String username;
  final String firstName;
  final String lastName;
  final String password;
  final String access;

  User({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.access
  });

  static User empty(){
    return User(id: 0, username: "", firstName: "", lastName: "", password: "", access: "");
  }
}

class Equipment {
  final int id;
  final String name;
  final String description;
  final String location;
  final String status;
  final String category;
  final String equipmentInfo;
  final String external;
  final String notes;
  final String createdAt;

  Equipment({
    required this.id,
    required this.name,
    required this.description,
    required this.location,
    required this.status,
    required this.category,
    required this.equipmentInfo,
    required this.external,
    required this.notes,
    required this.createdAt,
  });
}

class EquipmentLog {
  final int id;
  final int equipmentId;
  final int userId;
  final String description;
  final String createdAt;

  EquipmentLog({
    required this.id,
    required this.equipmentId,
    required this.userId,
    required this.description,
    required this.createdAt,
  });
}

class EquipmentInfo {
  final String id;
  final String productId;
  final String model;
  final String description;
  final String weight;
  final String dimensions;
  final String color1;
  final String color2;

  EquipmentInfo({
    required this.id,
    required this.productId,
    required this.model,
    required this.description,
    required this.weight,
    required this.dimensions,
    required this.color1,
    required this.color2,
  });
}

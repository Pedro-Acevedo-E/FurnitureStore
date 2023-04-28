class Users {
  final int id;
  final String username;
  final String password;
  final String access;

  Users({required this.id, required this.username, required this.password, required this.access});
}

class Equipment {
  final int id;
  final String name;
  final String description;
  final int userId;
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
    required this.userId,
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
  final String model;
  final String description;
  final String weight;
  final String dimensions;
  final String color1;
  final String color2;

  EquipmentInfo({
    required this.id,
    required this.model,
    required this.description,
    required this.weight,
    required this.dimensions,
    required this.color1,
    required this.color2,
  });
}

class Category {
  final int id;
  final String name;
  final String description;

  Category({
    required this.id,
    required this.name,
    required this.description,
  });
}

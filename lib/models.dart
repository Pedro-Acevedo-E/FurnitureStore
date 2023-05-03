class User {
  final int id;
  final String username;
  final String firstName;
  final String lastName;
  final String password;
  final String entranceTime;
  final String internal;
  final String external;
  final String access;

  User({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.entranceTime,
    required this.internal,
    required this.external,
    required this.access
  });

  static User empty(){
    return User(id: 0, username: "", firstName: "", lastName: "", password: "", entranceTime: "", internal: "", external: "", access: "");
  }

  static User demo1(){
    return User(id: 0, username: "admin", firstName: "admin", lastName: "is cool", password: "1234", entranceTime: "", internal: "no", external: "no", access: "admin");
  }

  static User demo2(){
    return User(id: 0, username: "user", firstName: "user", lastName: "is cool", password: "1234", entranceTime: "", internal: "no", external: "no", access: "user");
  }

  static User demo3(){
    return User(id: 0, username: "security", firstName: "security", lastName: "in cool", password: "1234", entranceTime: "", internal: "no", external: "no", access: "security");
  }

}

class EquipmentExt {
  final int id;
  final String user;
  final String name;
  final String description;
  final String createdAt;

  EquipmentExt({
    required this.id,
    required this.user,
    required this.name,
    required this.description,
    required this.createdAt,
  });
}

class EquipmentInt {
  final int id;
  final String user;
  final String location;
  final String status;
  final String productId;
  final String name;
  final String description;
  final String category;
  final String model;
  final String weight;
  final String dimensions;
  final String color_1;
  final String color_2;
  final String notes;
  final String createdAt;

  EquipmentInt({
    required this.id,
    required this.user,
    required this.location,
    required this.status,
    required this.productId,
    required this.name,
    required this.description,
    required this.category,
    required this.model,
    required this.weight,
    required this.dimensions,
    required this.color_1,
    required this.color_2,
    required this.notes,
    required this.createdAt,
  });
}

class Log {
  final int id;
  final String title;
  final String createdBy;
  final int description;
  final String createdAt;

  Log({
    required this.id,
    required this.title,
    required this.createdBy,
    required this.description,
    required this.createdAt,
  });
}



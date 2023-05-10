class User {
  final int id;
  final String username;
  final String firstName;
  final String lastName;
  final String password;
  String entranceTime;
  final String access;

  User({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.entranceTime,
    required this.access
  });

  static User empty(){
    return User(id: 0, username: "", firstName: "", lastName: "", password: "", entranceTime: "", access: "");
  }

  static User demo1(){
    return User(id: 0, username: "PedroAcevedo", firstName: "Pedro", lastName: "Acevedo", password: "1234", entranceTime: "", access: "user");
  }

  static User demo2(){
    return User(id: 0, username: "FernandoMorales", firstName: "Fernando", lastName: "Morales", password: "1234", entranceTime: "12:50", access: "user");
  }

  static User demo3(){
    return User(id: 0, username: "CarlosHernandez", firstName: "Carlos", lastName: "Hernandez", password: "1234", entranceTime: "08:20", access: "user");
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

  static EquipmentExt empty(){
    return EquipmentExt(id: 0, user: "", name: "", description: "", createdAt: "");
  }

  static EquipmentExt demo1(){
    return EquipmentExt(id: 0, user: "FernandoMorales", name: "Headphones", description: "Black wireless headphones", createdAt: "");
  }
  static EquipmentExt demo2(){
    return EquipmentExt(id: 0, user: "CarlosHernandez", name: "Laptop", description: "Apple laptop Mac M1", createdAt: "");
  }

}

class EquipmentInt {
  final int id;
  final String user;
  String location;
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

  static EquipmentInt empty(){
    return EquipmentInt(
        id: 0,
        user: "",
        location: "",
        status: "",
        productId: "",
        name: "",
        description: "",
        category: "",
        model: "",
        weight: "",
        dimensions: "",
        color_1: "",
        color_2: "",
        notes: "",
        createdAt: "");
  }

  static EquipmentInt demo1(){
    return EquipmentInt(
        id: 0,
        user: "PedroAcevedo",
        location: "Outside with user",
        status: "Good condition",
        productId: "AEEPLG3456",
        name: "iPhone 13 Pro",
        description: "White mobile phone",
        category: "Phone",
        model: "Apple",
        weight: "240g",
        dimensions: "5.78inches X 2.82inches",
        color_1: "White",
        color_2: "Silver",
        notes: "Phone does not have chip, and has a 128GB Kingston SD card",
        createdAt: ""
    );
  }

  static EquipmentInt demo2(){
    return EquipmentInt(
        id: 0,
        user: "CarlosHernandez",
        location: "In office with user",
        status: "Good condition",
        productId: "AEEPLG3459",
        name: "iPhone 13 Pro",
        description: "White mobile phone",
        category: "Phone",
        model: "Apple",
        weight: "240g",
        dimensions: "5.78inches X 2.82inches",
        color_1: "White",
        color_2: "Silver",
        notes: "Phone has an activated Telcel chip, it has no SD card",
        createdAt: ""
    );
  }

  static EquipmentInt demo3(){
    return EquipmentInt(
        id: 0,
        user: "",
        location: "In office",
        status: "Good condition",
        productId: "AEEPGP345",
        name: "mini Mac M2",
        description: "Small PC",
        category: "PC",
        model: "Apple",
        weight: "1.18kg",
        dimensions: "1.41inches X 7.75inches",
        color_1: "Silver",
        color_2: "Black",
        notes: "",
        createdAt: ""
    );
  }

  static EquipmentInt demo4(){
    return EquipmentInt(
        id: 0,
        user: "",
        location: "In office",
        status: "Fine condition",
        productId: "AEEPGP3459",
        name: "MacBook Air M2",
        description: "Laptop",
        category: "Laptop",
        model: "Apple",
        weight: "1.29kg",
        dimensions: "11.97inches X 8.46inches",
        color_1: "Silver",
        color_2: "White",
        notes: "Device has a small crack in the top right corner of the screen",
        createdAt: ""
    );
  }
}

class Log {
  final int id;
  final String title;
  final String createdBy;
  final String description;
  final String createdAt;

  Log({
    required this.id,
    required this.title,
    required this.createdBy,
    required this.description,
    required this.createdAt,
  });

  static Log empty(){
    return Log(id: 0, title: "", createdBy: "", description: "", createdAt: "");
  }
}

class EquipmentCategory {
  final int id;
  final String name;
  final String description;

  EquipmentCategory ({
    required this.id,
    required this.name,
    required this.description
  });
}




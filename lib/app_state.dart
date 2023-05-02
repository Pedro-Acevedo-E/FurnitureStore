enum AppState {
  loading,
  loginScreen, //All users
  adminMainView, //Admin
  userMainView, //User
  securityMainView, //Security

  databaseView, //Admin (Basic CRUD operations, only way to delete)
  createUser, //Admin
  createFurniture, //Admin, Security. (Equipment info must be included, user_id is not assigned but i can be, Generates logs)
  assignFurniture, //Admin, Security (Update furniture user_id to a new user)
  furnitureList, //Admin, Security (Show furniture list, can update all its information)
  updateFurniture, //Admin, Security (Update equipment info)
  createCategory, //Admin (default categories mus be provided)
  equipmentLogListView, //Admin, Security
  createIncident, //Admin, Security (Show furniture list and select the one to do an incident, can also update furniture info here)
  furnitureEntrance, //Admin, Security (Show registered furniture outside of office, Update furniture location, generate logs)
  furnitureExit, //Admin, Security (Show furniture in office, Update furniture location, user_id (optional) generate logs, DELETE if equipment is external)
  userList, //Admin Security (Shows user list, can click one to see furniture assigned to user)
  userFurnitureList, //All users (This view is shown from userList state, All the furniture registered to a user)

  profile, //All users (Account info)
  settings, //All users (General settings, password update, etc)

  error,
}

enum PopupSelection {
  profile,
  settings,
  logout,
}
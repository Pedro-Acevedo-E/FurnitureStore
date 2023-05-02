enum AppState {
  loading,
  loginScreen, //All users
  adminMainView, //Admin
  userMainView, //User
  securityMainView, //Security

  databaseView, //Admin (Basic CRUD operations)
  createUser, //Admin
  createFurniture, //Admin, Security. (Equipment info must be included, Generates logs)
  createCategory, //Admin (default categories mus be provided)
  equipmentLogListView, //Admin, Security
  createIncident, //Admin, Security (Show furniture list and select the one to do an incident)
  furnitureEntrance, //Admin, Security (Update furniture location, generate logs)
  furnitureExit, //Admin, Security (assign furniture to user (select furniture from list and select user) if its an external delete it instead)

  //Views
      //Lists
  userListView, //You can click any of these to check info (CANNOT delete or edit info here)
  equipmentListView,
  equipmentInfoListView,
  categoryListView,
      //Singles
  userView,
  equipmentView,
  equipmentInfoView,
  equipmentLogView,
  categoryView,


  createLog, //Logs are created automatically

  //Functions

  userFurniture, //Just check furniture assigned to a user (external and internal)
  settings,

  //Updates or edits
  updateUser,
  updateEquipmentLog,
  updateEquipment,
  updateEquipmentInfo,
  updateCategory,

  error,
}

enum PopupSelection {
  profile,
  settings,
  logout,
}
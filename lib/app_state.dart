enum AppState {
  loading,
  loginScreen,
  adminMainView,
  userMainView,
  securityMainView,

  //Views
  tablesView, //Basic CRUD operations
      //Lists
  userListView, //You can click any of these to check info (CANNOT delete or edit info here)
  equipmentListView,
  equipmentInfoListView,
  equipmentLogListView,
  categoryListView,
      //Singles
  userView,
  equipmentView,
  equipmentInfoView,
  equipmentLogView,
  categoryView,

  //Create
  createUser,
  createFurniture, //Equipment info must be included
  createCategory,
  createLog, //Logs are created automatically

  //Functions
  createIncident,
  entranceFurniture, //assign furniture to user and update its state this generates logs
  exitFurniture,
  createExternalFurniture, //maybe can be deprecated for createFurniture
  userFurniture, //Just check furniture asigned to a user (external and internal)

  //Updates or edits
  updateUser,
  updateEquipmentLog,
  updateEquipment,
  updateEquipmentInfo,
  updateCategory,

  error,
}
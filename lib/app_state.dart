enum AppState {
  loading,
  loginScreen,
  mainView,

  //admin
  userList,
  categoryList,

  //security
  entrancesAndExits,
  createIncident,
  incidentLog,
  userLog,
  logDetails,
  internalFurniture,
  externalFurniture,

  //User
  checkFurniture,

  //Entrances and exits
  userEntrance,
  userExit,

  //CRUD
  userDetails,

  internalDetails,
  internalDelete,
  internalEdit,
  internalCreate,

  profile,
  settings,

  error,
}

enum PopupSelection {
  profile,
  settings,
  logout,
}
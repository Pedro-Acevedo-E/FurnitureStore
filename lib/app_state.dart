enum AppState {
  loading,
  loginScreen,
  mainView,

  //admin
  userList,
  categoryList,
  brandList,

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
  userDelete,
  userEdit,
  userCreate,

  categoryDetails,
  categoryDelete,
  categoryEdit,
  categoryCreate,

  internalDetails,
  internalDelete,
  internalEdit,
  internalCreate,

  externalDetails,
  externalDelete,
  externalEdit,
  externalCreate,

  brandDetails,
  brandDelete,
  brandCreate,
  brandEdit,

  profile,
  settings,

  error,
}

enum PopupSelection {
  profile,
  settings,
  logout,
}
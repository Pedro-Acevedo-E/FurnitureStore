enum AppState {
  loading,
  loginScreen,
  mainView,

  //admin
  editUser,
  editExternal,
  editInternal,
  editCategory,

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
  userDetails,
  userEntrance,
  userExit,

  profile,
  settings,

  error,
}

enum PopupSelection {
  profile,
  settings,
  logout,
}
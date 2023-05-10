import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:furniture_store/controllers/brand_controller.dart';
import 'package:furniture_store/controllers/category_controller.dart';
import 'package:furniture_store/controllers/demo_controller.dart';
import 'package:furniture_store/controllers/entrances_exits_controller.dart';
import 'package:furniture_store/controllers/external_furniture_controller.dart';
import 'package:furniture_store/controllers/internal_furniture_controller.dart';
import 'package:furniture_store/controllers/login_controller.dart';
import 'package:furniture_store/controllers/user_controller.dart';
import 'package:furniture_store/sql_helper.dart';
import 'package:furniture_store/app_state.dart';
import 'package:furniture_store/views/brand_views/brand_details.dart';
import 'package:furniture_store/views/brand_views/brand_list_view.dart';
import 'package:furniture_store/views/category_views/category_details.dart';
import 'package:furniture_store/views/category_views/category_list_view.dart';
import 'package:furniture_store/views/brand_views/create_brand_form.dart';
import 'package:furniture_store/views/category_views/create_category_form.dart';
import 'package:furniture_store/views/external_equipment/create_external_form.dart';
import 'package:furniture_store/views/log_views/create_incident_view.dart';
import 'package:furniture_store/views/internal_equipment/create_internal_form.dart';
import 'package:furniture_store/views/user_views/create_user_form.dart';
import 'package:furniture_store/views/brand_views/delete_brand_form.dart';
import 'package:furniture_store/views/category_views/delete_category_view.dart';
import 'package:furniture_store/views/external_equipment/delete_external_furniture_view.dart';
import 'package:furniture_store/views/internal_equipment/delete_internal_furniture_view.dart';
import 'package:furniture_store/views/user_views/delete_user_view.dart';
import 'package:furniture_store/views/brand_views/edit_brand_form.dart';
import 'package:furniture_store/views/category_views/edit_category_form.dart';
import 'package:furniture_store/views/external_equipment/edit_external_form.dart';
import 'package:furniture_store/views/internal_equipment/edit_internal_form.dart';
import 'package:furniture_store/views/user_views/edit_user_form.dart';
import 'package:furniture_store/views/entrances_and_exits/entrance_exits_view.dart';
import 'package:furniture_store/views/external_equipment/ext_furniture_list_view.dart';
import 'package:furniture_store/views/external_equipment/external_furniture_details.dart';
import 'package:furniture_store/views/internal_equipment/internal_furniture_details_view.dart';
import 'package:furniture_store/views/internal_equipment/int_furniture_list_view.dart';
import 'package:furniture_store/views/log_views/log_details_view.dart';
import 'package:furniture_store/views/log_views/log_list_view.dart';
import 'package:furniture_store/views/navigation_views/login_view.dart';
import 'package:furniture_store/views/navigation_views/main_view.dart';
import 'package:furniture_store/views/user_views/user_details_view.dart';
import 'package:furniture_store/views/entrances_and_exits/user_entrance_view.dart';
import 'package:furniture_store/views/entrances_and_exits/user_exit_view.dart';
import 'package:furniture_store/views/user_furniture_view.dart';
import 'package:furniture_store/views/user_views/user_list_view.dart';

import 'controllers/incident_controller.dart';
import 'models.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(const MyApp()));
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppState appState = AppState.loginScreen;
  AppState lastState = AppState.loginScreen;
  List<User> userList = [];
  List<EquipmentExt> extList = [];
  List<EquipmentInt> intList = [];
  List<EquipmentCategory> categoryList = [];
  List<EquipmentCategory> brandList = [];
  List<Log> incidentsList = [];
  List<Log> userLogList = [];

  User? selectedUser;
  EquipmentInt? selectedInt;
  EquipmentExt? selectedExt;
  EquipmentCategory? selectedCategory;
  EquipmentCategory? selectedBrand;
  Log? selectedLog;

  final demoController = DemoController();
  late final ExternalController externalController;
  final incidentController = IncidentController();
  late final InternalController internalController;
  late final UserController userController;
  final categoryController = CategoryController();
  final brandController = BrandController();
  late final EntrancesAndExitsController entrancesAndExitsController;
  var loginController = LoginController.empty();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: mainView(),
    );
  }

  @override
  void initState() {
    super.initState();
    //demoController.createDemo();
    demoController.loadItemsDemo();
    entrancesAndExitsController = EntrancesAndExitsController(loginController.loginUser, (state) => changeState(state), refresh);
    externalController = ExternalController((state) => changeState(state), refresh);
    internalController = InternalController((state) => changeState(state), refresh);
    userController = UserController((state) => changeState(state), refresh);
    loginController = LoginController((state) => changeState(state), refresh);
  }

  Widget mainView() {
    switch(appState){
      case AppState.loginScreen: {
        return LoginView(
            loginController: loginController,
        );
      }
      case AppState.mainView: {
        return MainView(
            loginController: loginController,
            changeState: (AppState state) => changeState(state)
        );
      }
      case AppState.entrancesAndExits: {
        return EntranceAndExitsView(
            userList: userList,
            changeState: (AppState state) => changeState(state),
            logout: () => loginController.logout(),
            viewUserDetails: viewUserDetails,
            entrancesAndExitsController: entrancesAndExitsController,
        );
      }
      case AppState.userDetails: {
        final selectedUser = this.selectedUser;
        if (selectedUser != null) {
          return UserDetailsView(
              selectedUser: selectedUser,
              extList: extList,
              intList: intList,
              changeState: (AppState state) => changeState(state),
              lastState: lastState);
        } else {
          return UserDetailsView(
              selectedUser: userController.selectedUser,
              extList: extList,
              intList: intList,
              changeState: (AppState state) => changeState(state),
              lastState: lastState);
        }
      }
      case AppState.userEntrance: {
        return UserEntranceView(
            intList: intList,
            changeState: (AppState state) => changeState(state),
            logout: () => loginController.logout(),
            entrancesAndExitsController: entrancesAndExitsController
        );
      }
      case AppState.userExit: {
          return UserExitView(
              intList: intList,
              extList: extList,
              changeState: (AppState state) => changeState(state),
              logout: () => loginController.logout(),
              entrancesAndExitsController: entrancesAndExitsController,
          );
      }
      case AppState.createIncident: {
        return CreateIncidentView(
            loginController: loginController,
            changeState: (AppState state) => changeState(state),
            incidentController: incidentController,
        );
      }
      case AppState.incidentLog: {
        return LogListView(
            title: "Incidents",
            logList: incidentsList,
            changeState: (AppState state) => changeState(state),
            viewLogDetails: viewLogDetails,
            logout: () => loginController.logout()
        );
      }
      case AppState.userLog: {
        return LogListView(
            title: "Entrance and Exit",
            logList: userLogList,
            changeState: (AppState state) => changeState(state),
            viewLogDetails: viewLogDetails,
            logout: () => loginController.logout()
        );
      }
      case AppState.logDetails: {
        final selectedLog = this.selectedLog;
        if(selectedLog != null) {
          return LogDetailsView(
            user: loginController.loginUser,
            selectedLog: selectedLog,
            changeState: (AppState state) => changeState(state),
            logout: () => loginController.logout(),
            lastState: lastState,
          );
        } else {
          return const Text("Error");
        }
      }
      case AppState.internalFurniture: {
        return IntFurnitureView(
            loginController: loginController,
            intList: intList,
            changeState: (AppState state) => changeState(state),
            internalController: internalController
        );
      }
      case AppState.internalCreate: {
        return CreateInternalView(
            internalController: internalController,
            userList: userList,
            categoryList: categoryList,
            brandList: brandList,
            logout: loginController.logout,
            changeState: changeState
        );
      }
      case AppState.internalDetails: {
        return InternalDetailsView(
            selectedInt: internalController.selectedInt!,
            changeState: changeState,
            logout: loginController.logout
        );
      }
      case AppState.internalDelete: {
        return DeleteInternalView(
            changeState: changeState,
            internalController: internalController,
            logout: loginController.logout);

      }
      case AppState.internalEdit: {
          return EditInternalView(
              internalController: internalController,
              userList: userList,
              categoryList: categoryList,
              brandList: brandList,
              logout: loginController.logout,
              changeState: changeState
          );
      }
      case AppState.externalFurniture: {
        return ExtFurnitureView(
            loginController: loginController,
            externalController: externalController,
            extList: extList,
            changeState: changeState
        );
      }
      case AppState.externalCreate: {
        return CreateExternalView(
            externalController: externalController,
            userList: userList,
            logout: loginController.logout,
            changeState: changeState);
      }
      case AppState.externalDetails: {
          return ExternalDetailsView(
              selectedExt: externalController.selectedExt!,
              changeState: changeState,
              logout: loginController.logout
          );
      }
      case AppState.externalEdit: {
        return EditExternalView(
            userList: userList,
            externalController: externalController,
            logout: loginController.logout,
            changeState: changeState,
        );
      }
      case AppState.externalDelete: {
        return DeleteExternalView(
            changeState: changeState,
            externalController: externalController,
            logout: loginController.logout);
      }
      case AppState.profile: {
        return UserDetailsView(
            selectedUser: loginController.loginUser,
            extList: extList,
            intList: intList,
            changeState: changeState,
            lastState: lastState);
      }
      case AppState.userList: {
        return UserListView(
            userList: userList,
            changeState: changeState,
            userController: userController,
            logout: loginController.logout
        );
      }
      case AppState.userCreate: {
        return CreateUserView(
            userController: userController,
            logout: loginController.logout,
            changeState: changeState,
        );
      }
      case AppState.userEdit: {
          return EditUserView(
            userController: userController,
            logout: loginController.logout,
            changeState: changeState,
          );
        }
      case AppState.userDelete: {
          return DeleteUserView(
              changeState: changeState,
              userController: userController,
              logout: loginController.logout
          );
      }
      case AppState.categoryList: {
        return CategoryView(
            categoryList: categoryList,
            changeState: changeState,
            viewCategoryDetails: viewCategoryDetails,
            viewDeleteCategory: viewDeleteCategory,
            viewEditCategory: viewEditCategory,
            viewCreateCategory: viewCreateCategory,
            logout: loginController.logout
        );
      }
      case AppState.categoryCreate: {
        return CreateCategoryView(
            categoryController: categoryController,
            logout: loginController.logout,
            changeState: changeState
        );
      }
      case AppState.categoryDetails: {
        return CategoryDetailsView(
            selectedCategory: selectedCategory!,
            changeState: changeState,
            logout: loginController.logout
        );
      }
      case AppState.categoryEdit: {
        return EditCategoryView(
            selectedCategory: selectedCategory!,
            categoryController: categoryController,
            logout: loginController.logout,
            changeState: changeState
        );
      }
      case AppState.categoryDelete: {
        return DeleteCategoryView(
            selectedCategory: selectedCategory!,
            changeState: changeState,
            categoryController: categoryController,
            logout: loginController.logout
        );
      }
      case AppState.brandList: {
        return BrandView(
            brandList: brandList,
            changeState: changeState,
            viewBrandDetails: viewBrandDetails,
            viewDeleteBrand: viewDeleteBrand,
            viewEditBrand: viewEditBrand,
            viewCreateBrand: viewCreateBrand,
            logout: loginController.logout
        );
      }
      case AppState.brandCreate: {
        return CreateBrandView(
            brandController: brandController,
            logout: loginController.logout,
            changeState: changeState
        );
      }
      case AppState.brandDetails: {
        return BrandDetailsView(
            selectedCategory: selectedCategory!,
            changeState: changeState,
            logout: loginController.logout
        );
      }
      case AppState.brandEdit: {
        return EditBrandView(
            selectedCategory: selectedCategory!,
            brandController: brandController,
            logout: loginController.logout,
            changeState: changeState
        );
      }
      case AppState.brandDelete: {
        return DeleteBrandView(
            selectedCategory: selectedCategory!,
            changeState: changeState,
            brandController: brandController,
            logout: loginController.logout
        );
      }
      case AppState.checkFurniture: {
        return UserFurnitureView(
            loginController: loginController,
            extList: extList,
            intList: intList,
            changeState: changeState,
        );
      }
      default: {
        return Text(appState.toString());
      }
    }
  }

  void changeState(AppState state) {
    refreshList();
    setState(() {
      lastState = appState;
      appState = state;
      incidentController.reset();
    });
  }

  void refreshList() async {
    final data = await SQLHelper.getList("user");
    final ext = await SQLHelper.getList("equipment_ext");
    final intE = await SQLHelper.getList("equipment_int");
    final iLog = await SQLHelper.getList("incident_log");
    final uLog = await SQLHelper.getList("user_log");
    final cat = await SQLHelper.getList("category");
    final brnd = await SQLHelper.getList("brand");

    List<User> tempUserList = [];
    for(var i = 0; i < data.length; i++) {
      tempUserList.add(User(
          id: data.elementAt(i)["id"],
          username: data.elementAt(i)["username"],
          firstName: data.elementAt(i)["first_name"],
          lastName: data.elementAt(i)["last_name"],
          password: data.elementAt(i)["password"],
          entranceTime: data.elementAt(i)["entrance_time"],
          access: data.elementAt(i)["access"]));
    }
    List<EquipmentExt> tempExtList = [];
    for(var i = 0; i < ext.length; i++) {
      tempExtList.add(EquipmentExt(
          id: ext.elementAt(i)["id"],
          user: ext.elementAt(i)["user"],
          name: ext.elementAt(i)["name"],
          description: ext.elementAt(i)["description"],
          createdAt: ext.elementAt(i)["created_at"].toString()));
    }
    List<EquipmentInt> tempIntList = [];
    for(var i = 0; i < intE.length; i++) {
      tempIntList.add(EquipmentInt(
          id: intE.elementAt(i)["id"],
          user: intE.elementAt(i)["user"],
          location: intE.elementAt(i)["location"],
          status: intE.elementAt(i)["status"],
          productId: intE.elementAt(i)["product_id"],
          name: intE.elementAt(i)["name"],
          description: intE.elementAt(i)["description"],
          category: intE.elementAt(i)["category"],
          model: intE.elementAt(i)["model"],
          weight: intE.elementAt(i)["weight"],
          dimensions: intE.elementAt(i)["dimensions"],
          color_1: intE.elementAt(i)["color_1"],
          color_2: intE.elementAt(i)["color_2"],
          notes: intE.elementAt(i)["notes"],
          createdAt: intE.elementAt(i)["created_at"].toString()));
    }
    List<Log> uTempLog = [];
    for(var i = 0; i < uLog.length; i++) {
      uTempLog.add(Log(
          id: uLog.elementAt(i)["id"],
          title: uLog.elementAt(i)["title"],
          createdBy: uLog.elementAt(i)["created_by"],
          description: uLog.elementAt(i)["description"],
          createdAt: uLog.elementAt(i)["created_at"].toString()));
    }
    List<Log> iTempLog = [];
    for(var i = 0; i < iLog.length; i++) {
      iTempLog.add(Log(
          id: iLog.elementAt(i)["id"],
          title: iLog.elementAt(i)["title"],
          createdBy: iLog.elementAt(i)["created_by"],
          description: iLog.elementAt(i)["description"],
          createdAt: iLog.elementAt(i)["created_at"].toString()));
    }
    List<EquipmentCategory> tempCatList = [];
    for(var i = 0; i < cat.length; i++) {
      tempCatList.add(EquipmentCategory(
          id: cat.elementAt(i)["id"],
          name: cat.elementAt(i)["name"],
          description: cat.elementAt(i)["description"])
      );
    }
    List<EquipmentCategory> tempBrndList = [];
    for(var i = 0; i < brnd.length; i++) {
      tempBrndList.add(EquipmentCategory(
          id: brnd.elementAt(i)["id"],
          name: brnd.elementAt(i)["name"],
          description: brnd.elementAt(i)["description"])
      );
    }

    setState(() {
      userList = tempUserList;
      extList = tempExtList;
      intList = tempIntList;
      incidentsList = iTempLog;
      userLogList = uTempLog;
      categoryList = tempCatList;
      brandList = tempBrndList;
    });
  }

  //CRUD
  void viewLogDetails(Log log) {
    setState(() {
      selectedLog = log;
    });
    changeState(AppState.logDetails);
  }

  //User
  void viewUserDetails(User user) {
    selectUser(user);
    changeState(AppState.userDetails);
  }

  //Category
  void viewCategoryDetails(EquipmentCategory cat) {
    setState(() {
      selectedCategory = cat;
    });
    changeState(AppState.categoryDetails);
  }
  void viewEditCategory(EquipmentCategory? cat) {
    setState(() {
      categoryController.reset();
      selectedCategory = cat;
    });
    changeState(AppState.categoryEdit);

  }
  void viewDeleteCategory(EquipmentCategory? cat) {
    setState(() {
      selectedCategory = cat;
    });
    changeState(AppState.categoryDelete);
  }
  void viewCreateCategory() {
    setState(() {
      categoryController.reset();
    });
    changeState(AppState.categoryCreate);
  }

  //Brands
  void viewBrandDetails(EquipmentCategory brand) {
    setState(() {
      selectedCategory = brand;
    });
    changeState(AppState.brandDetails);
  }
  void viewEditBrand(EquipmentCategory? brand) {
    setState(() {
      brandController.reset();
      selectedCategory = brand;
    });
    changeState(AppState.brandEdit);

  }
  void viewDeleteBrand(EquipmentCategory? brand) {
    setState(() {
      selectedCategory = brand;
    });
    changeState(AppState.brandDelete);
  }
  void viewCreateBrand() {
    setState(() {
      brandController.reset();
    });
    changeState(AppState.brandCreate);
  }

  //End CRUD operations ############################################################

  void selectUser(User user) {
    setState(() {
      selectedUser = user;
    });
  }

  void selectCategory(EquipmentCategory category) {
    setState(() {
      selectedCategory = category;
    });
  }

  void selectBrand(EquipmentCategory category) {
    setState(() {
      selectedBrand = category;
    });
  }

  void selectAccess(String access) {
    setState(() {
      userController.access.text = access;
    });
  }

  void refresh() {
    setState(() { });
  }
}


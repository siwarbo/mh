import 'package:alh/adminInterface/models/role_model.dart';
import 'package:alh/adminInterface/services/dbs.dart';
import 'package:get/get.dart';



class RoleController extends GetxController {
  final Db databaseService = Db();

  @override
  void onInit() {
    role.bindStream(databaseService.getRole());
    pendingRole
        .bindStream(databaseService.getPendingRole());
    super.onInit();
  }

  RxList<Role> role = <Role>[].obs;
  RxList<Role> pendingRole =
      <Role>[].obs;

  void fetchRole() async {
    try {
      List<Role> roleList =
          await databaseService.getRole().first;

      role.assignAll(roleList);
    } catch (e) {
      print("Error fetching orders: $e");
    }
  }

  
  void updateRole(
    Role role,
    String field,
    String value,
  ) {
    databaseService.updateRole(role, field, value);
  }
}

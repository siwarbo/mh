import 'package:alh/adminInterface/models/models.dart';
import 'package:alh/adminInterface/services/database_service.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  final DatabaseService databaseService = DatabaseService();

  //var orders = <Orders>[].obs;

  @override
  void onInit() {
    orders.bindStream(databaseService.getOrders());

    super.onInit();
  }

  RxList<Orders> orders = <Orders>[].obs;

  void fetchOrders() async {
    try {
      List<Orders> orderList = await databaseService.getOrders().first;

      orders.assignAll(orderList);
    } catch (e) {
      print("Error fetching orders: $e");
    }
  }

  void updateOrder(
    Orders order,
    String field,
    bool value,
  ) {
    databaseService.updateOrder(order, field, value);
  }
}

import 'package:alh/deliveryPersonnelInterface/delivery_model.dart';
import 'package:alh/deliveryPersonnelInterface/database_services.dart';
import 'package:get/get.dart';

class DeliveryPersonnelController extends GetxController {
  final DatabaseServices databaseService = DatabaseServices();

  @override
  void onInit() {
    deliveryPersonnel.bindStream(databaseService.getDeliveryPersonnel());
    pendingDeliveryPersonnel
        .bindStream(databaseService.getPendingDeliveryPersonnel());
    super.onInit();
  }

  RxList<DeliveryPersonnel> deliveryPersonnel = <DeliveryPersonnel>[].obs;
  RxList<DeliveryPersonnel> pendingDeliveryPersonnel =
      <DeliveryPersonnel>[].obs;

  void fetchDeliveryPersonnel() async {
    try {
      List<DeliveryPersonnel> deliveryPersonnelList =
          await databaseService.getDeliveryPersonnel().first;

      deliveryPersonnel.assignAll(deliveryPersonnelList);
    } catch (e) {
      print("Error fetching orders: $e");
    }
  }

  void updateDeliveryPersonnel(
    DeliveryPersonnel deliveryPersonnel,
    String field,
    bool value,
  ) {
    databaseService.updateDeliveryPersonnel(deliveryPersonnel, field, value);
  }
}

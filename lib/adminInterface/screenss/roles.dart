import 'package:alh/adminInterface/controllers/role_controller.dart';
import 'package:alh/adminInterface/models/role_model.dart';
import 'package:alh/adminInterface/services/dbs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RoleScreen extends StatefulWidget {
  static const String routeName = '/role';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => RoleScreen(),
    );
  }

  RoleScreen({super.key});

  @override
  State<RoleScreen> createState() => _RoleScreenState();
}

class _RoleScreenState extends State<RoleScreen> {
  final RoleController roleController = Get.put(RoleController());

  final RoleController rolController = Get.put(RoleController());

  final Db _databaseService = Db();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Role'),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => ListView.builder(
                  itemCount: rolController.pendingRole.length,
                  itemBuilder: (BuildContext context, index) {
                    final role = rolController.pendingRole[index];
                    return SizedBox(
                      child: RoleCard(
                        role: role,
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}

class RoleCard extends StatelessWidget {
  final Role role;
  RoleCard({super.key, required this.role});

  final RoleController roleController = Get.find();

  // List of roles
  final List<String> roles = ['Admin', 'User', 'Manager', 'Delivery'];

  @override
  Widget build(BuildContext context) {
    String dropdownValue = role.role;

    return Padding(
        padding: const EdgeInsets.only(
          left: 10.0,
          right: 10.0,
          top: 10.0,
        ),
        child: Card(
            margin: EdgeInsets.zero,
            child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Email : ${role.email}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              // Text(
                              //   "Role : ${role.role}",
                              //   style: const TextStyle(
                              //     fontSize: 16,
                              //     fontWeight: FontWeight.bold,
                              //   ),
                              // ),
                              DropdownButton<String>(
                                value: dropdownValue,
                                icon: const Icon(Icons.arrow_downward),
                                iconSize: 24,
                                elevation: 16,
                                style:
                                    const TextStyle(color: Colors.deepPurple),
                                underline: Container(
                                  height: 2,
                                  color: Colors.deepPurpleAccent,
                                ),
                                onChanged: (String? newValue) {
                                  dropdownValue = newValue!;
                                  roleController.updateRole(
                                      role, 'role', dropdownValue);
                                },
                                items: roles.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ]),
                        // ElevatedButton(
                        //   onPressed: () {
                        //     roleController.updateRole(role, 'role', role);
                        //   },
                        //   child: Text('Modify Role'),
                        // )
                      ])
                ]))));
  }
}

import 'package:flutter/material.dart';
import 'package:migo/layout/layout.dart';

class EmployeesPage extends StatefulWidget {
  const EmployeesPage({super.key});

  @override
  State<EmployeesPage> createState() => _EmployeesPageState();
}

class _EmployeesPageState extends State<EmployeesPage> {
  @override
  Widget build(BuildContext context) {
    return AppLayout(
      activeTab: 3,
      pageName: "Employees",
      content: Row(
        children: [
          InkWell(
            onTap: () {},
            child: Card(
              child: Column(
                children: const [
                  Text("Employees page"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

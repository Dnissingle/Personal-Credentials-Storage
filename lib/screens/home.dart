import 'package:flutter/material.dart';
import 'package:personal_credential_storage/widgets/home_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> dashboardItems = [
    {"icon": Icons.person, "text": "Personal Details"},
    {"icon": Icons.phone_android, "text": "App Logins"},
    {"icon": Icons.recent_actors, "text": "ID Cards"},
    {"icon": Icons.fact_check, "text": "Certificates"},
    {"icon": Icons.key, "text": "Authenticator"},
    {"icon": Icons.remember_me, "text": "Social Media"},
    //{"icon": Icons.settings_applications, "text": "Driver License"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Credential Storage"),
        centerTitle: true,
      ),
      drawer: Drawer(),
      body: Center(
        child: GridView.builder(
          padding: const EdgeInsets.all(10.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 5,
            mainAxisSpacing: 20,
          ),
          itemCount: dashboardItems.length,
          itemBuilder: (context, index) {
            final item = dashboardItems[index];
            return HomeWidgets(
              icon: item["icon"],
              text: item["text"],
            );
          }
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
      ],),
    );
  }
}

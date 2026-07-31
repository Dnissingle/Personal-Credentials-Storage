import 'package:flutter/material.dart';
import 'package:personal_credential_storage/widgets/home_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Map<String, dynamic>> dashboardItems = [
    {"icon": Icons.person, "text": "Personal Details","route": "/personalDetails"},
    {"icon": Icons.phone_android, "text": "App Logins","route": "/appLogins"},
    {"icon": Icons.recent_actors, "text": "ID Cards"},
    {"icon": Icons.fact_check, "text": "Certificates"},
    {"icon": Icons.key, "text": "Authenticator"},
    {"icon": Icons.remember_me, "text": "Social Media"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Credential Storage"),
        centerTitle: true,
      ),
      drawer: const Drawer(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10, // Adjusted for cleaner visual spacing
            mainAxisSpacing: 20,
          ),
          itemCount: dashboardItems.length,
          itemBuilder: (context, index) {
            final item = dashboardItems[index];
           return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context,
                    item["route"],
                    arguments: item["text"]
                );
              },
              child: HomeWidgets(
                icon: item["icon"],
                text: item["text"],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
        ],
      ),
    );
  }
}

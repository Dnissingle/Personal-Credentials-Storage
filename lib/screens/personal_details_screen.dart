import 'package:flutter/material.dart';

class PersonalDetailsScreen extends StatefulWidget {
  const PersonalDetailsScreen({super.key});

  @override
  State<PersonalDetailsScreen> createState() => _PersonalDetailsScreenState();
}

class _PersonalDetailsScreenState extends State<PersonalDetailsScreen> {
  int _currentIndex = 0;

  String firstName = "";
  String lastName = "";
  String email = "";
  int phoneNumber = 0;
  String address = "";
  int dateOfBirth = 0;

  List<Widget> get _pages => [
    ViewPage(firstName: firstName, lastName: lastName, email: email, phoneNumber: phoneNumber, address: address, dateOfBirth: dateOfBirth),
  EditPage(
  onSave: (fName, lName, mail, phone, addr, dob) {
  setState(() {
  firstName = fName;
  lastName = lName;
  email = mail;
  phoneNumber = phone;
  address = addr;
  dateOfBirth = dob;
  _currentIndex = 0; // Automatically switches back to View tab on save
  });
  },
  ),
  ];


  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Personal Details"),
        centerTitle: true,
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.view_list),
            label: 'View',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            label: 'Edit',
          ),
        ],
      currentIndex: _currentIndex,
      selectedItemColor: Colors.amber[800],
      onTap: _onItemTapped,
      ),
    );
  }
}

class ViewPage extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String email;
  final int phoneNumber;
  final String address;
  final int dateOfBirth;
  const ViewPage({super.key, required this.firstName, required this.lastName, required this.email, required this.phoneNumber, required this.address, required this.dateOfBirth});

  @override
  State<ViewPage> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            widget.firstName.isNotEmpty ? Text("First Name: ${widget.firstName}") : const Text("First Name: N/A"),
            widget.lastName.isNotEmpty ? Text("Last Name: ${widget.lastName}") : const Text("Last Name: N/A"),
            widget.email.isNotEmpty ? Text("Email: ${widget.email}") : const Text("Email: N/A"),
            widget.phoneNumber != 0 ? Text("Phone Number: ${widget.phoneNumber}") : const Text("Phone Number: N/A"),
            widget.address.isNotEmpty ? Text("Address: ${widget.address}") : const Text("Address: N/A"),
            widget.dateOfBirth != 0 ? Text("Date of Birth: ${widget.dateOfBirth}") : const Text("Date of Birth: N/A"),


            ]
        )
      )
    );
  }
}

class EditPage extends StatefulWidget {
  final Function(String, String, String, int, String, int) onSave;
  const EditPage({super.key, required this.onSave});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String firstName = "";
  String lastName = "";
  String email = "";
  int phoneNumber = 0;
  String address = "";
  int dateOfBirth = 0;


  void _submit(){
    if(!_formKey.currentState!.validate()){
      return;
    }
    _formKey.currentState!.save();
    widget.onSave(firstName, lastName, email, phoneNumber, address, dateOfBirth);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(padding: EdgeInsets.all(10),
      child: SingleChildScrollView(child:  Column(
        children:<Widget>[
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "First Name",
                    border: OutlineInputBorder(),
                    hintText: "Enter your first name",

                  ),
                  onSaved: (value){
                    firstName = value!;
                  },
                  validator: (value){
                    if(value!.isEmpty){
                      return "Please enter your first name";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10,),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Last Name",
                    hintText: "Enter your last name",
                    border: OutlineInputBorder(),
                  ),
                  onSaved: (value){
                    lastName = value!;
                  },
                  validator: (value){
                    if(value!.isEmpty){
                      return "Please enter your last name";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10,),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Email",
                    hintText: "Enter your email",
                    border: OutlineInputBorder(),

                  ),
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (value){
                    email = value!;
                  },
                  validator: (value){
                    if(value!.isEmpty){
                      return "Please enter your email";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 10,),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Phone Number",
                    hintText: "Enter your phone number",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                  onSaved: (value){
                    phoneNumber = int.parse(value!);
                  },
                  validator: (value){
                    if(value!.isEmpty){
                      return "Please enter your phone number";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10,),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Address",
                    hintText: "Enter your address",
                    border: OutlineInputBorder(),
                  ),

                  onSaved: (value){
                    address = value!;
                  },
                  validator: (value){
                    if(value!.isEmpty){
                      return "Please enter your address";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10,),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Date of Birth",
                    hintText: "Enter your date of birth",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.datetime,
                  onSaved: (value){
                    dateOfBirth = int. tryParse(value ?? "") ?? 0;
                  },
                  validator: (value){
                    if(value!.isEmpty){
                      return "Please enter your date of birth";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10,),
                ElevatedButton(
                  onPressed: _submit,
                  child: const Text("Done"),
                ),
                const SizedBox(height: 10,),


                ]
            )
          )
        ]
      )
      )
      )
    );
  }
}


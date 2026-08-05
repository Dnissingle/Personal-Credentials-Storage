import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PersonalDetailsScreen extends StatefulWidget {
  const PersonalDetailsScreen({super.key});

  @override
  State<PersonalDetailsScreen> createState() => _PersonalDetailsScreenState();
}

class _PersonalDetailsScreenState extends State<PersonalDetailsScreen> {
  int _selectedIndex = 0;

  // 1. Hoist data variables up to the parent container
  String firstName = "";
  String lastName = "";
  String middleName = "";
  String dob = "";
  String address = "";
  String phone = "";
  String gender = "";
  String nationality = "";
  String fatherName = "";
  String motherName = "";
  String email = "";

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // 2. Callback function to let the edit page update parent state
  void _updateDetails({
    required String fName,
    required String lName,
    required String mName,
    required String birthDate,
    required String addr,
    required String ph,
    required String gen,
    required String nat,
    required String father,
    required String mother,
    required String mail,
  }) {
    setState(() {
      firstName = fName;
      lastName = lName;
      middleName = mName;
      dob = birthDate;
      address = addr;
      phone = ph;
      gender = gen;
      nationality = nat;
      fatherName = father;
      motherName = mother;
      email = mail;
      _selectedIndex = 0; // Automatically switch back to the View tab on save
    });
  }

  @override
  Widget build(BuildContext context) {
    // 3. Build widgets dynamically to supply current variable states
    final List<Widget> widgetOptions = <Widget>[
      PersonalDetailsViewPage(
        firstName: firstName,
        lastName: lastName,
        middleName: middleName,
        dob: dob,
        address: address,
        phone: phone,
        gender: gender,
        nationality: nationality,
        fatherName: fatherName,
        motherName: motherName,
        email: email,
      ),
      PersonalDetailsEditPage(
        // Pass current values to initialize the text fields when switching tabs
        initialFirstName: firstName,
        initialLastName: lastName,
        initialMiddleName: middleName,
        initialDob: dob,
        initialAddress: address,
        initialPhone: phone,
        initialGender: gender,
        initialNationality: nationality,
        initialFatherName: fatherName,
        initialMotherName: motherName,
        initialEmail: email,
        onSave: _updateDetails,
      ),
    ];

    return Scaffold(
      body: Center(child: widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.view_list), label: "View"),
          BottomNavigationBarItem(icon: Icon(Icons.edit), label: "Edit"),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class PersonalDetailsViewPage extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String middleName;
  final String dob;
  final String address;
  final String phone;
  final String gender;
  final String nationality;
  final String fatherName;
  final String motherName;
  final String email;

  const PersonalDetailsViewPage({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.middleName,
    required this.dob,
    required this.address,
    required this.phone,
    required this.gender,
    required this.nationality,
    required this.fatherName,
    required this.motherName,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Personal Details"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailRow(context, "Full Name", "$firstName $middleName $lastName".replaceAll(RegExp(r'\s+'), ' ')),
                _buildDetailRow(context, "Date of Birth", dob),
                _buildDetailRow(context, "Gender", gender),
                _buildDetailRow(context, "Nationality", nationality),
                const Divider(indent: 16, endIndent: 16),
                _buildDetailRow(context, "Email", email),
                _buildDetailRow(context, "Phone", phone),
                _buildDetailRow(context, "Address", address),
                const Divider(indent: 16, endIndent: 16),
                _buildDetailRow(context, "Father's Name", fatherName),
                _buildDetailRow(context, "Mother's Name", motherName),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 2. Updated row builder to include context and a copy action icon button
  Widget _buildDetailRow(BuildContext context, String label, String value) {
    final String displayValue = value.trim().isEmpty ? "Not Provided" : value.trim();
    final bool isCopyable = value.trim().isNotEmpty;

    return ListTile(
      title: Text(
        label,
        style: const TextStyle(fontSize: 13, color: Colors.grey, fontWeight: FontWeight.w500),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 2.0),
        child: Text(
          displayValue,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
      ),
      // Appends an action icon button at the trailing end of the list element row
      trailing: isCopyable
          ? IconButton(
        icon: const Icon(Icons.copy, size: 20, color: Colors.blueGrey),
        tooltip: 'Copy $label',
        onPressed: () async {
          // Copies the targeted data value string onto the device's system clipboard
          await Clipboard.setData(ClipboardData(text: displayValue));

          // Displays a brief snackbar confirmation feedback to the end user
          if (context.mounted) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('$label copied to clipboard!'),
                duration: const Duration(seconds: 2),
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
      )
          : null, // Hides the copy action asset icon if the text field string is blank
    );
  }
}
class PersonalDetailsEditPage extends StatefulWidget {
  final String initialFirstName;
  final String initialLastName;
  final String initialMiddleName;
  final String initialDob;
  final String initialAddress;
  final String initialPhone;
  final String initialGender;
  final String initialNationality;
  final String initialFatherName;
  final String initialMotherName;
  final String initialEmail;
  final Function({
    required String fName,
    required String lName,
    required String mName,
    required String birthDate,
    required String addr,
    required String ph,
    required String gen,
    required String nat,
    required String father,
    required String mother,
    required String mail,
  })
  onSave;

  const PersonalDetailsEditPage({
    super.key,
    required this.initialFirstName,
    required this.initialLastName,
    required this.initialMiddleName,
    required this.initialDob,
    required this.initialAddress,
    required this.initialPhone,
    required this.initialGender,
    required this.initialNationality,
    required this.initialFatherName,
    required this.initialMotherName,
    required this.initialEmail,
    required this.onSave,
  });

  @override
  State<PersonalDetailsEditPage> createState() =>
      _PersonalDetailsEditPageState();
}

class _PersonalDetailsEditPageState extends State<PersonalDetailsEditPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String firstName;
  late String lastName;
  late String middleName;
  late String dob;
  late String address;
  late String phone;
  late String gender;
  late String nationality;
  late String fatherName;
  late String motherName;
  late String email;

  @override
  void initState() {
    super.initState();
    // Load existing values into editing variables
    firstName = widget.initialFirstName;
    lastName = widget.initialLastName;
    middleName = widget.initialMiddleName;
    dob = widget.initialDob;
    address = widget.initialAddress;
    phone = widget.initialPhone;
    gender = widget.initialGender;
    nationality = widget.initialNationality;
    fatherName = widget.initialFatherName;
    motherName = widget.initialMotherName;
    email = widget.initialEmail;
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Execute the callback function to send the data upstream
      widget.onSave(
        fName: firstName,
        lName: lastName,
        mName: middleName,
        birthDate: dob,
        addr: address,
        ph: phone,
        gen: gender,
        nat: nationality,
        father: fatherName,
        mother: motherName,
        mail: email,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Personal Details"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      initialValue: firstName,
                      decoration: const InputDecoration(
                        labelText: "First Name",
                        hintText: "Enter your first name",
                      ),
                      onSaved: (value) => firstName = value ?? "",
                    ),
                    TextFormField(
                      initialValue: lastName,
                      decoration: const InputDecoration(
                        labelText: "Last Name",
                        hintText: "Enter your last name",
                      ),
                      onSaved: (value) => lastName = value ?? "",
                    ),
                    TextFormField(
                      initialValue: middleName,
                      decoration: const InputDecoration(
                        labelText: "Middle Name",
                        hintText: "Enter your middle name",
                      ),
                      onSaved: (value) => middleName = value ?? "",
                    ),
                    TextFormField(
                      initialValue: dob,
                      decoration: const InputDecoration(
                        labelText: "Date of Birth",
                        hintText: "Enter your date of birth",
                      ),
                      onSaved: (value) => dob = value ?? "",
                    ),
                    TextFormField(
                      initialValue: address,
                      decoration: const InputDecoration(
                        labelText: "Address",
                        hintText: "Enter your address",
                      ),
                      onSaved: (value) => address = value ?? "",
                    ),
                    TextFormField(
                      initialValue: phone,
                      decoration: const InputDecoration(
                        labelText: "Phone Number",
                        hintText: "Enter your phone number",
                      ),
                      keyboardType: TextInputType.phone,
                      onSaved: (value) => phone = value ?? "",
                    ),
                    TextFormField(
                      initialValue: nationality,
                      decoration: const InputDecoration(
                        labelText: "Nationality",
                        hintText: "Enter your nationality",
                      ),
                      onSaved: (value) => nationality = value ?? "",
                    ),
                    TextFormField(
                      initialValue: gender,
                      decoration: const InputDecoration(
                        labelText: "Gender",
                        hintText: "Enter your gender",
                      ),
                      onSaved: (value) => gender = value ?? "",
                    ),
                    TextFormField(
                      initialValue: fatherName,
                      decoration: const InputDecoration(
                        labelText: "Father's Name",
                        hintText: "Enter your father's name",
                      ),
                      onSaved: (value) => fatherName = value ?? "",
                    ),
                    TextFormField(
                      initialValue: motherName,
                      decoration: const InputDecoration(
                        labelText: "Mother's Name",
                        hintText: "Enter your mother's name",
                      ),
                      onSaved: (value) => motherName = value ?? "",
                    ),
                    TextFormField(
                      initialValue: email,
                      decoration: const InputDecoration(
                        labelText: "Email",
                        hintText: "Enter your email",
                      ),
                      keyboardType: TextInputType.emailAddress,
                      onSaved: (value) => email = value ?? "",
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _save,
                child: const Text("Save"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

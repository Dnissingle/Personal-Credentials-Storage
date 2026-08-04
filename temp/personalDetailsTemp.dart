import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(
    const MaterialApp(
      home: PersonalDetailsScreen(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class PersonalDetailsScreen extends StatefulWidget {
  const PersonalDetailsScreen({super.key});

  @override
  State<PersonalDetailsScreen> createState() => _PersonalDetailsScreenState();
}

class _PersonalDetailsScreenState extends State<PersonalDetailsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isEditing = false;

  // Centralized controllers managing the text data state
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _middleNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  void _saveData() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    setState(() {
      _isEditing = false; // Swap back to clean display view
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Data successfully saved locally!")),
    );
  }

  void _copyToClipboard(String text, String fieldName) {
    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Cannot copy an empty $fieldName!")),
      );
      return;
    }
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("$fieldName copied to clipboard!")));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Personal Details"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.cancel_rounded : Icons.edit_rounded),
            tooltip: _isEditing ? "Cancel" : "Edit Details",
            onPressed: () {
              setState(() {
                if (_isEditing) {
                  _formKey.currentState?.reset(); // Rollback un-saved inputs
                }
                _isEditing = !_isEditing;
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Clean conditional switching between our two isolated display/edit widgets
                if (_isEditing)
                  DetailsEditView(
                    firstNameController: _firstNameController,
                    middleNameController: _middleNameController,
                    lastNameController: _lastNameController,
                    emailController: _emailController,
                    phoneController: _phoneController,
                    addressController: _addressController,
                    dobController: _dobController,
                    onCopy: _copyToClipboard,
                  )
                else
                  DetailsDisplayView(
                    firstNameController: _firstNameController,
                    middleNameController: _middleNameController,
                    lastNameController: _lastNameController,
                    emailController: _emailController,
                    phoneController: _phoneController,
                    addressController: _addressController,
                    dobController: _dobController,
                    onCopy: _copyToClipboard,
                  ),
                const SizedBox(height: 25),
                if (_isEditing)
                  ElevatedButton.icon(
                    onPressed: _saveData,
                    icon: const Icon(Icons.check_circle),
                    label: const Text("Save Changes"),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 12,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// WIDGET 1: Mode for modifying data (displays all options with validation styling)
class DetailsEditView extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController middleNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController addressController;
  final TextEditingController dobController;
  final Function(String, String) onCopy;

  const DetailsEditView({
    super.key,
    required this.firstNameController,
    required this.middleNameController,
    required this.lastNameController,
    required this.emailController,
    required this.phoneController,
    required this.addressController,
    required this.dobController,
    required this.onCopy,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildBaseField(
          label: "First Name",
          hint: "Enter your first name",
          controller: firstNameController,
          onCopy: onCopy,
          validator: (v) =>
          (v == null || v.isEmpty) ? "First name cannot be empty" : null,
        ),
        _buildBaseField(
          label: "Middle Name",
          hint: "Enter your middle name",
          controller: middleNameController,
          onCopy: onCopy,
        ),
        _buildBaseField(
          label: "Last Name",
          hint: "Enter your last name",
          controller: lastNameController,
          onCopy: onCopy,
          validator: (v) =>
          (v == null || v.isEmpty) ? "Last name cannot be empty" : null,
        ),
        _buildBaseField(
          label: "Email",
          hint: "Enter your email",
          controller: emailController,
          onCopy: onCopy,
          keyboardType: TextInputType.emailAddress,
          validator: (v) =>
          (v == null || v.isEmpty) ? "Email cannot be empty" : null,
        ),
        _buildBaseField(
          label: "Phone Number",
          hint: "Enter your phone number",
          controller: phoneController,
          onCopy: onCopy,
          keyboardType: TextInputType.phone,
          validator: (v) =>
          (v == null || v.isEmpty) ? "Phone number cannot be empty" : null,
        ),
        _buildBaseField(
          label: "Address",
          hint: "Enter your address",
          controller: addressController,
          onCopy: onCopy,
          validator: (v) =>
          (v == null || v.isEmpty) ? "Address cannot be empty" : null,
        ),
        _buildBaseField(
          label: "Date of Birth",
          hint: "Enter your date of birth",
          controller: dobController,
          onCopy: onCopy,
          keyboardType: TextInputType.datetime,
          validator: (v) =>
          (v == null || v.isEmpty) ? "Date of birth cannot be empty" : null,
        ),
      ],
    );
  }
}

// WIDGET 2: Mode for showcasing data (only displays fields containing data)
class DetailsDisplayView extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController middleNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController addressController;
  final TextEditingController dobController;
  final Function(String, String) onCopy;

  const DetailsDisplayView({
    super.key,
    required this.firstNameController,
    required this.middleNameController,
    required this.lastNameController,
    required this.emailController,
    required this.phoneController,
    required this.addressController,
    required this.dobController,
    required this.onCopy,
  });

  bool _hasNoData(TextEditingController controller) {
    final text = controller.text.trim();
    return text.isEmpty || text == "0";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!_hasNoData(firstNameController))
          _buildBaseField(
            label: "First Name",
            hint: "",
            controller: firstNameController,
            onCopy: onCopy,
            readOnly: true,
          ),
        if (!_hasNoData(middleNameController))
          _buildBaseField(
            label: "Middle Name",
            hint: "",
            controller: middleNameController,
            onCopy: onCopy,
            readOnly: true,
          ),
        if (!_hasNoData(lastNameController))
          _buildBaseField(
            label: "Last Name",
            hint: "",
            controller: lastNameController,
            onCopy: onCopy,
            readOnly: true,
          ),
        if (!_hasNoData(emailController))
          _buildBaseField(
            label: "Email",
            hint: "",
            controller: emailController,
            onCopy: onCopy,
            readOnly: true,
          ),
        if (!_hasNoData(phoneController))
          _buildBaseField(
            label: "Phone Number",
            hint: "",
            controller: phoneController,
            onCopy: onCopy,
            readOnly: true,
          ),
        if (!_hasNoData(addressController))
          _buildBaseField(
            label: "Address",
            hint: "",
            controller: addressController,
            onCopy: onCopy,
            readOnly: true,
          ),
        if (!_hasNoData(dobController))
          _buildBaseField(
            label: "Date of Birth",
            hint: "",
            controller: dobController,
            onCopy: onCopy,
            readOnly: true,
          ),

        // Show fallback hint message if absolutely all fields evaluate to empty string states
        if (_hasNoData(firstNameController) &&
            _hasNoData(middleNameController) &&
            _hasNoData(lastNameController) &&
            _hasNoData(emailController) &&
            _hasNoData(phoneController) &&
            _hasNoData(addressController) &&
            _hasNoData(dobController))
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 40.0),
            child: Text(
              "No details provided yet. Click edit to begin.",
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ),
      ],
    );
  }
}

// Global UI engine shared across both subcomponents
Widget _buildBaseField({
  required String label,
  required String hint,
  required TextEditingController controller,
  required Function(String, String) onCopy,
  FormFieldValidator? validator,
  TextInputType keyboardType = TextInputType.text,
  bool readOnly = false,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16.0),
    child: TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      readOnly: readOnly,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          icon: const Icon(Icons.copy_rounded, size: 20),
          tooltip: "Copy $label",
          onPressed: () => onCopy(controller.text, label),
        ),
      ),
    ),
  );
}

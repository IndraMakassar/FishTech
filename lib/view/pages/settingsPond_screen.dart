import 'package:fishtech/view/widgets/custom_button.dart';
import 'package:fishtech/view/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

class SettingspondScreen extends StatefulWidget {
  const SettingspondScreen({Key? key}) : super(key: key);

  @override
  State<SettingspondScreen> createState() => _SettingspondScreenState();
}

class _SettingspondScreenState extends State<SettingspondScreen> {
  final _formKey = GlobalKey<FormState>();
  final Color _softGrayBlue = const Color(0xFFE0E2EC);
  
  // Constant styles
  static const _labelStyle = TextStyle(
    fontWeight: FontWeight.w600,
    color: Color(0xFF424242),
    fontSize: 14,
  );

  static const _sectionTitleStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Color(0xFF333333),
  );

  // Form controllers
  final _controllers = {
    'namePond': TextEditingController(),
    'fishType': TextEditingController(),
    'startDate': TextEditingController(),
    'fishPortSize': TextEditingController(),
    'sensorName': TextEditingController(),
    'minPh': TextEditingController(),
    'maxPh': TextEditingController(),
    'phInterval': TextEditingController(),
    'autofeederName': TextEditingController(),
    'feedingInterval': TextEditingController(),
    'portionControl': TextEditingController(),
  };

  // Expansion panel states
  final _expansionStates = {
    'general': false,
    'ph': false,
    'autofeeder': false,
  };

  @override
  void dispose() {
    _controllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    
    if (picked != null) {
      setState(() {
        _controllers['startDate']!.text = DateFormat('dd MMM yyyy').format(picked);
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final formData = Map.fromEntries(
        _controllers.entries.map((e) => MapEntry(e.key, e.value.text.trim()))
      );
      // TODO: Process form data
    }
  }

  Widget _buildFormRow({
    required String label,
    required String hintText,
    required String controllerKey,
    bool isDate = false,
    bool isNumber = false,
    String? unit,
    required String? Function(String?) validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Text(label, style: _labelStyle),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _controllers[controllerKey],
                        decoration: InputDecoration(
                          hintText: hintText,
                          border: const UnderlineInputBorder(),
                          enabledBorder: const UnderlineInputBorder(),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 13, 77, 129),
                              width: 2.0,
                            ),
                          ),
                          contentPadding: const EdgeInsets.only(bottom: 8.0),
                          hintStyle: TextStyle(color: Colors.grey[600]),
                          suffixText: unit,
                          suffixStyle: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                        style: TextStyle(color: Colors.grey[800]),
                        readOnly: isDate,
                        keyboardType: isNumber ? TextInputType.number : null,
                        inputFormatters: isNumber
                            ? [FilteringTextInputFormatter.digitsOnly]
                            : null,
                        validator: validator,
                      ),
                    ),
                    if (isDate)
                      IconButton(
                        icon: Icon(Icons.calendar_today,
                            size: 20, color: Colors.grey[700]),
                        onPressed: () => _selectDate(context),
                        padding: EdgeInsets.zero,
                      ),
                  ],
                ),
                const SizedBox(height: 4),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomExpansionTile({
    required String title,
    required Widget content,
    required String stateKey,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: _softGrayBlue,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            spreadRadius: 0,
            blurRadius: 6,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () => setState(() {
              _expansionStates[stateKey] = !_expansionStates[stateKey]!;
            }),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: _softGrayBlue,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 0,
                    blurRadius: 6,
                    offset: const Offset(0, 6),
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title, style: _sectionTitleStyle),
                  Icon(
                    _expansionStates[stateKey]! 
                        ? Icons.expand_less 
                        : Icons.expand_more,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
          if (_expansionStates[stateKey]!)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: content,
            ),
        ],
      ),
    );
  }

  Widget _buildFormDropdownWithUnderline({
    required String label,
    required String hintText,
    required String controllerKey,
    required List<String> items,
    required String? Function(String?) validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(label, style: _labelStyle),
          ),
          Expanded(
            flex: 5,
            child: DropdownButtonFormField<String>(
              value: _controllers[controllerKey]!.text.isNotEmpty 
                  ? _controllers[controllerKey]!.text 
                  : null,
              decoration: const InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.only(bottom: 4),
                border: UnderlineInputBorder(),
              ),
              items: items.map((item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) _controllers[controllerKey]!.text = value;
              },
              validator: validator,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(title: "Fish Pond Setting", showBackButton: true),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            const SizedBox(height: 12),
            _buildCustomExpansionTile(
              title: 'General Settings',
              stateKey: 'general',
              content: Column(
                children: [
                  _buildFormRow(
                    label: 'Name',
                    hintText: 'Kolam ikan Nila 1',
                    controllerKey: 'namePond',
                    validator: (value) => value?.isEmpty ?? true 
                        ? 'Nama kolam harus diisi' 
                        : null,
                  ),
                  _buildFormRow(
                    label: 'Fish Type',
                    hintText: 'Ikan Nila',
                    controllerKey: 'fishType',
                    validator: (value) => value?.isEmpty ?? true 
                        ? 'Jenis ikan harus diisi' 
                        : null,
                  ),
                  _buildFormRow(
                    label: 'Start Date',
                    hintText: '20 Des 2024',
                    controllerKey: 'startDate',
                    isDate: true,
                    validator: (value) => value?.isEmpty ?? true 
                        ? 'Tanggal mulai harus diisi' 
                        : null,
                  ),
                  _buildFormRow(
                    label: 'Fish Port Size',
                    hintText: '1.000.000',
                    controllerKey: 'fishPortSize',
                    isNumber: true,
                    unit: 'm²', // Added unit here
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Ukuran port ikan harus diisi';
                      }
                      if (double.tryParse(value!) == null) {
                        return 'Harus berupa angka';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            _buildCustomExpansionTile(
              title: 'pH Sensors',
              stateKey: 'ph',
              content: Column(
                children: [
                  _buildFormRow(
                    label: 'Sensor Name',
                    hintText: 'pH sensor 1',
                    controllerKey: 'sensorName',
                    validator: (value) => value?.isEmpty ?? true 
                        ? 'Nama sensor harus diisi' 
                        : null,
                  ),
                  _buildFormRow(
                    label: 'Minimum pH',
                    hintText: '6.5',
                    controllerKey: 'minPh',
                    isNumber: true,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Minimum pH harus diisi';
                      }
                      if (double.tryParse(value!) == null) {
                        return 'Harus berupa angka';
                      }
                      return null;
                    },
                  ),
                  _buildFormRow(
                    label: 'Maximum pH',
                    hintText: '6.8',
                    controllerKey: 'maxPh',
                    isNumber: true,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Maksimum pH harus diisi';
                      }
                      if (double.tryParse(value!) == null) {
                        return 'Harus berupa angka';
                      }
                      return null;
                    },
                  ),
                  _buildFormDropdownWithUnderline(
                    label: 'ph cek interval',
                    hintText: '30 min',
                    controllerKey: 'phInterval',
                    items: const ['15 min', '30 min', '1 hour', '2 hours'],
                    validator: (value) => value?.isEmpty ?? true
                        ? 'Interval pengecekan pH harus diisi'
                        : null,
                  ),
                ],
              ),
            ),
            _buildCustomExpansionTile(
              title: 'Autofeeder',
              stateKey: 'autofeeder',
              content: Column(
                children: [
                  _buildFormRow(
                    label: 'Autofeeder Name',
                    hintText: 'Autofeeder 1',
                    controllerKey: 'autofeederName',
                    validator: (value) => value?.isEmpty ?? true 
                        ? 'Nama autofeeder harus diisi' 
                        : null,
                  ),
                  _buildFormDropdownWithUnderline(
                    label: 'Feeding Interval',
                    hintText: '1 hour',
                    controllerKey: 'feedingInterval',
                    items: const ['1 hour', '2 hour', '3 hour'],
                    validator: (value) => value?.isEmpty ?? true
                        ? 'Interval pemberian pakan harus diisi'
                        : null,
                  ),
                  _buildFormRow(
                    label: 'Portion Control',
                    hintText: '100',
                    controllerKey: 'portionControl',
                    isNumber: true,
                    unit: 'gram', // Added unit here
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Kontrol porsi harus diisi';
                      }
                      if (int.tryParse(value!) == null) {
                        return 'Harus berupa angka';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 80),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomButton(
                text: "Save",
                onPressed: _submitForm,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
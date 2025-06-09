import 'package:fishtech/view/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class PondSettingsScreen extends StatefulWidget {
  const PondSettingsScreen({super.key});

  @override
  State<PondSettingsScreen> createState() => _PondSettingsScreenState();
}

class _PondSettingsScreenState extends State<PondSettingsScreen> {
  final TextEditingController pondNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void showTextInputDialog({
      required BuildContext context,
      required String title,
      String initialValue = "",
      String hintText = "Enter value",
      TextInputType keyboardType = TextInputType.text,
      required ValueChanged<String> onSave,
    }) {
      final TextEditingController controller =
          TextEditingController(text: initialValue);
      showDialog(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            title: Text(title),
            content: TextField(
              controller: controller,
              autofocus: true,
              decoration: InputDecoration(hintText: hintText),
              keyboardType: keyboardType,
            ),
            actions: <Widget>[
              TextButton(
                child: const Text("Cancel"),
                onPressed: () => Navigator.of(dialogContext).pop(),
              ),
              ElevatedButton(
                // Or TextButton
                child: const Text("OK"),
                onPressed: () {
                  onSave(controller.text);
                  Navigator.of(dialogContext).pop();
                },
              ),
            ],
          );
        },
      );
    }

    void showRadioSelectionDialog<T>({
      required BuildContext context,
      required String title,
      required T currentValue,
      required List<T> options,
      Map<T, String>? optionTitles, // Optional map for custom titles
      required ValueChanged<T?> onSave,
    }) {
      T? groupValue = currentValue; // Temporary state for the dialog

      showDialog(
        context: context,
        builder: (dialogContext) {
          // Use StatefulBuilder to manage the internal state of the dialog (which radio is selected)
          return StatefulBuilder(
            builder: (stfContext, stfSetState) {
              return AlertDialog(
                title: Text(title),
                content: SingleChildScrollView(
                  // In case of many options
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: options.map((option) {
                      final String displayTitle = optionTitles?[option] ??
                          option.toString().split('.').last;
                      return RadioListTile<T>(
                        title: Text(displayTitle),
                        value: option,
                        groupValue: groupValue,
                        onChanged: (T? newValue) {
                          stfSetState(() {
                            // Update the dialog's internal state
                            groupValue = newValue;
                          });
                        },
                      );
                    }).toList(),
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text("Cancel"),
                    onPressed: () => Navigator.of(dialogContext).pop(),
                  ),
                  ElevatedButton(
                    // Or TextButton
                    child: const Text("OK"),
                    onPressed: () {
                      onSave(groupValue);
                      Navigator.of(dialogContext).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
      );
    }

    return Scaffold(
        appBar: const Header(
          title: "Pond Settings",
          showBackButton: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "General",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                title: const Text("Pond Name"),
                subtitle: const Text("kolam mas"),
                onTap: () {
                  showTextInputDialog(
                    context: context,
                    title: "Edit Pond Name",
                    initialValue: "kolam mas",
                    hintText: "Enter pond name",
                    onSave: (_) {},
                  );
                },
              ),
              ListTile(
                title: const Text("Pond Volume"),
                subtitle: const Text("100m3"),
                onTap: () {
                  showTextInputDialog(
                    context: context,
                    title: "Edit Pond Volume",
                    initialValue: "100m3",
                    hintText: "Enter pond volume",
                    onSave: (_) {},
                  );
                },
              ),
              ListTile(
                title: const Text("Fish Type"),
                subtitle: const Text("Nila"),
                onTap: () {
                  showRadioSelectionDialog(
                    context: context,
                    title: "Select Fish Type",
                    currentValue: "Nila",
                    options: ["Nila", "Lele"],
                    onSave: (_) {},
                  );
                },
              ),
              ListTile(
                title: const Text("Fish Amount"),
                subtitle: const Text("100"),
                onTap: () {
                  showTextInputDialog(
                    context: context,
                    title: "Edit Fish Amount",
                    initialValue: "100",
                    hintText: "Enter fish amount",
                    onSave: (_) {},
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Autofeeder",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SwitchListTile(
                title: const Text("Autofeeder Enabled"),
                value: true,
                onChanged: (bool newValue) {},
              ),
              ListTile(
                title: const Text("Autofeeder Name"),
                subtitle: const Text("Autofeeder 1"),
                onTap: () {
                  showTextInputDialog(
                    context: context,
                    title: "Edit Autofeeder Name",
                    initialValue: "Autofeeder 1",
                    hintText: "Enter autofeeder name",
                    onSave: (_) {},
                  );
                },
              ),
              ListTile(
                title: const Text("Feed Size"),
                subtitle: const Text("Small"),
                onTap: () {
                  showRadioSelectionDialog(
                    context: context,
                    title: "Select Feed Size",
                    currentValue: "Small",
                    options: ["Small", "Medium", "Big"],
                    onSave: (_) {},
                  );
                },
              ),
              const Gap(16),
              ListTile(
                title: const Text(
                  "Delete Pond",
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () {
                  // Show a confirmation dialog
                  showDialog(
                    context: context,
                    builder: (BuildContext dialogContext) {
                      return AlertDialog(
                        title: const Text("Confirm Delete"),
                        content: const Text("Are you sure you want to delete this pond and all its associated data? This action cannot be undone."),
                        actions: <Widget>[
                          TextButton(
                            child: const Text("Cancel"),
                            onPressed: () {
                              Navigator.of(dialogContext).pop();
                            },
                          ),
                          TextButton(
                            child: const Text("Delete", style: TextStyle(color: Colors.red)),
                            onPressed: () {
                              // Dispatch event to BLoC
                              Navigator.of(dialogContext).pop(); // Close dialog
                              // Potentially navigate away from the settings page if the pond is deleted
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              )
            ],
          ),
        ));
  }
}

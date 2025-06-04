part of 'pages.dart';


class AddPond extends StatefulWidget {
  const AddPond({super.key});

  @override
  State<AddPond> createState() => _AddPondState();


}

class _AddPondState extends State<AddPond> {

  @override
  void dispose() {
    _namePond.dispose();
    _fishType.dispose();
    _fishAmount.dispose();
    _startDate.dispose();
    _volume.dispose();
    super.dispose();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _namePond = TextEditingController();
  final TextEditingController _fishType = TextEditingController();
  final TextEditingController _fishAmount = TextEditingController();
  final TextEditingController _startDate = TextEditingController();
  final TextEditingController _volume = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: const Header(title: 'Add Fish Pond', showBackButton: true),
      body: BlocConsumer<PondBloc, PondState>(listener: (context, state) {
        if (state is PondAddSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Pond added successfully!'),
              ),);
          GoRouter.of(context).go('/home');
        } else if (state is PondFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to add pond: ${state.message}'),
              backgroundColor: colorScheme.error,
            ),
          );
        }
      }, builder: (context, state) {
        if (state is PondLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Gap(20),
                Form(key: _formKey,
                  child: OverflowBar(
                    overflowAlignment: OverflowBarAlignment.start,
                    alignment: MainAxisAlignment.start,
                    overflowSpacing: 10,
                    children: [
                      FormFieldWidget(
                        title: "Name",
                        controller: _namePond,
                        hintText: "Enter your Fish Pond Name",
                        autofillHints: const [AutofillHints.name],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your pond name';
                          }
                          return null;
                        },),
                      FormFieldWidget(title: "Fish Type",
                        controller: _fishType,
                        hintText: "Enter your Fish Type",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your fish type';
                          }
                          return null;
                        },),
                      FormFieldWidget(
                        title: "Fish Amount",
                        controller: _fishAmount,
                        hintText: "Enter your Fish Amount",
                        keyboardType: TextInputType.number,
                        inputFormatter: FilteringTextInputFormatter.digitsOnly,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your fish amount';
                          }
                          return null;
                        },),
                      FormFieldWidget(
                        title: "Start Date",
                        controller: _startDate,
                        isDatePicker: true,
                        isReadOnly: true,
                        hintText: "Fill Start Date",
                        onDateSelected: (selectedDate) {
                          print("Tanggal dipilih: $selectedDate");
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the date';
                          }
                          return null;
                        },),
                      FormFieldWidget(
                        title: "Volume Pond (m\u00B3)",
                        controller: _volume,
                        keyboardType: TextInputType.number,
                        inputFormatter: FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,2}')),
                        hintText: "0 m\u00B3",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the pond volume';
                          }
                          return null;
                        },

                      ),
                      const Gap(5),
                      CustomButton(
                        text: "Add Pond",
                        isLoading: state is PondLoading,
                        onPressed: () {
                        _submitForm();
                        },
                      ),
                    ],),)
              ],)),);
      },),);
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      String name = _namePond.text.trim();
      String fish = _fishType.text.trim();
      String createdAtString = _startDate.text.trim(); // Keep the original string
      String fishAmount = _fishAmount.text.trim();
      String volume = _volume.text.trim();

      DateTime parsedDate;
      try {
        parsedDate = DateFormat("dd-MM-yyyy").parse(createdAtString);
      } catch (e) {
        print("Error parsing date: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid date format. Please use DD-MM-YYYY.')),
        );
        return;
      }

      final newPondModel = PondModel(
        id: '',
        createdAt: parsedDate,
        name: name,
        volume: double.parse(volume),
        fish: fish,
        fishAmount: int.parse(fishAmount),
      );

      context.read<PondBloc>().add(AddNewPond(pondModel: newPondModel));
    }
  }
}

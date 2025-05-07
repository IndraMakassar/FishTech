part of 'pages.dart';


class AddPond extends StatefulWidget {
  const AddPond({super.key});

  @override
  State<AddPond> createState() => _AddPondState();


}

class _AddPondState extends State<AddPond> {
  @override
  void initState() {
    super.initState();
    _length.addListener(_calculateVolume);
    _width.addListener(_calculateVolume);
    _height.addListener(_calculateVolume);
  }

  @override
  void dispose() {
    _namePond.dispose();
    _fishType.dispose();
    _startDate.dispose();
    _length.dispose();
    _width.dispose();
    _height.dispose();
    _volume.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _namePond = TextEditingController();
  final TextEditingController _fishType = TextEditingController();
  final TextEditingController _startDate = TextEditingController();
  final TextEditingController _length = TextEditingController();
  final TextEditingController _width = TextEditingController();
  final TextEditingController _height = TextEditingController();
  final TextEditingController _volume = TextEditingController();

  final _passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(title: 'Add Fish Pond', showBackButton: true),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state){
          if (state is AuthSuccess) {
            GoRouter.of(context).go('/addPond');
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state){
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Gap(20),
                  Form(
                    key: _formKey,
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
                          validator: (value){
                            if (value == null || value.isEmpty) {
                              return 'Please enter your pond name';
                            }
                            return null;
                          },
                        ),
                        FormFieldWidget(
                          title: "Fish Type",
                          controller: _fishType,
                          hintText: "Enter your Fish Type",
                          validator: (value){
                            if (value == null || value.isEmpty) {
                              return 'Please enter your fish type';
                            }
                            return null;
                          },
                        ),
                        FormFieldWidget(
                          title: "Start Date",
                          controller: _startDate,
                          isDatePicker: true,
                          isReadOnly: true,
                          hintText: "Fill Start Date",
                          onDateSelected: (selectedDate) {
                            print("Tanggal dipilih: $selectedDate");
                          },
                          validator: (value){
                            if (value == null || value.isEmpty) {
                              return 'Please enter the date';
                            }
                            return null;
                          },
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text("Pond Size (m)"),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FormFieldWidget(
                              width: MediaQuery.of(context).size.width / 4,
                              controller: _length,
                              labelText: "Length",
                              keyboardType: TextInputType.number,
                              validator: (value){
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the length';
                                }
                                return null;
                              },
                            ),
                            FormFieldWidget(
                              width: MediaQuery.of(context).size.width / 4,
                              controller: _width,
                              labelText: "Width",
                              keyboardType: TextInputType.number,
                              validator: (value){
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the width';
                                }
                                return null;
                              },
                            ),
                            FormFieldWidget(
                              width: MediaQuery.of(context).size.width / 4,
                              controller: _height,
                              labelText: "Height",
                              keyboardType: TextInputType.number,
                              validator: (value){
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the height';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                        FormFieldWidget(
                          title: "Volume Pond (m\u00B3)",
                          controller: _volume,
                          isReadOnly: true,
                          hintText: "0 m\u00B3",
                          validator: (value){
                            if (value == null || value.isEmpty) {
                              return 'Please enter the height';
                            }
                            return null;
                          },
                        ),
                        const Gap(5),
                        CustomButton(
                            text: "Add Pond",
                            onPressed: (){
                              _submitForm();
                            },
                        ),
                      ],
                    ),
                  )
                ],
              )
            ),
          );
        },
      ),
    );
  }
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      String name = _namePond.text.trim();
      String fish = _fishType.text.trim();
      String createdAt = _startDate.text.trim();
      String length = _length.text.trim();
      String width = _width.text.trim();
      String height = _height.text.trim();
      String volume = _volume.text.trim();

      // context
          // .read<AuthBloc>()
          // .add(UserSignIn(email: email, password: password));
    }
  }
  void _calculateVolume() {
    final l = double.tryParse(_length.text);
    final w = double.tryParse(_width.text);
    final h = double.tryParse(_height.text);

    if (l != null && w != null && h != null) {
      final v = l * w * h;
      _volume.text = '${v.toStringAsFixed(2)} m\u00b3'; // 2 angka di belakang koma
    } else {
      _volume.text = '0 m\u00b3';
    }
  }

}

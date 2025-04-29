part of 'widgets.dart';

class FormFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final double? width;
  final String? title;
  final String? labelText;
  final String? hintText;
  final IconData? prefixIcon;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final FocusNode? focusNode;
  final List<String>? autofillHints;
  final String? Function(String?)? validator;
  final void Function(String)? onFieldSubmitted;
  final bool isPassword;
  final double borderRadius;
  final bool isDatePicker;
  final bool isReadOnly;
  final void Function(DateTime?)? onDateSelected;

  const FormFieldWidget({
    super.key,
    required this.controller,
    this.width,
    this.title,
    this.labelText,
    this.hintText,
    this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.focusNode,
    this.autofillHints,
    this.validator,
    this.onFieldSubmitted,
    this.isPassword = false,
    this.borderRadius = 12,
    this.isDatePicker = false,
    this.isReadOnly =false,
    this.onDateSelected,

  });

  @override
  State<FormFieldWidget> createState() => _FormFieldWidgetState();
}

class _FormFieldWidgetState extends State<FormFieldWidget> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
          child: Text(
            widget.title!,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface
            ),
        ),
          )
        else
          const Gap(0),
        Container(
          width: widget.width,
          child: TextFormField(
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            focusNode: widget.focusNode,
            autofillHints: widget.autofillHints,
            obscureText: widget.isPassword ? _obscureText : false,
            style: const TextStyle(fontSize: 16),
            readOnly: widget.isReadOnly,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              labelText: widget.labelText,
              labelStyle: const TextStyle(
                  fontSize: 14,
              ),
              hintText: widget.hintText,
              hintStyle:  TextStyle(
                  fontSize: 13,
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)
              ),
              prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
              ),
              suffixIcon: widget.isPassword
                  ? IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    )
                  : widget.isDatePicker
                  ? IconButton(
                icon: const Icon(Icons.calendar_month),
                onPressed: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null) {
                    widget.controller.text =
                    "${pickedDate.day.toString().padLeft(2, '0')}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.year}";

                    // callback ke parent jika dibutuhkan
                    widget.onDateSelected?.call(pickedDate);
                  }
                },
              )
                  : null,
            ),
            validator: widget.validator,
            onFieldSubmitted: widget.onFieldSubmitted,
          ),
        ),
      ],
    );
  }
}

part of 'widgets.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? fontColour;
  final double height;
  final double borderRadius;
  final String? image;
  final double? outlineBorder;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.backgroundColor,
    this.fontColour,
    this.height = 64.0,
    this.borderRadius = double.infinity,
    this.image,
    this.outlineBorder
  });

  @override
  Widget build(BuildContext context) {
    final effectiveBackgroundColor = backgroundColor ?? Theme.of(context).colorScheme.primary;
    final effectiveFontColor = fontColour ?? Theme.of(context).colorScheme.onPrimary;

    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: FilledButton.styleFrom(
        elevation: 5,
        minimumSize: const Size.fromHeight(56),
        backgroundColor: effectiveBackgroundColor,
        disabledBackgroundColor: effectiveBackgroundColor,
        side: outlineBorder != null
          ? BorderSide(
              width: outlineBorder!,
              color: Theme.of(context).colorScheme.outline
            )
          : null
      ),
      child: isLoading
        ? SizedBox(
            height: 24,
            width: 24,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              valueColor: AlwaysStoppedAnimation<Color>(
                effectiveFontColor,
              ),
            ),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (image != null)
                SizedBox(
                  width: 24,
                  height: 24,
                  child: Image.asset(
                    image!,
                    fit: BoxFit.contain,
                  ),
                ),
              Text(
                text,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: effectiveFontColor,
                ),
              ),
            ],
          ),
    );
  }
}
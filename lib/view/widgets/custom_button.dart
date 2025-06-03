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
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        minimumSize: const Size.fromHeight(56),
        backgroundColor: backgroundColor,
        side: outlineBorder != null ? BorderSide(
          width: outlineBorder!,
          color: Theme.of(context).colorScheme.outline
        ): null
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (image != null)
            SizedBox(
              width: 24,
              height: 24,
              child:
                Image.asset(
                  image!,
                  fit: BoxFit.contain,
                ),
            ),
          Text(
            text,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: fontColour,
            ),
          ),
        ],
      ),
    );
  }
}

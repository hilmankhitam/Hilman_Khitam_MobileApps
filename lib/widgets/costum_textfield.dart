part of 'widgets.dart';

class CostumTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  const CostumTextField(
      {super.key,
      required this.controller,
      required this.labelText,
      required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        labelText: labelText,
        labelStyle: blackTextFont,
        hintText: hintText,
        hintStyle: blackTextFont.copyWith(
          color: Colors.black54,
        ),
      ),
    );
  }
}

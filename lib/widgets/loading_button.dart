part of 'widgets.dart';

class LoadingButton extends StatelessWidget {
  const LoadingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: mainColor,
        ),
        onPressed: () async {},
        child: const CircularProgressIndicator(),
      ),
    );
  }
}

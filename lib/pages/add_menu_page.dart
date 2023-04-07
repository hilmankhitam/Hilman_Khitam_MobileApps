part of 'pages.dart';

class AddMenuPage extends StatefulWidget {
  const AddMenuPage({super.key});

  @override
  State<AddMenuPage> createState() => _AddMenuPageState();
}

class _AddMenuPageState extends State<AddMenuPage> {
  TextEditingController foodCodeController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController pictureController = TextEditingController();
  TextEditingController pictureOriController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    foodCodeController.dispose();
    nameController.dispose();
    pictureController.dispose();
    pictureOriController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          SafeArea(
            child: Container(
              color: whiteColor,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Center(
            child: Text(
              'Menambahkan Menu',
              style: blackTextFont.copyWith(fontSize: 24),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          CostumTextField(
            controller: foodCodeController,
            labelText: 'Food Code',
            hintText: 'Food Code',
          ),
          const SizedBox(
            height: 16,
          ),
          CostumTextField(
            controller: nameController,
            labelText: 'Name',
            hintText: 'Name',
          ),
          const SizedBox(
            height: 16,
          ),
          CostumTextField(
            controller: pictureController,
            labelText: 'Picture',
            hintText: 'Picture',
          ),
          const SizedBox(
            height: 16,
          ),
          CostumTextField(
            controller: pictureOriController,
            labelText: 'Picture Ori',
            hintText: 'Picture Ori',
          ),
          const SizedBox(
            height: 16,
          ),
          CostumTextField(
            controller: priceController,
            labelText: 'Price',
            hintText: 'Price',
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: mainColor,
              ),
              onPressed: () async {
                if (foodCodeController.text.isNotEmpty &&
                    nameController.text.isNotEmpty &&
                    pictureController.text.isNotEmpty &&
                    priceController.text.isNotEmpty) {
                  ProductModel product = ProductModel(
                    foodCode: foodCodeController.text,
                    name: nameController.text,
                    picture: pictureController.text,
                    pictureOri: pictureOriController.text,
                    price: double.parse(priceController.text),
                  );
                  setState(() {
                    isLoading = true;
                  });
                  if (await ProductServices().addMenu(product: product)) {
                    Navigator.of(context).pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Data gagal ditambahkan')));
                  }
                } else {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text('Isi data')));
                }

                setState(() {
                  isLoading = false;
                });
              },
              child: isLoading
                  ? const CircularProgressIndicator()
                  : Text(
                      'Add Menu',
                      style: whiteTextFont,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

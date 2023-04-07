part of 'widgets.dart';

class CustomDialog extends StatefulWidget {
  const CustomDialog({super.key});

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  bool checkoutIsValid = false;

  TextEditingController uangDibayarController =
      TextEditingController(text: "0");
  TextEditingController kembalianController = TextEditingController(text: "0");
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/restaurant.png',
            color: mainColor,
            width: 20,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            'Detail Pesananan',
            style: blueTextFont,
          ),
        ],
      ),
      content: SizedBox(
        height: 300.0,
        width: 300.0,
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is! CartLoaded) {
              return const SizedBox();
            }
            Cart cart = state.cart;
            return state.cart.products.isEmpty
                ? Center(
                    child: Text(
                      'Belum ada order',
                      style: blackTextFont,
                    ),
                  )
                : ListView(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount:
                            cart.productQuantity(cart.products).keys.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ProductCheckoutCard(
                            product: cart
                                .productQuantity(cart.products)
                                .keys
                                .elementAt(index),
                            quantity: cart
                                .productQuantity(cart.products)
                                .values
                                .elementAt(index),
                          );
                        },
                      ),
                      Table(
                        columnWidths: const {
                          0: FractionColumnWidth(0.4),
                          2: FractionColumnWidth(0.5),
                        },
                        children: [
                          TableRow(children: [
                            Text(
                              'Total',
                              style: blackTextFont.copyWith(fontSize: 14),
                            ),
                            Text(
                              ':',
                              style: blackTextFont.copyWith(fontSize: 14),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 2),
                              padding: const EdgeInsets.only(right: 15),
                              alignment: Alignment.centerRight,
                              height: 30,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: Colors.grey.shade100,
                              ),
                              child: Text(
                                cart.total.toStringAsFixed(0),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ]),
                          TableRow(children: [
                            Text(
                              'Uang dibayar',
                              style: blackTextFont.copyWith(fontSize: 14),
                            ),
                            Text(
                              ':',
                              style: blackTextFont.copyWith(fontSize: 14),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 2),
                              alignment: Alignment.centerRight,
                              height: 30,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: Colors.grey.shade300,
                              ),
                              child: TextField(
                                controller: uangDibayarController,
                                textAlign: TextAlign.right,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none)),
                                onChanged: (value) {
                                  if (value == "") {
                                    uangDibayarController.text = "0";
                                  }
                                  setState(() {
                                    double kembalian =
                                        int.parse(uangDibayarController.text) -
                                            cart.total;
                                    kembalianController.text =
                                        kembalian.toStringAsFixed(0);
                                    if (kembalian >= 0 &&
                                        uangDibayarController.text.isNotEmpty) {
                                      checkoutIsValid = true;
                                    }
                                  });
                                },
                              ),
                            ),
                          ]),
                          TableRow(children: [
                            Text(
                              'Kembalian',
                              style: blackTextFont.copyWith(fontSize: 14),
                            ),
                            Text(
                              ':',
                              style: blackTextFont.copyWith(fontSize: 14),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 2),
                              alignment: Alignment.centerRight,
                              height: 30,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: Colors.grey.shade500,
                              ),
                              child: TextField(
                                enabled: false,
                                controller: kembalianController,
                                textAlign: TextAlign.right,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none)),
                                onChanged: (value) {},
                              ),
                            ),
                          ]),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: mainColor,
                        ),
                        onPressed: () {
                          if (checkoutIsValid) {
                            context.read<CartBloc>().add(CheckoutCart());
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Uangnya kurang')));
                          }
                        },
                        child: Text(
                          'Cetak Struk',
                          style: whiteTextFont.copyWith(fontSize: 14),
                        ),
                      ),
                    ],
                  );
          },
        ),
      ),
    );
  }
}

part of 'pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool onTapShowCart = false;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<ProductBloc>().add(FetchProduct());
      },
      child: Scaffold(
        body: Stack(
          children: [
            ListView(
              children: [
                // Search Bar
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  height: 55,
                  child: Row(
                    children: [
                      Flexible(
                        child: Container(
                          height: 55,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: const [
                              Icon(Icons.search),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // GridView Makanan
                BlocBuilder<ProductBloc, ProductState>(
                  builder: (_, productState) {
                    if (productState is ProductLoaded) {
                      List<ProductModel> products = productState.products;

                      return GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: MediaQuery.of(context).size.width /
                              (MediaQuery.of(context).size.height / 1.2),
                        ),
                        itemCount: products.length,
                        itemBuilder: (_, index) =>
                            GridListCard(product: products[index]),
                      );
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
                const SizedBox(
                  height: 80,
                ),
              ],
            ),
            // Navigation to Add Menu Page
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: mainColor,
                ),
                child: IconButton(
                  icon: const Icon(Icons.add),
                  color: whiteColor,
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(
                            builder: (_) => const AddMenuPage()))
                        .then((value) {
                      context.read<ProductBloc>().add(FetchProduct());
                    });
                  },
                ),
              ),
            ),
            // Cart
            Align(
              alignment: Alignment.bottomCenter,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: onTapShowCart ? 300 : 65,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border:
                        Border(top: BorderSide(color: mainColor, width: 1))),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Column(
                      children: [
                        BlocBuilder<CartBloc, CartState>(
                          builder: (context, state) {
                            if (state is CartLoading) {
                              return const SizedBox();
                            } else if (state is CartLoaded) {
                              return Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 18, vertical: 12),
                                height: 40,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Stack(
                                          children: [
                                            state.cart.products.isEmpty
                                                ? const SizedBox()
                                                : Positioned(
                                                    top: 0,
                                                    right: 0,
                                                    child: Container(
                                                      width: 20,
                                                      height: 20,
                                                      decoration:
                                                          const BoxDecoration(
                                                        color: Colors.red,
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Center(
                                                          child: Text(
                                                        "${state.cart.products.length}",
                                                        style: whiteTextFont,
                                                      )),
                                                    ),
                                                  ),
                                            Image.asset(
                                                'assets/shopping-bag.png'),
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 6,
                                        ),
                                        Text(
                                          NumberFormat.currency(locale: 'id')
                                              .format(state.cart.total),
                                          style: blackTextFont,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 120,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return const CustomDialog();
                                              }).then((value) {});
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: mainColor),
                                        child: Text(
                                          'Charge',
                                          style: whiteTextFont,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return const SizedBox();
                            }
                          },
                        ),
                        Expanded(child: cartProductLists()),
                      ],
                    ),
                    Positioned(
                      top: -15,
                      right: MediaQuery.of(context).size.width / 2 - 15,
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: mainColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                onTapShowCart = !onTapShowCart;
                              });
                            },
                            child: Image.asset(
                              onTapShowCart
                                  ? 'assets/down-arrow.png'
                                  : 'assets/up-arrow.png',
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget cartProductLists() {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoaded) {
          Cart cart = state.cart;
          if (cart.products.isEmpty) {
            return Center(
              child: Text(
                'Belum ada order',
                style: blackTextFont,
              ),
            );
          }
          return ListView.builder(
            itemCount: cart.productQuantity(cart.products).keys.length,
            itemBuilder: (context, index) {
              return ProductCartCard(
                product:
                    cart.productQuantity(cart.products).keys.elementAt(index),
                quantity:
                    cart.productQuantity(cart.products).values.elementAt(index),
              );
            },
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

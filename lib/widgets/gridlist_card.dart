part of 'widgets.dart';

class GridListCard extends StatelessWidget {
  final ProductModel product;
  const GridListCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Image.network(
                product.picture!,
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 2.2 - 180,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/restaurant.png',
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 2.2 - 180,
                  );
                },
              )),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              product.name!,
              style: blackTextFont,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  NumberFormat.currency(locale: 'id').format(product.price),
                  style: blueTextFont,
                ),
                const SizedBox(
                  width: 6,
                ),
                Text(
                  "/ Porsi",
                  style: blackTextFont.copyWith(color: Colors.grey),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            child: BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                if (state is CartLoaded) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mainColor,
                    ),
                    onPressed: () {
                      context.read<CartBloc>().add(
                            AddProductCart(product: product),
                          );
                    },
                    child: Text(
                      'Order',
                      style: whiteTextFont,
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

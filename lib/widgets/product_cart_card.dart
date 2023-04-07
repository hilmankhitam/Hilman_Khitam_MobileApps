part of 'widgets.dart';

class ProductCartCard extends StatelessWidget {
  final ProductModel product;
  final int quantity;
  const ProductCartCard(
      {super.key, required this.product, required this.quantity});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 65,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 55,
                height: 55,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(product.picture!),
                    fit: BoxFit.cover,
                    onError: (exception, stackTrace) {
                      return;
                    },
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    child: Text(
                      product.name!,
                      style: blackTextFont.copyWith(fontSize: 14),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        NumberFormat.currency(locale: 'id')
                            .format(product.price),
                        style: blueTextFont.copyWith(fontSize: 12),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Text(
                        "/ Porsi",
                        style: blackTextFont.copyWith(
                            color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            width: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 40,
                  height: 30,
                  decoration: BoxDecoration(
                    border: Border.all(color: mainColor, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      context
                          .read<CartBloc>()
                          .add(RemoveProductCart(product: product));
                    },
                    icon: const Icon(Icons.remove),
                    color: mainColor,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  '$quantity',
                  // '${cart.products[index].quantity}',
                  style: blackTextFont,
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  width: 40,
                  height: 30,
                  decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      context
                          .read<CartBloc>()
                          .add(AddProductCart(product: product));
                    },
                    icon: const Icon(Icons.add),
                    color: whiteColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

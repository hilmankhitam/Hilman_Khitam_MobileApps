part of 'widgets.dart';

class ProductCheckoutCard extends StatelessWidget {
  final ProductModel product;
  final int quantity;
  const ProductCheckoutCard(
      {super.key, required this.product, required this.quantity});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(product.picture!),
                    fit: BoxFit.cover,
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
                  Text(
                    product.name!,
                    style: blackTextFont.copyWith(fontSize: 14),
                  ),
                  Row(
                    children: [
                      Text(
                        NumberFormat.currency(locale: 'id')
                            .format(product.price),
                        style: blueTextFont.copyWith(fontSize: 14),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Text(
                        "/ Porsi",
                        style: blackTextFont.copyWith(
                            color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Text(
            'x$quantity',
            style: blackTextFont.copyWith(fontSize: 14),
          ),
        ],
      ),
    );
  }
}

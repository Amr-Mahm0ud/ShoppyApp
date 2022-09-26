import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/consts.dart';

class ProductTile extends StatelessWidget {
  const ProductTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Get.theme.cardColor),
        borderRadius: BorderRadius.circular(Consts.borderRadius),
      ),
      height: Get.height * 0.15,
      width: Get.width * 0.9,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              height: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Consts.borderRadius),
                  bottomLeft: Radius.circular(Consts.borderRadius),
                ),
                image: const DecorationImage(
                    image: AssetImage('assets/images/1.jpg'), fit: BoxFit.fill),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Product Name Product Name',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: Get.textTheme.titleMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'ProductType',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:
                        Get.textTheme.bodyText1!.copyWith(color: Colors.grey),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "\$ 30.00",
                    style: Get.textTheme.bodyText1!
                        .copyWith(color: Get.theme.primaryColor),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                icon: const Icon(Icons.favorite_outline),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}

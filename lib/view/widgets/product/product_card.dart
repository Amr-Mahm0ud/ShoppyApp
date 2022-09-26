import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/consts.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Get.theme.cardColor),
        borderRadius: BorderRadius.circular(Consts.borderRadius),
      ),
      height: Get.height * 0.27,
      width: Get.width * 0.375,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            height: Get.height * 0.15,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Consts.borderRadius),
                topRight: Radius.circular(Consts.borderRadius),
              ),
              image: const DecorationImage(
                  image: AssetImage('assets/images/1.jpg'), fit: BoxFit.fill),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ProductName',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: Get.textTheme.titleMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  'ProductType',
                  style: Get.textTheme.bodyText1!.copyWith(color: Colors.grey),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      "\$ 30.00",
                      style: Get.textTheme.bodyText1!
                          .copyWith(color: Get.theme.primaryColor),
                    ),
                    const Spacer(),
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: const Icon(Icons.favorite_outline),
                      onPressed: () {},
                    )
                  ],
                ),
              ],
            ),
          ),
          const Spacer()
        ],
      ),
    );
  }
}

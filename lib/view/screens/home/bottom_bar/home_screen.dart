import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppy/view/widgets/product/product_card.dart';

import '../../../../utils/consts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          Get.width * 0.05,
          0,
          Get.width * 0.05,
          MediaQuery.of(context).padding.bottom,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: Get.height * 0.25,
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(vertical: 15),
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: Consts.categoriesImages.length,
                itemBuilder: (context, index) =>
                    categoryCard(Consts.categoriesImages[index]),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              'Recommended',
              style: Get.textTheme.headline6!
                  .copyWith(fontWeight: FontWeight.normal),
            ),
            buildSection(),
            const SizedBox(height: 10),
            Text(
              'Hot Deals',
              style: Get.textTheme.headline6!
                  .copyWith(fontWeight: FontWeight.normal),
            ),
            buildSection(),
            const SizedBox(height: 10),
            Text(
              'Top Rated',
              style: Get.textTheme.headline6!
                  .copyWith(fontWeight: FontWeight.normal),
            ),
            buildSection(),
          ],
        ),
      ),
    );
  }

  SizedBox buildSection() {
    List items = [1, 2, 3, 4, 5];
    return SizedBox(
      height: Get.height * 0.3,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: items.map(
            (item) {
              return Padding(
                padding: EdgeInsets.only(
                  left: items.first == item ? 0 : 7,
                  right: items.last == item ? 0 : 7,
                ),
                child: const ProductCard(),
              );
            },
          ).toList(),
        ),
      ),
    );
  }

  Container categoryCard(image) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Get.theme.cardColor),
        color: Get.theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(Consts.borderRadius),
        // boxShadow: [
        //   BoxShadow(
        //       blurRadius: 10,
        //       spreadRadius: 0,
        //       blurStyle: BlurStyle.normal,
        //       color: Get.isDarkMode
        //           ? Get.theme.primaryColor.withOpacity(0.1)
        //           : Colors.black.withOpacity(0.075),
        //       offset: const Offset(5, 5)),
        // ],
      ),
      padding: const EdgeInsets.all(5),
      child: Image.asset(image),
    );
  }
}

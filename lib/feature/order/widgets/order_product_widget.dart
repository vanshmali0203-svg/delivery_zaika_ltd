import 'package:get/get.dart';

import '../../../helper/export.dart';

class OrderProductWidgetWidget extends StatelessWidget {
  final OrderModel order;
  final OrderDetailsModel orderDetails;
  const OrderProductWidgetWidget(
      {super.key, required this.order, required this.orderDetails});

  @override
  Widget build(BuildContext context) {
    String addOnText = '';
    for (var addOn in orderDetails.addOns!) {
      addOnText =
          '$addOnText${(addOnText.isEmpty) ? '' : ',  '}${addOn.name} (${addOn.quantity})';
    }

    String? variationText = '';

    if (orderDetails.variation!.isNotEmpty) {
      for (Variation variation in orderDetails.variation!) {
        variationText =
            '${variationText!}${variationText.isNotEmpty ? ', ' : ''}${variation.name} (';
        for (VariationValue value in variation.variationValues!) {
          variationText =
              '${variationText!}${variationText.endsWith('(') ? '' : ', '}${value.level}';
        }
        variationText = '${variationText!})';
      }
    } else if (orderDetails.oldVariation!.isNotEmpty) {
      variationText = orderDetails.oldVariation![0].type;
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
          child: CustomImageWidget(
            image: '${orderDetails.foodDetails!.imageFullUrl}',
            height: 50,
            width: 50,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: Dimensions.paddingSizeSmall),
        Expanded(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Expanded(
                  child: Text(
                orderDetails.foodDetails!.name!,
                style:
                    robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              )),
              Text('${'quantity'.tr}:',
                  style: robotoRegular.copyWith(
                      fontSize: Dimensions.fontSizeSmall)),
              Text(
                orderDetails.quantity.toString(),
                style: robotoMedium.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontSize: Dimensions.fontSizeSmall),
              ),
            ]),
            const SizedBox(height: Dimensions.paddingSizeExtraSmall),
            Row(children: [
              Text(
                PriceConverter.convertPrice(
                    orderDetails.price! - orderDetails.discountOnFood!),
                style: robotoMedium,
              ),
              const SizedBox(width: Dimensions.paddingSizeExtraSmall),
              orderDetails.discountOnFood! > 0
                  ? Expanded(
                      child: Text(
                      PriceConverter.convertPrice(orderDetails.price),
                      style: robotoMedium.copyWith(
                        decoration: TextDecoration.lineThrough,
                        fontSize: Dimensions.fontSizeSmall,
                        color: Theme.of(context).disabledColor,
                      ),
                    ))
                  : const Expanded(child: SizedBox()),
              Get.find<SplashController>().configModel!.toggleVegNonVeg!
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: Dimensions.paddingSizeExtraSmall,
                          horizontal: Dimensions.paddingSizeSmall),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radiusSmall),
                        color: Theme.of(context)
                            .primaryColor
                            .withValues(alpha: 0.1),
                      ),
                      child: Text(
                        orderDetails.foodDetails!.veg == 0
                            ? 'non_veg'.tr
                            : 'veg'.tr,
                        style: robotoRegular.copyWith(
                            fontSize: Dimensions.fontSizeExtraSmall,
                            color: Theme.of(context).primaryColor),
                      ),
                    )
                  : const SizedBox(),
            ]),
          ]),
        ),
      ]),
      addOnText.isNotEmpty
          ? Padding(
              padding:
                  const EdgeInsets.only(top: Dimensions.paddingSizeExtraSmall),
              child: Row(children: [
                const SizedBox(width: 60),
                Text('${'addons'.tr}: ',
                    style: robotoMedium.copyWith(
                        fontSize: Dimensions.fontSizeSmall)),
                Flexible(
                    child: Text(
                  addOnText,
                  style: robotoRegular.copyWith(
                      fontSize: Dimensions.fontSizeSmall,
                      color: Theme.of(context).disabledColor),
                )),
              ]),
            )
          : const SizedBox(),
      orderDetails.foodDetails!.variations!.isNotEmpty
          ? Padding(
              padding:
                  const EdgeInsets.only(top: Dimensions.paddingSizeExtraSmall),
              child: Row(children: [
                const SizedBox(width: 60),
                Text('${'variations'.tr}: ',
                    style: robotoMedium.copyWith(
                        fontSize: Dimensions.fontSizeSmall)),
                Flexible(
                    child: Text(
                  variationText!,
                  style: robotoRegular.copyWith(
                      fontSize: Dimensions.fontSizeSmall,
                      color: Theme.of(context).disabledColor),
                )),
              ]),
            )
          : const SizedBox(),
      const Divider(height: Dimensions.paddingSizeLarge),
      const SizedBox(height: Dimensions.paddingSizeSmall),
    ]);
  }
}

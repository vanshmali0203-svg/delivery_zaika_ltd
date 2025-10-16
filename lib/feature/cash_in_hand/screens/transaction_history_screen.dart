import 'package:get/get.dart';
import '../../../helper/export.dart';
import '../widgets/earning_order_widget.dart';
import '../widgets/transaction_history.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();

    Get.find<CashInHandController>().getDeliveryChargesList();
    Get.find<CashInHandController>().getWalletPaymentList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: GetBuilder<CashInHandController>(
          builder: (controller) => CustomAppBarWidget(
            title: '${controller.subTitleText} History',
          ),
        ),
      ),

      body: GetBuilder<CashInHandController>(builder: (cashInHandController) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              switchInCurve: Curves.easeIn,
              switchOutCurve: Curves.easeOut,
              child: cashInHandController.tabIndex == 0
                  ? EarningOrderWidget(
                      cashInHandController: cashInHandController)
                  : TransactionWidget(
                      cashInHandController: cashInHandController),
            ),
          ),
        );
      }),

      // body: GetBuilder<CashInHandController>(builder: (cashInHandController) {
      //   return cashInHandController.transactions != null ? cashInHandController.transactions!.isNotEmpty ? ListView.builder(
      //     itemCount: cashInHandController.transactions!.length,
      //     shrinkWrap: true,
      //     padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault, left: Dimensions.paddingSizeDefault, right: Dimensions.paddingSizeDefault),
      //     physics: const BouncingScrollPhysics(),
      //     itemBuilder: (context, index) {
      //       return Column(children: [
      //
      //         Padding(
      //           padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeLarge),
      //           child: Row(children: [
      //
      //             Expanded(
      //               child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      //
      //                 Text(PriceConverter.convertPrice(cashInHandController.transactions![index].amount), style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault)),
      //                 const SizedBox(height: Dimensions.paddingSizeExtraSmall),
      //
      //                 Text(
      //                   '${'paid_via'.tr} ${cashInHandController.transactions![index].method?.replaceAll('_', ' ').capitalize??''}',
      //                   style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).disabledColor),
      //                 ),
      //
      //               ]),
      //             ),
      //
      //             Text(
      //               cashInHandController.transactions![index].paymentTime.toString(),
      //               style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor),
      //             ),
      //
      //           ]),
      //         ),
      //
      //         const Divider(height: 1),
      //
      //       ]);
      //     },
      //   ) : Center(child: Text('no_transaction_found'.tr)) : const Center(child: CircularProgressIndicator());
      // }),
    );
  }
}

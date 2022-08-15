import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:proyecto_final_seminario/app/services/services.dart';
import '../../../home/controllers/home_controller.dart';
import '../../../../models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCreditCardController extends GetxController {
  final TextEditingController cardOwnerNameController = TextEditingController();
  final TextEditingController cardOwnerIdController = TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  final formKeyNewCreditCard = GlobalKey<FormState>();

  RxString month = '02'.obs;
  RxString year = '24'.obs;

  var cardOwnerNameError = false.obs;
  var cardOwnerIdError = false.obs;
  var cardNumberError = false.obs;
  var isLoading = false.obs;
  var cvvError = false.obs;

  RxString cardType = ''.obs;

  late User user;
  late HomeController homeController;

  @override
  void onInit() {
    homeController = Get.find<HomeController>();
    user = homeController.user;
    super.onInit();
  }

  // Cambia el mes
  void changeMonth(String? selectedMonth) {
    month.value = selectedMonth!;
  }

  // Cambia el año
  void changeYear(String? selectedYear) {
    year.value = selectedYear!;
  }

  // Drop Down de los meses
  List<DropdownMenuItem<String>> getMonths() {
    List<DropdownMenuItem<String>> months = [];
    for (var i = 1; i <= 12; i++) {
      if (i < 10) {
        months.add(DropdownMenuItem(value: '0$i', child: Text('0$i')));
      } else {
        months.add(DropdownMenuItem(value: '$i', child: Text('$i')));
      }
    }
    return months;
  }

  // Drop Down de los años
  List<DropdownMenuItem<String>> getYears() {
    List<DropdownMenuItem<String>> months = [];
    for (var i = 0; i < 10; i++) {
      months
          .add(DropdownMenuItem(value: '${22 + i}', child: Text('${22 + i}')));
    }
    return months;
  }

  // Valida el número de cuenta
  String? validateAccountNumber(String? _) {
    if (cardNumberController.text.isEmpty) {
      cardNumberError.value = true;
      return null;
    } else {
      cardNumberError.value = false;
      return null;
    }
  }

  // Valida el nombre del titular de la cuenta
  String? validateAccountOwnerName(String? _) {
    if (cardOwnerNameController.text.isEmpty) {
      cardOwnerNameError.value = true;
      return null;
    } else {
      cardOwnerNameError.value = false;
      return null;
    }
  }

  // Valida el número del titular de la cuenta
  String? validateAccountOwnerId(String? _) {
    if (cardOwnerIdController.text.isEmpty) {
      cardOwnerIdError.value = true;
      return null;
    } else {
      cardOwnerIdError.value = false;
      return null;
    }
  }

  // Valida el CVV del titular de la cuenta
  String? validateCvv(String? _) {
    if (cvvController.text.isEmpty) {
      cvvError.value = true;
      return null;
    } else {
      cvvError.value = false;
      return null;
    }
  }

  // Valida que no haya errores al crear la tarjeta
  void createCreditCard() async {
    if (formKeyNewCreditCard.currentState!.validate() &&
        !cardNumberError.value &&
        !cardOwnerNameError.value &&
        !cardOwnerIdError.value &&
        !cvvError.value) {
      isLoading.value = true;
      CreditCard card = CreditCard(
        cardNumber: cardNumberController.text.trim(),
        month: month.value,
        year: year.value,
        cvv: int.parse(cvvController.text.trim()),
        type: cardType.value,
        ownerName: cardOwnerNameController.text,
        ownerDocumentId: cardOwnerIdController.text,
      );
      user.creditCard = card;
      userService.update(user);
      Get.back();
      isLoading.value = false;
    }
  }

  // Determina el tipo de tarjeta
  void getCardTypeString() {
    switch (detectCCType(cardNumberController.text)) {
      case CardType.visa:
        cardType.value = "Visa";
        break;
      case CardType.americanExpress:
        cardType.value = "American Express";
        break;
      case CardType.mastercard:
        cardType.value = "Mastercard";
        break;
      default:
        cardType.value = "X";
    }
  }

  /// This function determines the Credit Card type based on the cardPatterns
  /// and returns it.
  CardType detectCCType(String cardNumber) {
    //Default card type is other
    CardType cardType = CardType.otherBrand;
    if (cardNumber.isEmpty) {
      return cardType;
    }
    cardNumPatterns.forEach(
      (CardType type, Set<List<String>> patterns) {
        for (List<String> patternRange in patterns) {
          String ccPatternStr =
              cardNumber.replaceAll(RegExp(r'\s+\b|\b\s'), '');
          final int rangeLen = patternRange[0].length;
          if (rangeLen < cardNumber.length) {
            ccPatternStr = ccPatternStr.substring(0, rangeLen);
          }
          if (patternRange.length > 1) {
            final int ccPrefixAsInt = int.parse(ccPatternStr);
            final int startPatternPrefixAsInt = int.parse(patternRange[0]);
            final int endPatternPrefixAsInt = int.parse(patternRange[1]);
            if (ccPrefixAsInt >= startPatternPrefixAsInt &&
                ccPrefixAsInt <= endPatternPrefixAsInt) {
              cardType = type;
              break;
            }
          } else {
            if (ccPatternStr == patternRange[0]) {
              cardType = type;
              break;
            }
          }
        }
      },
    );
    return cardType;
  }

  /// Credit Card prefix patterns as of March 2019
  Map<CardType, Set<List<String>>> cardNumPatterns =
      <CardType, Set<List<String>>>{
    CardType.visa: <List<String>>{
      <String>['4'],
    },
    CardType.americanExpress: <List<String>>{
      <String>['34'],
      <String>['37'],
    },
    CardType.discover: <List<String>>{
      <String>['6011'],
      <String>['622126', '622925'],
      <String>['644', '649'],
      <String>['65']
    },
    CardType.mastercard: <List<String>>{
      <String>['51', '55'],
      <String>['2221', '2229'],
      <String>['223', '229'],
      <String>['23', '26'],
      <String>['270', '271'],
      <String>['2720'],
    },
  };
}

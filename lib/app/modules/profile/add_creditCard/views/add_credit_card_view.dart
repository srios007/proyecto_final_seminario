import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import '../controllers/add_credit_card_controller.dart';
import '../../../../widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../utils/utils.dart';
import 'package:get/get.dart';

class AddCreditCardView extends GetView<AddCreditCardController> {
  const AddCreditCardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Tarjeta de crédito',
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 25),
            const Text(
              'Agrega una tarjeta de crédito',
              style: TextStyle(
                color: Palette.darkBlue,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 25),
            _CreditCardForm(controller: controller),
            const SizedBox(height: 40),
            PurpleButton(
              isLoading: controller.isLoading,
              onPressed: controller.createCreditCard,
              buttonText: 'Guardar',
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

class _CreditCardForm extends StatelessWidget {
  const _CreditCardForm({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final AddCreditCardController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Form(
        key: controller.formKeyNewCreditCard,
        child: Column(
          children: [
            _InputField(
              title: 'Tarjeta de crédito o débito',
              hintText: 'Ej: 1234 5678 9012 3456',
              textController: controller.cardNumberController,
              validator: controller.validateAccountNumber,
              errorIndicator: controller.cardNumberError,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
                CreditCardNumberInputFormatter(),
              ],
              keyboardType: TextInputType.number,
              onChanged: (_) => controller.getCardTypeString(),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                _DropdownField(
                  title: 'Mes',
                  width: Get.width * 0.45,
                  padding: const EdgeInsets.only(left: 40),
                  controller: controller,
                  dropdownItems: controller.getMonths(),
                  hint: const Text('Mes'),
                  onChanged: controller.changeMonth,
                  selectedValue: controller.month.value,
                ),
                SizedBox(width: Get.width * 0.1),
                _DropdownField(
                  title: 'Año',
                  width: Get.width * 0.45,
                  padding: const EdgeInsets.only(right: 40),
                  controller: controller,
                  dropdownItems: controller.getYears(),
                  hint: const Text('Año'),
                  onChanged: controller.changeYear,
                  selectedValue: controller.year.value,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _InputField(
                  title: 'CVV',
                  hintText: 'Ej: 123',
                  textController: controller.cvvController,
                  validator: controller.validateCvv,
                  errorIndicator: controller.cvvError,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(4),
                  ],
                  keyboardType: TextInputType.number,
                  width: Get.width * 0.56,
                ),
                Column(
                  children: [
                    const Text(
                      'Pagaré con',
                    ),
                    const SizedBox(height: 5),
                    _getCardTypeIcon(controller.cardNumberController.text),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            _InputField(
              title: 'Titular de la cuenta',
              hintText: 'Ej: Pedro López',
              textController: controller.cardOwnerNameController,
              validator: controller.validateAccountOwnerName,
              errorIndicator: controller.cardOwnerNameError,
            ),
            const SizedBox(height: 20),
            _InputField(
              title: 'Documento del titular',
              hintText: 'Ej: 1927364412',
              textController: controller.cardOwnerIdController,
              validator: controller.validateAccountOwnerId,
              errorIndicator: controller.cardOwnerIdError,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
    );
  }

  Widget _getCardTypeIcon(String cardNumber) {
    Widget icon = Container();

    if (controller.cardType.value == 'Visa') {
      icon = Image.asset(
        'icons/visa.png',
        height: 25,
        width: 40,
        package: 'flutter_credit_card',
      );
    } else if (controller.cardType.value == 'American Express') {
      icon = Image.asset(
        'icons/amex.png',
        height: 25,
        width: 40,
        package: 'flutter_credit_card',
      );
    } else if (controller.cardType.value == 'Mastercard') {
      icon = Image.asset(
        'icons/mastercard.png',
        height: 25,
        width: 40,
        package: 'flutter_credit_card',
      );
    } else {}

    return icon;
  }
}

class _DropdownField extends StatelessWidget {
  _DropdownField({
    Key? key,
    required this.controller,
    this.title,
    required this.dropdownItems,
    required this.onChanged,
    required this.selectedValue,
    this.hint,
    this.width,
    this.padding,
  }) : super(key: key);

  final AddCreditCardController controller;
  String? title;
  final List<DropdownMenuItem<String>> dropdownItems;
  final void Function(String?) onChanged;
  final String selectedValue;
  Widget? hint;
  double? width;
  EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 40),
      width: width ?? Get.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title != null
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    title!,
                    style: const TextStyle(
                      color: Palette.purple,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )
              : const SizedBox.shrink(),
          Container(
            width: Get.width,
            height: 50,
            padding: const EdgeInsets.only(left: 20, right: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Palette.gray,
                width: 2,
              ),
            ),
            child: DropdownButton<String>(
              hint: hint,
              underline: const SizedBox.shrink(),
              value: selectedValue,
              isExpanded: true,
              icon: const Icon(CupertinoIcons.chevron_down),
              iconEnabledColor: Palette.green,
              iconSize: 20,
              elevation: 0,
              style: const TextStyle(
                color: Palette.darkBlue,
                fontSize: 16,
              ),
              dropdownColor: Palette.white,
              focusColor: Palette.gray,
              onChanged: onChanged,
              items: dropdownItems,
            ),
          ),
        ],
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  _InputField({
    Key? key,
    required this.title,
    required this.hintText,
    required this.textController,
    required this.validator,
    required this.errorIndicator,
    this.inputFormatters,
    this.keyboardType,
    this.width,
    this.padding,
    this.onChanged,
  }) : super(key: key);

  final String title;
  final String hintText;
  final TextEditingController textController;
  final String? Function(String?) validator;
  final RxBool errorIndicator;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  double? width;
  EdgeInsetsGeometry? padding;
  void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 40),
      width: width ?? Get.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Palette.purple,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: Get.width,
            height: 50,
            padding: const EdgeInsets.only(left: 20, right: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Palette.gray,
                width: 2,
              ),
            ),
            child: TextFormField(
              decoration: InputDecoration(
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                hintText: hintText,
                hintStyle: const TextStyle(
                  color: Palette.gray,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                errorStyle: styles.errorStyle,
              ),
              inputFormatters: inputFormatters,
              keyboardType: keyboardType,
              controller: textController,
              onChanged: onChanged,
              validator: validator,
            ),
          ),
          Obx(
            () => errorIndicator.value
                ? Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      'Por favor, rellena este campo',
                      style: styles.errorStyle,
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}

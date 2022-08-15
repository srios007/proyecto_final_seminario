import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/onboarding/forgot_password/bindings/forgot_password_binding.dart';
import '../modules/onboarding/forgot_password/views/forgot_password_view.dart';
import '../modules/onboarding/forgot_user/bindings/forgot_user_binding.dart';
import '../modules/onboarding/forgot_user/views/forgot_user_view.dart';
import '../modules/onboarding/login/bindings/login_binding.dart';
import '../modules/onboarding/login/views/login_view.dart';
import '../modules/onboarding/register/bindings/register_binding.dart';
import '../modules/onboarding/register/views/register_view.dart';
import '../modules/profile/add_address/bindings/add_address_binding.dart';
import '../modules/profile/add_address/views/add_address_view.dart';
import '../modules/profile/add_creditCard/bindings/add_credit_card_binding.dart';
import '../modules/profile/add_creditCard/views/add_credit_card_view.dart';
import '../modules/profile/profile/bindings/profile_binding.dart';
import '../modules/profile/profile/views/profile_view.dart';
import '../modules/request/category_detail/bindings/category_detail_binding.dart';
import '../modules/request/category_detail/views/category_detail_view.dart';
import '../modules/request/meal_detail/bindings/meal_detail_binding.dart';
import '../modules/request/meal_detail/views/meal_detail_view.dart';
import '../modules/request/menu_detail/bindings/menu_detail_binding.dart';
import '../modules/request/menu_detail/views/menu_detail_view.dart';
import '../modules/tour/bindings/tour_binding.dart';
import '../modules/tour/views/tour_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.TOUR,
      page: () => TourView(),
      binding: TourBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_USER,
      page: () => ForgotUserView(),
      binding: ForgotUserBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.CATEGORY_DETAIL,
      page: () => const CategoryDetailView(),
      binding: CategoryDetailBinding(),
    ),
    GetPage(
      name: _Paths.MEAL_DETAIL,
      page: () => const MealDetailView(),
      binding: MealDetailBinding(),
    ),
    GetPage(
      name: _Paths.ADD_ADDRESS,
      page: () => AddAddressView(),
      binding: AddAddressBinding(),
    ),
    GetPage(
      name: _Paths.ADD_CREDIT_CARD,
      page: () => const AddCreditCardView(),
      binding: AddCreditCardBinding(),
    ),
    GetPage(
      name: _Paths.MENU_DETAIL,
      page: () => const MenuDetailView(),
      binding: MenuDetailBinding(),
    ),
  ];
}

import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/meal_detail/bindings/meal_detail_binding.dart';
import '../modules/meal_detail/views/meal_detail_view.dart';
import '../modules/onboarding/forgot_password/bindings/forgot_password_binding.dart';
import '../modules/onboarding/forgot_password/views/forgot_password_view.dart';
import '../modules/onboarding/forgot_user/bindings/forgot_user_binding.dart';
import '../modules/onboarding/forgot_user/views/forgot_user_view.dart';
import '../modules/onboarding/login/bindings/login_binding.dart';
import '../modules/onboarding/login/views/login_view.dart';
import '../modules/onboarding/register/bindings/register_binding.dart';
import '../modules/onboarding/register/views/register_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/request/category_detail/bindings/category_detail_binding.dart';
import '../modules/request/category_detail/views/category_detail_view.dart';
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
  ];
}

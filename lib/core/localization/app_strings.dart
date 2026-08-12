import 'package:flutter/cupertino.dart';

class AppStrings {
  AppStrings._();

  static const Map<String, Map<String, String>> _values = {
    // ================= Error Messages =================
    'error_server': {
      'ar': 'حدث خطأ في الخادم. يرجى المحاولة لاحقاً',
      'en': 'A server error occurred. Please try again later.',
    },
    'error_unauthorized': {
      'ar': 'انتهت صلاحية الجلسة. يرجى تسجيل الدخول مجدداً',
      'en': 'Session expired. Please log in again.',
    },
    'error_network': {
      'ar': 'لا يوجد اتصال بالإنترنت. يرجى التحقق من الشبكة',
      'en': 'No internet connection. Please check your network.',
    },
    'error_cache': {
      'ar': 'حدث خطأ في التخزين المحلي',
      'en': 'A local storage error occurred.',
    },
    'error_ai': {
      'ar': 'حدث خطأ في الذكاء الاصطناعي',
      'en': 'An AI error occurred.',
    },
    'error_occurred': {'ar': 'حدث خطأ غير متوقع', 'en': 'An error occurred'},

    // ================= Success Messages =================
    'login_success': {
      'ar': 'تم تسجيل الدخول بنجاح',
      'en': 'Logged in successfully',
    },
    'register_success': {
      'ar': 'تم إنشاء الحساب بنجاح',
      'en': 'Account created successfully',
    },
    'order_confirmed_success': {
      'ar': 'تمت تأكيد الطلبية بنجاح! 🎉',
      'en': 'Order confirmed successfully! 🎉',
    },

    // ================= Onboarding & Splash =================
    'skip': {'ar': 'تخطي', 'en': 'Skip'},
    'next': {'ar': 'التالي', 'en': 'Next'},
    'start_now': {'ar': 'ابدأ الآن', 'en': 'Get Started'},
    'onboarding_title_1': {
      'ar': 'مرحباً بك في متجرنا',
      'en': 'Welcome to Our Store',
    },
    'onboarding_desc_1': {
      'ar': 'تصفح أحدث المنتجات وابتكر تجربة تسوق فريدة وسريعة.',
      'en':
          'Browse the latest products and enjoy a seamless shopping experience.',
    },
    'onboarding_title_2': {'ar': 'سلة تسوق ذكية', 'en': 'Smart Shopping Cart'},
    'onboarding_desc_2': {
      'ar': 'أضف منتجاتك المفضلة وسدد بطرق سهلة وآمنة.',
      'en': 'Add your favorite products and checkout easily and securely.',
    },
    'onboarding_title_3': {
      'ar': 'توصيل سريع وموثوق',
      'en': 'Fast & Reliable Delivery',
    },
    'onboarding_desc_3': {
      'ar': 'تتبع طلباتك وإدارة ملفك الشخصي بكل سهولة.',
      'en': 'Track your orders and manage your profile with ease.',
    },

    // ================= App & Common =================
    'app_name': {'ar': 'متجري الرقمي', 'en': 'E-Commerce Store'},
    'cancel': {'ar': 'إلغاء', 'en': 'Cancel'},
    'save': {'ar': 'حفظ', 'en': 'Save'},
    'delete': {'ar': 'حذف', 'en': 'Delete'},
    'retry': {'ar': 'إعادة المحاولة', 'en': 'Retry'},
    'search_hint': {'ar': 'ابحث عن منتج...', 'en': 'Search products...'},
    'no_data': {'ar': 'لا توجد بيانات متاحة', 'en': 'No data available'},
    'settings': {'ar': 'الإعدادات', 'en': 'Settings'},
    'profile': {'ar': 'الملف الشخصي', 'en': 'Profile'},
    'cart': {'ar': 'السلة', 'en': 'Cart'},

    // ================= Auth Screen =================
    'welcome_back': {'ar': 'أهلاً بك مجدداً', 'en': 'Welcome Back'},
    'login_title': {'ar': 'تسجيل الدخول', 'en': 'Login'},
    'register_title': {'ar': 'إنشاء حساب جديد', 'en': 'Create Account'},
    'confirm_password': {'ar': 'تأكيد كلمة المرور', 'en': 'Confirm Password'},
    'passwords_dont_match': {
      'ar': 'كلمات المرور غير متطابقة',
      'en': "Passwords don't match",
    },
    'register_subtitle': {
      'ar': 'انضم إلينا وابدأ تسوق أحدث المنتجات بكل سهولة',
      'en': 'Join us and start shopping for the latest products with ease',
    },
    'username': {'ar': 'اسم المستخدم', 'en': 'Username'},
    'email': {'ar': 'البريد الإلكتروني', 'en': 'Email'},
    'password': {'ar': 'كلمة المرور', 'en': 'Password'},
    'first_name': {'ar': 'الاسم الأول', 'en': 'First Name'},
    'last_name': {'ar': 'الاسم الأخير', 'en': 'Last Name'},
    'phone': {'ar': 'رقم الهاتف', 'en': 'Phone Number'},
    'forgot_password': {'ar': 'نسيت كلمة المرور؟', 'en': 'Forgot Password?'},
    'login_button': {'ar': 'تسجيل الدخول', 'en': 'Login'},
    'register_button': {'ar': 'إنشاء الحساب', 'en': 'Register'},
    'logout': {'ar': 'تسجيل الخروج', 'en': 'Logout'},
    'dont_have_account': {
      'ar': 'ليس لديك حساب؟',
      'en': "Don't have an account?",
    },
    'register_now': {'ar': 'أنشئ حساباً الآن', 'en': 'Sign Up'},
    'already_have_account': {
      'ar': 'لديك حساب بالفعل؟',
      'en': 'Already have an account?',
    },

    // ================= Validators & Form Messages =================
    'field_required': {'ar': 'هذا الحقل مطلوب', 'en': 'This field is required'},
    'invalid_email': {
      'ar': 'البريد الإلكتروني غير صالح',
      'en': 'Invalid email address',
    },
    'password_too_short': {
      'ar': 'كلمة المرور يجب أن تكون 6 أحرف على الأقل',
      'en': 'Password must be at least 6 characters',
    },

    // ================= Products & Store =================
    'SPECIAL OFFER': {'ar': 'عرض مميز', 'en': 'SPECIAL OFFER'},
    'Search products...': {'ar': 'ابحث ...', 'en': 'Search products...'},
    'products_title': {'ar': 'المنتجات', 'en': 'Products'},
    'categories': {'ar': 'التصنيفات', 'en': 'Categories'},
    'all_products': {'ar': 'جميع المنتجات', 'en': 'All Products'},
    'product_details': {'ar': 'تفاصيل المنتج', 'en': 'Product Details'},
    'price': {'ar': 'السعر', 'en': 'Price'},
    'rating': {'ar': 'التقييم', 'en': 'Rating'},
    'description': {'ar': 'الوصف', 'en': 'Description'},
    'add_to_cart': {'ar': 'إضافة إلى السلة', 'en': 'Add to Cart'},
    'no_products_found': {
      'ar': 'لم يتم العثور على منتجات',
      'en': 'No products found',
    },
    'all': {'ar': 'الكل', 'en': 'All'},
    'electronics': {'ar': 'إلكترونيات', 'en': 'Electronics'},
    'jewelery': {'ar': 'مجوهرات', 'en': 'Jewelery'},
    'mens_clothing': {'ar': 'ملابس رجالية', 'en': "Men's Clothing"},
    'womens_clothing': {'ar': 'ملابس نسائية', 'en': "Women's Clothing"},
    'discover_products': {'ar': 'اكتشف المنتجات', 'en': 'Discover Products'},
    'featured_offers': {'ar': 'عروض مميزة', 'en': 'Featured Offers'},
    'special_offer': {'ar': 'عرض خاص', 'en': 'SPECIAL OFFER'},
    'search_products': {'ar': 'البحث عن منتجات...', 'en': 'Search products...'},
    'reviews': {'ar': 'تقييمات', 'en': 'reviews'},
    'added_to_cart': {'ar': 'تمت الإضافة إلى السلة', 'en': 'Added to cart'},

    // ================= Cart Screen & Local Data =================
    'product_number_label': {'ar': 'المنتج رقم', 'en': 'Product No.'},
    'remove_product': {'ar': 'حذف المنتج', 'en': 'Remove Product'},
    'decrease_quantity': {'ar': 'إنقاص الكمية', 'en': 'Decrease Quantity'},
    'increase_quantity': {'ar': 'زيادة الكمية', 'en': 'Increase Quantity'},
    'shopping_cart_number': {'ar': 'سلة تسوق رقم', 'en': 'Shopping Cart No.'},
    'user_label': {'ar': 'المستخدم', 'en': 'User'},
    'products_count_label': {'ar': 'عدد المنتجات', 'en': 'Products Count'},
    'date_label': {'ar': 'التاريخ', 'en': 'Date'},
    'delete_cart': {'ar': 'حذف السلة', 'en': 'Delete Cart'},
    'delete_cart_title': {'ar': 'حذف السلة', 'en': 'Delete Cart'},
    'delete_cart_confirmation': {
      'ar': 'هل أنت متأكد من رغبتك في حذف هذه السلة نهائياً؟',
      'en': 'Are you sure you want to permanently delete this cart?',
    },
    'add_prefix': {'ar': 'إضافة:', 'en': 'Add:'},
    'price_prefix': {'ar': 'السعر:', 'en': 'Price:'},
    'new_cart_mode': {'ar': 'سلة جديدة', 'en': 'New Cart'},
    'existing_cart_mode': {'ar': 'سلة موجودة', 'en': 'Existing Cart'},
    'new_cart_name_label': {'ar': 'اسم السلة الجديدة', 'en': 'New Cart Name'},
    'new_cart_name_hint': {
      'ar': 'مثال: مشتريات المنزل، إلكترونيات',
      'en': 'Ex: Home shopping, Electronics',
    },
    'enter_cart_name_error': {
      'ar': 'الرجاء إدخال اسم السلة',
      'en': 'Please enter cart name',
    },
    'select_cart_label': {'ar': 'اختر السلة', 'en': 'Select Cart'},
    'select_saved_cart_hint': {
      'ar': 'اختر من السلات المحفوظة',
      'en': 'Choose from saved carts',
    },
    'select_available_cart_error': {
      'ar': 'الرجاء اختيار سلة متاحة',
      'en': 'Please select an available cart',
    },
    'quantity_to_add_label': {
      'ar': 'الكمية المطلوب إضافتها:',
      'en': 'Quantity to add:',
    },
    'confirm_and_create_cart': {
      'ar': 'تأكيد وإنشاء السلة',
      'en': 'Confirm & Create Cart',
    },
    'add_to_selected_cart': {
      'ar': 'إضافة إلى السلة المختارة',
      'en': 'Add to Selected Cart',
    },
    'cart_details_title': {'ar': 'تفاصيل السلة', 'en': 'Cart Details'},
    'failed_to_load_cart_details': {
      'ar': 'تعذر تحميل تفاصيل السلة',
      'en': 'Failed to load cart details',
    },
    'no_cart_data': {
      'ar': 'لا توجد بيانات لهذه السلة',
      'en': 'No data available for this cart',
    },
    'cart_empty_title': {'ar': 'السلة فارغة', 'en': 'Cart is empty'},
    'cart_empty_subtitle': {
      'ar': 'قم بإضافة منتجات أو تفريغ السلة بالكامل',
      'en': 'Add products or clear the cart completely',
    },
    'reduce_quantity': {'ar': 'تقليل الكمية', 'en': 'Reduce Quantity'},
    'total_products_label': {'ar': 'عدد المنتجات', 'en': 'Products Count'},
    'pieces_unit': {'ar': 'قطعة', 'en': 'pieces'},
    'confirm_order': {'ar': 'تأكيد الطلبية', 'en': 'Confirm Order'},
    'saved_carts_title': {'ar': 'السلات المحفوظة', 'en': 'Saved Carts'},
    'error_loading_carts': {
      'ar': 'حدث خطأ أثناء تحميل السلات',
      'en': 'Error loading carts',
    },
    'no_saved_carts_yet': {
      'ar': 'لا توجد سلات محفوظة بعد',
      'en': 'No saved carts yet',
    },
    'create_cart_hint': {
      'ar': 'قم بإنشاء سلة جديدة لتظهر هنا',
      'en': 'Create a new cart to show it here',
    },
    'cart_operation_failed': {
      'ar': 'فشلت عملية حفظ السلة',
      'en': 'Cart operation failed',
    },
    'cart_details_loading_failed': {
      'ar': 'فشل تحميل تفاصيل السلة',
      'en': 'Failed to load cart details',
    },
    'cart_update_failed': {
      'ar': 'فشل تحديث بيانات السلة',
      'en': 'Failed to update cart data',
    },
    'product_not_found_in_cart': {
      'ar': 'المنتج غير موجود في السلة',
      'en': 'Product not found in cart',
    },
    'failed_to_read_local_carts': {
      'ar': 'تعذر قراءة السلات المحفوظة محلياً',
      'en': 'Failed to read local saved carts',
    },
    'failed_to_save_local_carts': {
      'ar': 'تعذر حفظ السلات محلياً',
      'en': 'Failed to save carts locally',
    },
    'cart_not_found_locally': {
      'ar': 'السلة غير موجودة محلياً',
      'en': 'Cart is not found locally',
    },

    // ================= Profile Screen =================
    'profile_title': {'ar': 'الملف الشخصي', 'en': 'Profile'},
    'personal_info': {'ar': 'المعلومات الشخصية', 'en': 'Personal Info'},
    'account_info': {'ar': 'معلومات الحساب', 'en': 'Account Information'},
    'personal_name': {'ar': 'الاسم الشخصي', 'en': 'Personal Name'},
    'address': {'ar': 'العنوان', 'en': 'Address'},
    'city': {'ar': 'المدينة', 'en': 'City'},
    'street': {'ar': 'الشارع', 'en': 'Street'},
    'building_number': {'ar': 'رقم المبنى', 'en': 'Building Number'},
    'zipcode': {'ar': 'الرمز البريدي', 'en': 'Zip Code'},
    'no_cached_data_available': {
      'ar': 'لا توجد بيانات مخزنة متاحة',
      'en': 'No cached data available',
    },
    'failed_to_cache_profile': {
      'ar': 'فشل تخزين الملف الشخصي',
      'en': 'Failed to cache profile',
    },
    'no_cached_profile_found': {
      'ar': 'لم يتم العثور على ملف شخصي مخزن',
      'en': 'No cached profile found',
    },
  };

  static String of(String key, String languageCode) {
    return _values[key]?[languageCode] ?? key;
  }
}

extension LocalizationExtension on BuildContext {
  String tr(String key) {
    final langCode = Localizations.localeOf(this).languageCode;
    return AppStrings.of(key, langCode);
  }
}

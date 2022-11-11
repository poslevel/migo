import 'package:get/get.dart';

class LocaleString extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        //ENGLISH LANGUAGE
        'en_US': {
          'create_bill': 'Create Bill',
          'view_sales_history': 'View Sales History',
          'order_a_product': 'Order a Product',
          'product_replacement': 'Product Replacement',
          'warranty_claim': 'Warranty Claim',
          'amt_in_stock': 'Amount in Stock',
          'price': 'Price',
          'products': 'Products',
          'analytics': 'Analytics',
          'settings': 'Settings',
          'add_to_bill': 'Add to bill',
        },
        //HINDI LANGUAGE
        'hi_IN': {
          'create_bill': 'बिल बनाएं',
          'view_sales_history': 'बिक्री इतिहास देखें',
          'order_a_product': "एक उत्पाद ऑर्डर करें",
          'product_replacement': "उत्पाद प्रतिस्थापन",
          'warranty_claim': "वारंटी का दावा",
          'amt_in_stock': 'स्टॉक में राशि',
          'price': "कीमत",
          'products': "उत्पादों",
          'analytics': "एनालिटिक्स",
          'settings': "समायोजन",
          'add_to_bill': "बिल में जोड़ें",
        },
      };
}

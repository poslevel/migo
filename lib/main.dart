import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:migo/locale_strings.dart';
import 'package:migo/utils/theme_config.dart';
import 'package:migo/view/products/billing/billing_page.dart';
import 'package:migo/view/splash.dart';
import 'package:quick_actions/quick_actions.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

main() async {
  await GetStorage.init();
  runApp(const MiGo());
}

class MiGo extends StatefulWidget {
  const MiGo({super.key});

  @override
  State<MiGo> createState() => _MiGoState();
}

class _MiGoState extends State<MiGo> {
  String shortcut = 'no action set';

  @override
  void initState() {
    super.initState();

    initializeQuickActions();
    // try {
    //   if (Platform.isAndroid || Platform.isIOS) {
    //   } else {}
    // } finally {}
  }

  void initializeQuickActions() {
    const QuickActions quickActions = QuickActions();
    quickActions.initialize((String shortcutType) {
      setState(() {
        // ignore: unnecessary_null_comparison
        if (shortcutType != null) {
          shortcut = shortcutType;
        }
      });
    });

    quickActions.setShortcutItems([
      const ShortcutItem(
        type: 'create_bill',
        localizedTitle: 'Create a bill',
        icon: 'icon_reciept_long',
      ),
    ]).then((void _) {
      setState(() {
        if (shortcut == 'no action set') {
          shortcut = 'actions ready';
        }
      });
    });
    quickActions.initialize((type) {
      if (type == 'create_bill') {
        Get.to(() => const Billing(isMobile: true));
      }
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var languagePref = GetStorage();

    return GetMaterialApp(
      title: 'MiGo',
      debugShowCheckedModeBanner: false,
      translations: LocaleString(),
      locale: languagePref.read("lan") == "Hindi"
          ? const Locale('hi', 'IN')
          : const Locale('en', 'US'),
      // locale: Locale('hi', 'IN'),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English, no country code
        Locale('hi', ''), // Hindi, no country code
      ],
      theme: mainTheme,
      home: SplashView(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:myapp/view/pages/initialpages/login_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'view/pages/initialpages/framepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 640),
      builder: () => GetMaterialApp(
        localizationsDelegates: [
          // AssetLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        // localeResolutionCallback: (locale, supportedLocales) {
        //   // Check if the current device locale is supported
        //   for (var supportedLocale in supportedLocales) {
        //     if (supportedLocale.languageCode == locale!.languageCode
        //         /*  && supportedLocale.countryCode == locale.countryCode */
        //         ) {
        //       return supportedLocale;
        //     }
        //     return supportedLocales.first;
        //   }
        // },
        supportedLocales: [
          const Locale('ko', 'KR'),
        ],
        title: "MMIS project myapp",
        debugShowCheckedModeBanner: false,
        theme: themeData,
        home: LoginPage(),
      ),
    );
  }
}

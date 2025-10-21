import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'routes/approuter.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Platform.isAndroid
          ? const Size(360, 800)
          : Platform.isIOS
          ? const Size(390, 844)
          : const Size(1290, 960),
      splitScreenMode: true,
      child: MaterialApp.router(
        routerConfig: _appRouter.config(),
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        builder: (buildContext, child) {
          return MediaQuery(
            ///Setting font does not change with system font size
            data: MediaQuery.of(
              context,
            ).copyWith(textScaler: const TextScaler.linear(1.0)),
            child: child!,
          );
        },
      ),
    );
  }
}

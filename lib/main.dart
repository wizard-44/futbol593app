import 'package:flutter/material.dart';
import 'package:futbol593/src/pages/SplashScreen.dart';
import 'package:futbol593/src/providers/main_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:futbol593/src/theme/main_theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MainProvider()),
      ],
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context, listen: true);
    return FutureBuilder<bool>(
        future: mainProvider.getPreferences(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ScreenUtilInit(
                designSize: const Size(360, 690),
                builder: () => MaterialApp(
                    debugShowCheckedModeBanner: false,
                    title: 'Futbol593',
                    theme: AppTheme.themeData(mainProvider.mode),
                    home: const SplashScreen()));
          }
          return const SizedBox.square(
              dimension: 100.0,
              child: CircularProgressIndicator(
                color:Colors.white));
        });
  }
}

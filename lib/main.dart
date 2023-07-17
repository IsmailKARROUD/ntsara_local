import 'package:flutter/material.dart';
import 'package:ntsara_local/MyHomePage.dart';
import 'package:ntsara_local/Providers/locationProvider.dart';

import 'package:ntsara_local/assets/Mycolors.dart';
import '../graphqlConfig/graphql.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHiveForFlutter();
  await GraphQLConfiguration.initGraphQL();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => LocationProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: GraphQLConfiguration.client,
      child: MaterialApp(
          title: 'nTsara local',
          theme: ThemeData(
            textTheme: TextTheme(
              displayLarge: const TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              displayMedium: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: myBlack,
              ),
              displaySmall: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: myKingGreen,
              ),
              headlineMedium: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.normal,
                color: myBlack,
              ),
              headlineSmall: TextStyle(
                fontSize: 19.0,
                fontWeight: FontWeight.bold,
                color: myBlack,
              ),
              bodyLarge: TextStyle(
                fontSize: 14.0,
                color: myBlack,
              ),
              bodyMedium: TextStyle(fontSize: 17.0, color: myBlack),
              titleLarge: TextStyle(
                backgroundColor: Colors.white.withOpacity(0),
                fontSize: 19.0,
                fontWeight: FontWeight.normal,
                color: myBlack,
              ),
              titleMedium: TextStyle(
                fontSize: 14.0,
                color: myBlack[600],
                fontWeight: FontWeight.normal,
              ),
              titleSmall: TextStyle(
                fontSize: 14.0,
                color: myKingGreen,
                fontWeight: FontWeight.bold,
              ),
            ),
            highlightColor: myOrange,
            textSelectionTheme: TextSelectionThemeData(
              selectionHandleColor: myKingGreen, // Change bubble to red
              selectionColor: myKingGreen[200],
              cursorColor: myBlack, //cursor color
            ),
            buttonTheme: ButtonTheme.of(context).copyWith(
              buttonColor: myWhite,
              textTheme: ButtonTextTheme.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
            ),
            colorScheme: ColorScheme.fromSwatch(primarySwatch: myKingGreen)
                .copyWith(background: myWhite),
            primaryColor: myKingGreen,
          ),
          home: const MyHomePage()),
    );
  }
}

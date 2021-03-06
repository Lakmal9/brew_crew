import 'package:brew_crew/authenticate/authentication_service.dart';
import 'package:brew_crew/authenticate/sign_in.dart';
import 'package:brew_crew/providers/entry_provider.dart';
import 'package:brew_crew/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

Future<void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
            create: (_) => AuthenticationService(FirebaseAuth.instance)
        ),

        //Access Authentication Service
        StreamProvider(
            create: (context) => context.read<AuthenticationService>().authStateChanges
        ),

        ChangeNotifierProvider(
            create: (context) => EntryProvider()
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
          theme: ThemeData(
            accentColor: Colors.pinkAccent,
            primaryColor: Colors.black,
            textTheme: GoogleFonts.aBeeZeeTextTheme(),
          ),
        home: AuthenticationWrapper(),
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {

 const AuthenticationWrapper({
    Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if(firebaseUser != null){
      return Home();
    }
    return SignInPage();
  }


}


import 'package:brew_crew/authenticate/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class  SignInPage extends StatefulWidget {
@override
_SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage>{

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  @override
  Widget build(BuildContext context) {

    return loading ? Loading()
    : Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                validator: (val) => val.isEmpty ? 'Enter an Email' : null,
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                ),
              ),
              TextFormField(
                obscureText: true,
                validator: (val) => val.length > 6 ? 'Enter a password +6 chars long' : null,
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: "Password",
                ),
              ),
              RaisedButton(
                onPressed: () async{
                    setState(() {
                      loading = true;
                    });
                    final result = await context.read<AuthenticationService>().signIn(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                    );
                    print("***********************$result");
                    if(result != "Signed In"){
                      setState(() {
                        loading = false;
                        print("User Not Found");
                      });
                    }
                },
                child: Text("Sign in"),
              ),
              RaisedButton(
                onPressed: () async {
                  // if(_formKey.currentState.validate()) {
                    setState(() {
                      loading = true;
                    });
                    final result = await context.read<AuthenticationService>().signUp(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                    );
                    if(result == null){
                      print("Enter an valid Email");
                      setState(() {
                        loading = false;
                      });

                    }
                  },
                child: Text("Sign up"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: CircularProgressIndicator(
        ),
      ),
    );
  }
}

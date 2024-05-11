import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz2/cubit/daftar_item_cubit.dart';
import 'package:quiz2/cubit/token.dart';
import 'package:quiz2/cubit/user_login.dart';
import 'package:quiz2/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart'; // Import RegistrationScreen

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Form'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: BlocProvider( // Wrap with BlocProvider
          create: (context) => itemListCubit(), // Provide the itemListCubit
          child: LoginForm(),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  late Future<int> respPost;
  var tempToken;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    respPost = Future.value(0); //init
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextFormField(
            controller: _usernameController,
            decoration: InputDecoration(
              labelText: 'Username',
            ),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter your username';
              }
              return null;
            },
          ),
          SizedBox(height: 20.0),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(
              labelText: 'Password',
            ),
            obscureText: true,
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter your password';
              }
              return null;
            },
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                // Implement login logic here
                String username = _usernameController.text;
                String password = _passwordController.text;
                // You can now use username and password for authentication
                setState(() {
                  respPost = login(username, password);
                });
                int statusCode = await respPost;
                if (statusCode == 200) {
                  // Registration successful, navigate to login screen
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return Home();
                  }));
                }

                context.read<itemListCubit>().fetchData("http://146.190.109.66:8000/items/?skip=0&limit=100", await getAccessToken(username, password) ?? '');

              }
            },
            child: Text('Login'),
          ),
          FutureBuilder<int>(
            future: respPost,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasData) {
                if (snapshot.data! == 200) {
                  // Function to handle SharedPreferences retrieval
                  void printUserInfo() async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    String? userId = prefs.getString('user_id');
                    String? token = prefs.getString('token');
                    if (userId != null && token != null) {
                      print('User ID: $userId');
                      print('Token: $token');
                    }
                  }

                  // Call the function
                  printUserInfo();

                  return Text("Login berhasil!");
                }
                if (snapshot.data! == 0) {
                  return Text("");
                } else {
                  return Text("Login gagal");
                }
              } else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              }
              return Container();
            },
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

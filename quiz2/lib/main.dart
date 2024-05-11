import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz2/cubit/daftar_item_cubit.dart';
import 'package:quiz2/cubit/user_daftar.dart';
import 'package:quiz2/login.dart';

// Fikry Idham Dwiyana 2101294
// Marvel Ravindra Dioputra 2200481

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Registration Form',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: MultiBlocProvider(
          providers: [
            BlocProvider<itemListCubit>(create: (_) => itemListCubit()),
          ],
          child: RegistrationScreen(),
        )
        //
        );
  }
}

class RegistrationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration Form'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: RegistrationForm(),
      ),
    );
  }
}

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  late Future<int> respPost; //201 artinya berhasil
  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    respPost = Future.value(0); //init
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
              '2101294 FIkry Idham Dwiyana || 2200481 Marvel Ravindra Dioputra || Kelompok 6'),
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
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
            child: Text(
              'Already have an account? Login here.',
              style: TextStyle(
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () async {
              // Implement registration logic here
              String username = _usernameController.text;
              String password = _passwordController.text;
              // Use username and password for registration
              setState(() {
                respPost = insertData(
                    username, password); //jika return 201 artinya sukses
              });
              int statusCode = await respPost;
              if (statusCode == 200) {
                // Registration successful, navigate to login screen
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return LoginScreen();
                }));
              }
            },
            child: Text('Register'),
          ),
          FutureBuilder<int>(
              future: respPost,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data! == 200) {
                    return Text("Proses Insert Berhasil!");
                  }
                  if (snapshot.data! == 0) {
                    return Text("");
                  } else {
                    return Text("Proses insert gagal");
                  }
                }
                // default: loading spinner.
                return const CircularProgressIndicator();
              })
        ],
      ),
    );
  }
}

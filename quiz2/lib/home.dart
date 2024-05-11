import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz2/cubit/daftar_item_cubit.dart';
import 'package:quiz2/cubit/item_state.dart';
import 'transaction.dart'; //buat status
import 'cart.dart'; // Import ProfilePage
import 'package:shared_preferences/shared_preferences.dart'; // Add import for SharedPreferences

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: BlocProvider<itemListCubit>(
        create: (context) => itemListCubit(),
        child: HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  late String _token; // Variable to store token

  @override
  void initState() {
    super.initState();
    _getToken(); // Call method to retrieve token when the widget initializes
  }

  // Method to retrieve token from SharedPreferences
  Future<void> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null) {
      setState(() {
        _token = token;
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onSearchPressed() {
    showSearch(
      context: context,
      delegate: FoodSearchDelegate(),
    );
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Foodie',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.search),
                onPressed: _onSearchPressed,
              ),
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CartPage()),
                  );
                },
              ),
            ],
            centerTitle: true,
          ),
          body: BlocBuilder<itemListCubit, ItemState>(
            builder: (context, state) {
              if (state is ItemListLoaded) {
                List<item> items = state.items;
                return ItemListWidget(items: items);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        );
      case 1:
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Foodie',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true, // Center the title
          ),
          body: TransactionPage(
            token: _token,
          ), // Pass the token to TransactionPage
        );

      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getPage(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.black),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment, color: Colors.black),
            label: 'Status',
          ),
        ],
      ),
    );
  }
}

class ItemListWidget extends StatelessWidget {
  final List<item> items;

  const ItemListWidget({required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('\$${items[index].title}'),
          subtitle: Text('\$${items[index].description}'),
          trailing: Text('\$${items[index].price}'),
        );
      },
    );
  }
}

class FoodSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon: Icon(Icons.clear), onPressed: () {})];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('Build search results here');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Text('Build search suggestions here');
  }
}

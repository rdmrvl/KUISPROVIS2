import 'package:flutter/material.dart';
import 'home.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int _foodQuantity = 1;

  void _incrementFoodQuantity() {
    setState(() {
      _foodQuantity++;
    });
  }

  void _decrementFoodQuantity() {
    if (_foodQuantity > 1) {
      setState(() {
        _foodQuantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Image.network(
                        'https://via.placeholder.com/150',
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Food Name',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text('Restaurant A'),
                          Text('Price: Rp 10.000'),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: _decrementFoodQuantity,
                          ),
                          Text('$_foodQuantity'),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: _incrementFoodQuantity,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Your order is being prepared'),
                      content: Text('Please wait...'),
                    );
                  },
                );
                Future.delayed(Duration(seconds: 3), () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => Home()),
                  );
                });
              },
              child: Text('Checkout'),
            ),
          ],
        ),
      ),
    );
  }
}

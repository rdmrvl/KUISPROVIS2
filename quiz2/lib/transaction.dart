import 'package:flutter/material.dart';

class TransactionPage extends StatefulWidget {
  final String token; // Define token parameter here
  @override
  _TransactionPageState createState() => _TransactionPageState();
  
  const TransactionPage({Key? key, required this.token}) : super(key: key); // Update constructor
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          Text('Status: Your order is being prepared'),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Text('Quantity: 1'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(CustomerApp());
}

class CustomerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Customer App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CustomerHome(),
    );
  }
}

class CustomerHome extends StatefulWidget {
  @override
  _CustomerHomeState createState() => _CustomerHomeState();
}

class _CustomerHomeState extends State<CustomerHome> {
  List products = [];
  List orders = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
    fetchOrders();
  }

  // Fetch products from backend
  fetchProducts() async {
    final response =
        await http.get(Uri.parse('http://10.81.85.73:5000/api/customer/products'));
    if (response.statusCode == 200) {
      setState(() {
        products = json.decode(response.body)['products'];
      });
    }
  }

  // Fetch orders from backend
  fetchOrders() async {
    final response =
        await http.get(Uri.parse('http://10.81.85.73:5000/api/customer/orders'));
    if (response.statusCode == 200) {
      setState(() {
        orders = json.decode(response.body)['orders'];
      });
    }
  }

  // Place order
  placeOrder(int productId) async {
    final response = await http.post(
      Uri.parse('http://10.81.85.73:5000/api/customer/orders'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'productId': productId, 'quantity': 1}),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Order placed!')));
      fetchOrders();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Customer App')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            Text('Products', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ...products.map((p) => ListTile(
                  title: Text(p['name']),
                  subtitle: Text('\$${p['price']}'),
                  trailing: ElevatedButton(
                    child: Text('Order'),
                    onPressed: () => placeOrder(p['id']),
                  ),
                )),
            Divider(),
            Text('My Orders', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ...orders.map((o) => ListTile(
                  title: Text(o['product']),
                  subtitle: Text('Quantity: ${o['quantity']} | Status: ${o['status']}'),
                )),
          ],
        ),
      ),
    );
  }
}

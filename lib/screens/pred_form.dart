import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MarketingExpensesScreen extends StatefulWidget {
  const MarketingExpensesScreen({super.key});

  @override
  _MarketingExpensesScreenState createState() => _MarketingExpensesScreenState();
}

class _MarketingExpensesScreenState extends State<MarketingExpensesScreen> {
  final _marketingExpensesController = TextEditingController();
  String _predictedTVSales = '';

  Future<String> predictTVSales(double marketingExpenses) async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/predict'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, double>{
        'tv': marketingExpenses,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['predicted_sales'].toString();
    } else {
      throw Exception('Failed to predict TV sales: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                const Text(
                  'Marketing Expense Prediction',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Marketing Expenses',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 350,
                      child: TextField(
                        controller: _marketingExpensesController,
                        decoration: const InputDecoration(
                          hintText: 'Enter marketing expenses',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  height: 44.0,
                  width: 250.0,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.blue,
                        Colors.teal,
                      ],
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(22)),
                  ),
                  child: ElevatedButton(
                    onPressed: () async {
                      double marketingExpenses = double.parse(_marketingExpensesController.text);
                      try {
                        String predictedTVSales = await predictTVSales(marketingExpenses);
                        setState(() {
                          _predictedTVSales = 'Predicted Sales: $predictedTVSales';
                        });
                      } catch (error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Error: $error'),
                            duration: const Duration(seconds: 5),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                    child: const Text(
                      'Predict',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  _predictedTVSales,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
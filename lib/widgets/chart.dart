import 'package:flutter/material.dart';
import 'package:flutter_personal_money_app/widgets/chart_bar.dart';
import 'package:intl/intl.dart';
import '../models/transactions.dart';

class Chart extends StatelessWidget {
  final List<Transactions>? userTransactions;

  // Constructor
  Chart(this.userTransactions);

  // Method to generate transaction data for the chart
  List<Map<String, Object>> generateTransactions() {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;
      for (int i = 0; i < (userTransactions?.length ?? 0); i++) {
        if (userTransactions?[i].date.day == weekDay.day &&
            userTransactions?[i].date.month == weekDay.month &&
            userTransactions?[i].date.year == weekDay.year) {
          totalSum += userTransactions?[i].amount ?? 0.0;
        }
      }
      return {'day': DateFormat.E().format(weekDay), 'amount': totalSum};
    }).reversed.toList();
  }

  // Method to calculate total spending
  double get totalSpending {
    return generateTransactions().fold(0.0, (previousValue, data) {
      return previousValue + (data['amount'] as double? ?? 0.0);
    });
  }

  // Build method for the widget
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: generateTransactions().map((value) {
          return Flexible(
            fit: FlexFit.tight,
            child: ChartBar(
              value['day'].toString(),
              (value['amount'] as double? ?? 0.0),
              totalSpending == 0.0
                  ? 0.0
                  : (value['amount'] as double? ?? 0.0) / totalSpending,
            ),
          );
        }).toList(),
      ),
    );
  }
}

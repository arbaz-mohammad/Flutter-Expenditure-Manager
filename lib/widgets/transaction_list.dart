import 'package:flutter/material.dart';
import '../models/transactions.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transactions>? userTransactions;
  final Function(String)? deleteTransaction;

  TransactionList({this.userTransactions, this.deleteTransaction});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: userTransactions == null || userTransactions!.isEmpty
          ? LayoutBuilder(
              builder: (ctx, constraints) {
                return Column(
                  children: [
                    Text(
                      'No Transactions Added Yet',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: constraints.maxHeight * 0.7,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                );
              },
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 35,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: FittedBox(
                          child: Text(
                            '\₹${userTransactions![index].amount}',
                            style: TextStyle(
                                color: const Color.fromARGB(255, 225, 67, 67)),
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      '${userTransactions![index].title}',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                      '${DateFormat.yMMMd().format(userTransactions![index].date)}',
                      style: TextStyle(color: Color.fromARGB(255, 4, 4, 4)),
                    ),
                    trailing: MediaQuery.of(context).size.width > 360
                        ? TextButton.icon(
                            onPressed: () {
                              deleteTransaction!(userTransactions![index].id);
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Color.fromARGB(255, 212, 231, 6),
                            ),
                            label: Text(
                              'Delete',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 229, 255, 0)),
                            ),
                          )
                        : IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              deleteTransaction!(userTransactions![index].id);
                            },
                          ),
                  ),
                );
              },
              itemCount: userTransactions!.length,
            ),
    );
  }
}

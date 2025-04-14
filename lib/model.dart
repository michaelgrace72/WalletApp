import 'package:objectbox/objectbox.dart';

@Entity()
class Category {
  int id;
  String name;

  Category({this.id = 0, required this.name});
}

@Entity()
class TransactionModel {
  int id;
  double amount;
  String info;
  String category;
  DateTime dateTime;

  TransactionModel({
    this.id = 0,
    required this.amount,
    required this.info,
    required this.category,
    required this.dateTime,
  });
}

@Entity()
class Budget {
  int id;
  double total;

  Budget({this.id = 0, this.total = 0});
}

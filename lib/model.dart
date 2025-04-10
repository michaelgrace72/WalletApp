import 'package:objectbox/objectbox.dart';

@Entity()
class Category{
  @Id()
  int id;

  String name;

  Category({
    this.id = 0,
    required this.name,
  });

}

@Entity()
class Transaction {
  @Id()
  int id;

  String name;           // e.g. "Grab Ride"
  double amount;
  bool type;             // true = income, false = expense
  DateTime date;

  int categoryId;        // FK to Category
  String note;

  Transaction({
    this.id = 0,
    required this.name,
    required this.amount,
    required this.date,
    required this.categoryId,
    required this.type,
    this.note = '',
  });
}


@Entity()
class Account{
  @Id()
  int id;
  double balance;
  bool isDefault;

  Account({
    this.id = 0,
    required this.balance,
    this.isDefault = false,
  });
}
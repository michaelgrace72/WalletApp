import 'objectbox.g.dart';
import 'model.dart';

class ObjectBox {
  late final Store store;
  late final Box<TransactionModel> transactionBox;
  late final Box<Category> categoryBox;
  late final Box<Budget> budgetBox;

  ObjectBox._create(this.store) {
    transactionBox = Box<TransactionModel>(store);
    categoryBox = Box<Category>(store);
    budgetBox = Box<Budget>(store);

    _initDefaultBudget();
    _initDefaultCategories();
  }

  static Future<ObjectBox> create() async {
    final store = await openStore();
    return ObjectBox._create(store);
  }

  void _initDefaultBudget() {
    if (budgetBox.isEmpty()) {
      budgetBox.put(Budget(total: 0));
    }
  }

  void _initDefaultCategories() {
    if (categoryBox.isEmpty()) {
      categoryBox.putMany([
        Category(name: 'Food'),
        Category(name: 'Transport'),
        Category(name: 'Shopping'),
        Category(name: 'Salary'),
        Category(name: 'Other'),
      ]);
    }
  }

  Budget get currentBudget => budgetBox.getAll().first;
}

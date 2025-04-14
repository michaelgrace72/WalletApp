# wallet

An android app to set up a monthly budget and track the responding expenses

## 🚀 Getting Started

### 1. 🔧 Prerequisites

- Flutter SDK (>=3.0.0)
- Dart
- ObjectBox CLI (for model generation)

### 2. ️ Clone the repository

```bash
git clone https://github.com/yourusername/budget-tracker.git
cd budget-tracker
```

### 3. Install Dependencies
```
flutter pub get
```

### 4. Generate Objectbox-connection to database
```
dart pub global activate objectbox_generator
dart run build_runner build
```

### 5. Run the App
```
flutter run
```


## 🧑‍💻 Code Overview

###  objectbox.dart

- Initializes the ObjectBox store and opens the boxes.
- Used to interact with the local database across the app.

### home_page.dart

- Displays current budget balance
- Lists 5 recent transactions
- floating action buttong to add new transaction

### history_page.dart
- shows all transaction with category, info, amount and time

### reports_page.dart
- show monthly income & expenses
- group by year and month

### add_transaction.dart
- form to input the expenses
- automatically updates balance in the database
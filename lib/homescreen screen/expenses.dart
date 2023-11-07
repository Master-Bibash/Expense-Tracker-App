class expenses {
  final String expenseAmount;
  final String expenseTitile; // Typo corrected from 'expenseTitle'
  final String ENtertainment;
  final String expensedate;

  expenses({
    required this.expenseAmount,
    required this.expenseTitile, // Typo corrected from 'expenseTitle'
    required this.ENtertainment,
    required this.expensedate,
  });

  expenses.fromMap(Map<String, dynamic> map)
      : assert(map['expenseAmount'] != null),
        assert(map['expenseTitile'] != null), // Typo corrected from 'expenseTitle'
        assert(map['ENtertainment'] != null),
        assert(map['expensedate'] != null),
        expenseAmount = map['expenseAmount'],
        expenseTitile = map['expenseTitile'], // Typo corrected from 'expenseTitle'
        ENtertainment = map['ENtertainment'],
        expensedate = map['expensedate'];

  @override
  String toString() => "Records<$expenseAmount:$expenseTitile:$ENtertainment:$expensedate>";
}

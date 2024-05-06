class ExpenseCategories{
  final int category_id;
  final String category_name;
  final String img_path;

  ExpenseCategories({required this.category_id,required this.category_name,required this.img_path});
}


List<ExpenseCategories> expense_categories = [];
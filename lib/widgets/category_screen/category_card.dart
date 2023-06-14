import 'package:wealth_wise/models/database_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wealth_wise/widgets/update_form.dart';
import '../../models/ex_category.dart';
import '../expense_form.dart';

class CategoryCard extends StatelessWidget {
  final ExpenseCategory category;
  const CategoryCard(this.category, {super.key});

  @override
  Widget build(BuildContext context) {
    var db = Provider.of<DatabaseProvider>(context);

    return Slidable(
      // The end action pane is the one at the right or the bottom side.
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              db.deleteCategory(category.title);
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      startActionPane: ActionPane(motion: ScrollMotion(), children: [
        SlidableAction(
          onPressed: (context) {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (_) => const UpdateForm(),
            );
            // db.updateCategory(category, nEntries., nTotalAmount)
          },
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          icon: Icons.update,
          label: 'Update',
        )
      ]),

      child: ListTile(
        onTap: () {
          // Navigator.of(context).pushNamed(
          //   ExpenseScreen.name,
          //   arguments: category.title, // for expensescreen.
          // );
        },
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(category.icon),
        ),
        title: Text(category.title),
        subtitle: Text('entries: ${category.entries}'),
        trailing: Text(
          NumberFormat.currency(locale: 'en_NP', symbol: 'Rs ')
              .format(category.totalAmount),
        ),
      ),
    );
  }
}

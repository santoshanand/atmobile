import 'package:auto_trade/core/models/trade_model.dart';
import 'package:auto_trade/core/providers/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TradeScreen extends ConsumerWidget {
  const TradeScreen({Key? key}) : super(key: key);

  List<DataColumn> _createColumns() {
    return [
      const DataColumn(
        label: Text('ID'),
        numeric: true,
      ),
      const DataColumn(
        label: Text('Name'),
      ),
      const DataColumn(
        label: Text('Date'),
      ),
    ];
  }

  List<DataRow> _createRows(List<TradeModel> items) {
    var index = 0;
    return items.map((item) {
      index++;
      return DataRow(
        cells: [
          DataCell(
            Text(
              index.toString(),
            ),
          ),
          DataCell(Text(item.zerodhaSymbol.toString())),
          DataCell(
            Text(item.createdAt.toString()),
          ),
        ],
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var sp = ref.watch(tradesProvider);
    return sp.when(data: (items) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: RefreshIndicator(
          onRefresh: () async {
            sp = ref.refresh(tradesProvider);
          },
          child: SingleChildScrollView(
            child: DataTable(
              columns: _createColumns(),
              rows: _createRows(items),
              sortColumnIndex: 1,
            ),
          ),
        ),
      );
    }, error: ((error, stackTrace) {
      return Text(error.toString());
    }), loading: () {
      return const Center(child: CircularProgressIndicator(strokeWidth: 2));
    });
  }
}

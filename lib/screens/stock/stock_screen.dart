import 'package:auto_trade/core/models/stock_model.dart';
import 'package:auto_trade/core/providers/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StockScreen extends ConsumerWidget {
  const StockScreen({Key? key}) : super(key: key);

  List<DataColumn> _createColumns() {
    return [
      const DataColumn(
        label: Text('ID'),
      ),
      const DataColumn(
        label: Text('Name'),
      ),
      const DataColumn(
        label: Text('LotSize'),
      ),
    ];
  }

  List<DataRow> _createRows(List<StockModel> items) {
    var index = 0;
    return items.map((item) {
      index++;
      return DataRow(
        cells: [
          DataCell(
            Text(
              index.toString(),
              style: const TextStyle(fontSize: 12),
            ),
          ),
          DataCell(
            Text(
              item.tradingSymbol.toString(),
              style: const TextStyle(fontSize: 12),
            ),
          ),
          DataCell(
            Text(
              item.lotSize.toString(),
              style: const TextStyle(fontSize: 12),
            ),
          )
        ],
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var sp = ref.watch(stocksProvider);
    return RefreshIndicator(
      onRefresh: () async {
        sp = ref.refresh(stocksProvider);
      },
      child: sp.when(data: (items) {
        return SingleChildScrollView(
          child: DataTable(
            columns: _createColumns(),
            rows: _createRows(items),
            sortColumnIndex: 1,
          ),
        );
      }, error: ((error, stackTrace) {
        return Text(error.toString());
      }), loading: () {
        return const Center(child: CircularProgressIndicator(strokeWidth: 2));
      }),
    );
  }
}

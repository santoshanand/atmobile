import 'package:auto_trade/core/models/stock_model.dart';
import 'package:flutter/material.dart';

class StockScreen extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {},
      child: SingleChildScrollView(
        child: DataTable(
          columns: _createColumns(),
          rows: _createRows([]),
          sortColumnIndex: 1,
        ),
      ),
    );
  }
}

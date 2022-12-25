import 'package:auto_trade/core/models/trade_model.dart';
import 'package:flutter/material.dart';

class TradeScreen extends StatelessWidget {
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
              style: const TextStyle(fontSize: 12),
            ),
          ),
          DataCell(
            Text(
              item.zerodhaSymbol.toString(),
              style: const TextStyle(fontSize: 12),
            ),
          ),
          DataCell(
            Text(
              item.createdAt.toString(),
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ],
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    // var sp = ref.watch(tradesProvider);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: RefreshIndicator(
        onRefresh: () async {
          // sp = ref.refresh(tradesProvider);
        },
        child: SingleChildScrollView(
            child: DataTable(
          columns: _createColumns(),
          rows: _createRows([]),
          sortColumnIndex: 1,
        )),
      ),
    );
  }
}

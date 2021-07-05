import 'package:flutter/material.dart';
import 'package:flutter_qrscanner/providers/scan_list_provider.dart';
import 'package:flutter_qrscanner/utils/utils.dart';
import 'package:provider/provider.dart';

class ScanTile extends StatelessWidget {
  final tipo;

  const ScanTile({required this.tipo});
  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scan = scanListProvider.scans;
    return ListView.builder(
      itemCount: scan.length,
      itemBuilder: (_, i) => Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.red,
        ),
        onDismissed: (DismissDirection direction) {
          Provider.of<ScanListProvider>(context, listen: false)
              .borrarTodoPorId(scan[i]!.id, scan[i]!.tipo);
        },
        child: ListTile(
          leading: Icon(
            this.tipo == 'http' ? Icons.home_outlined : Icons.map_outlined,
            color: Theme.of(context).primaryColor,
          ),
          title: Text(scan[i]!.valor),
          subtitle: Text(scan[i]!.id.toString()),
          trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey),
          onTap: () => launchURL(context, scan[i]!),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:native_resources/providers/great_places.dart';
import 'package:native_resources/utils/app_routes.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Lugares'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.placeForm);
            },
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder(
          future: Provider.of<GreatPlaces>(context, listen: false).loadPlaces(),
          builder: (ctx, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? const Center(child: CircularProgressIndicator())
              : Consumer<GreatPlaces>(
                  child: const Text('Nenhum local cadastrado.'),
                  // contexto, change notifier e child
                  builder: (ctx, greatPlaces, ch) => greatPlaces.itemsCount == 0
                      ? const Text('')
                      : ListView.builder(
                          itemCount: greatPlaces.itemsCount,
                          itemBuilder: (ctx, i) => ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  FileImage(greatPlaces.itemByIndex(i).image),
                            ),
                            title: Text(greatPlaces.itemByIndex(i).title),
                            onTap: () {},
                          ),
                        ),
                ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 05 - Lab B',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      home: const CarTablePage(),
    );
  }
}

class Car {
  const Car(this.make, this.model, this.price);

  final String make;
  final String model;
  final int price;
}

class CarTablePage extends StatefulWidget {
  const CarTablePage({super.key});

  @override
  State<CarTablePage> createState() => _CarTablePageState();
}

class _CarTablePageState extends State<CarTablePage> {
  final List<Car> _cars = [
    const Car('Toyota', 'Vios', 89000),
    const Car('Honda', 'Civic', 134000),
    const Car('Proton', 'X50', 93000),
    const Car('Perodua', 'Myvi', 51000),
    const Car('Mazda', 'CX-5', 144000),
    const Car('Nissan', 'Almera', 82000),
  ];

  // null = default order, so no sort arrow is shown at first.
  int? _sortColumnIndex;
  bool _sortAscending = true;

  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Cars matching the search text, in the current sort order.
  List<Car> _filterCars(String searchText) {
    final needle = searchText.trim().toLowerCase();
    if (needle.isEmpty) return _cars;
    return _cars
        .where(
          (car) =>
              car.make.toLowerCase().contains(needle) ||
              car.model.toLowerCase().contains(needle),
        )
        .toList();
  }

  void _sort<T extends Comparable>(
    T Function(Car car) getField,
    int columnIndex,
    bool ascending,
  ) {
    setState(() {
      _cars.sort((a, b) {
        final valueA = getField(a);
        final valueB = getField(b);
        return ascending
            ? Comparable.compare(valueA, valueB)
            : Comparable.compare(valueB, valueA);
      });
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Car List')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search by make or model',
                prefixIcon: const Icon(Icons.search),
                border: const OutlineInputBorder(),
                // Only this small part rebuilds when the text changes.
                suffixIcon: ValueListenableBuilder<TextEditingValue>(
                  valueListenable: _searchController,
                  builder: (context, value, _) {
                    if (value.text.isEmpty) return const SizedBox.shrink();
                    return IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: _searchController.clear,
                    );
                  },
                ),
              ),
            ),
          ),
          // The label and table rebuild on typing; the TextField does not.
          Expanded(
            child: ValueListenableBuilder<TextEditingValue>(
              valueListenable: _searchController,
              builder: (context, value, _) {
                final filtered = _filterCars(value.text);
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '${filtered.length} of ${_cars.length} cars match',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: SizedBox(
                          width: double.infinity,
                          child: DataTable(
                            sortColumnIndex: _sortColumnIndex,
                            sortAscending: _sortAscending,
                            columns: [
                              DataColumn(
                                label: const Text('Car Make'),
                                onSort: (i, asc) =>
                                    _sort<String>((car) => car.make, i, asc),
                              ),
                              DataColumn(
                                label: const Text('Model'),
                                onSort: (i, asc) =>
                                    _sort<String>((car) => car.model, i, asc),
                              ),
                              DataColumn(
                                label: const Text('Price (RM)'),
                                numeric: true,
                                onSort: (i, asc) =>
                                    _sort<num>((car) => car.price, i, asc),
                              ),
                            ],
                            rows: filtered
                                .map(
                                  (car) => DataRow(
                                    cells: [
                                      DataCell(Text(car.make)),
                                      DataCell(Text(car.model)),
                                      DataCell(Text(car.price.toString())),
                                    ],
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SizedBox(
          width: double.infinity,
          child: DataTable(
            sortColumnIndex: _sortColumnIndex,
            sortAscending: _sortAscending,
            columns: [
              DataColumn(
                label: const Text('Car Make'),
                onSort: (i, asc) => _sort<String>((car) => car.make, i, asc),
              ),
              DataColumn(
                label: const Text('Model'),
                onSort: (i, asc) => _sort<String>((car) => car.model, i, asc),
              ),
              DataColumn(
                label: const Text('Price (RM)'),
                numeric: true,
                onSort: (i, asc) => _sort<num>((car) => car.price, i, asc),
              ),
            ],
            rows: _cars
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
    );
  }
}

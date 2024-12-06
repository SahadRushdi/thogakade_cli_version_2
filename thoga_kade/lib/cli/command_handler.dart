import 'dart:io';

import 'package:thoga_kade/model/vegetable.dart';
import 'package:thoga_kade/repository/inventory_repository.dart';

class CommandHandler {
  final InventoryRepository inventoryRepository;

  CommandHandler(this.inventoryRepository);

  Future<void> showMenu() async {
    while (true) {
      print('--------------- Thoga Kade Management ---------------');
      print('1. View Inventory');
      print('2. Add Vegetable');
      print('3. Remove Vegetable');
      print('4. Exit');
      stdout.write('Choose an option: ');

      final choice = stdin.readLineSync();

      switch (choice) {
        case '1':
          await _viewInventory();
          break;
        case '2':
          await _addVegetable();
          break;
        case '3':
          await _removeVegetable();
          break;
        case '4':
          print('Goodbye!');
          return;
        default:
          print('Invalid option. Try again.');
      }
    }
  }

  Future<void> _viewInventory() async {
    final inventory = inventoryRepository.getInventory();
    if (inventory.isEmpty) {
      print('No vegetables in inventory.');
    } else {
      for (var veg in inventory) {
        print('${veg.id} - ${veg.name}: ${veg.availableQuantity}kg @ \$${veg.pricePerKg}/kg');
      }
    }
  }

  Future<void> _addVegetable() async {
    stdout.write('Enter vegetable name: ');
    final name = stdin.readLineSync()!;
    stdout.write('Enter price per kg: ');
    final price = double.parse(stdin.readLineSync()!);
    stdout.write('Enter available quantity: ');
    final quantity = double.parse(stdin.readLineSync()!);
    stdout.write('Enter category: ');
    final category = stdin.readLineSync()!;
    stdout.write('Enter expiry date (YYYY-MM-DD): ');
    final expiry = DateTime.parse(stdin.readLineSync()!);

    final vegetable = Vegetable(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      pricePerKg: price,
      availableQuantity: quantity,
      category: category,
      expiryDate: expiry,
    );

    await inventoryRepository.addVegetable(vegetable);
    print('Vegetable added successfully!');
  }

  Future<void> _removeVegetable() async {
    stdout.write('Enter vegetable ID to remove: ');
    final id = stdin.readLineSync()!;
    await inventoryRepository.removeVegetable(id);
    print('Vegetable removed successfully!');
  }
}

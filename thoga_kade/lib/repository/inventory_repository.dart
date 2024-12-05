import 'dart:convert';
import 'dart:io';

import 'package:thoga_kade/model/vegetable.dart';

class InventoryRepository {
  final List<Vegetable> _inventory = [];
  final String filePath;

  InventoryRepository(this.filePath);

  Future<void> addVegetable(Vegetable vegetable) async {
    _inventory.add(vegetable);
    await _saveToFile();
  }

  Future<void> removeVegetable(String id) async {
    _inventory.removeWhere((veg) => veg.id == id);
    await _saveToFile();
  }

  Future<void> updateStock(String id, double quantity) async {
    final vegetable = _inventory.firstWhere((veg) => veg.id == id, orElse: () => throw Exception('Vegetable not found'));
    vegetable.availableQuantity += quantity;
    await _saveToFile();
  }

  List<Vegetable> getInventory() => _inventory;

  Future<void> loadFromFile() async {
    try {
      final file = File(filePath);
      if (await file.exists()) {
        final contents = await file.readAsString();
        final data = jsonDecode(contents) as List;
        _inventory.clear();
        _inventory.addAll(data.map((json) => Vegetable.fromJson(json)).toList());
      }
    } catch (e) {
      throw Exception('Error loading inventory: $e');
    }
  }

  Future<void> _saveToFile() async {
    try {
      final file = File(filePath);
      await file.writeAsString(jsonEncode(_inventory.map((veg) => veg.toJson()).toList()));
    } catch (e) {
      throw Exception('Error saving inventory: $e');
    }
  }
}

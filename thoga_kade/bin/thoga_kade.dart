import 'package:thoga_kade/cli/command_handler.dart';
import 'package:thoga_kade/repository/inventory_repository.dart';

void main() async {
  final inventoryRepo = InventoryRepository('inventory.json');
  await inventoryRepo.loadFromFile();

  final commandHandler = CommandHandler(inventoryRepo);
  await commandHandler.showMenu();
}

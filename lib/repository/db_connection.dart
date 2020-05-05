import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseConnection {

  initDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'db_ecom_3');
    var database =
        await openDatabase(path, version: 1, onCreate: _onCreatingDatabase);
    return database;
  }

  _onCreatingDatabase(Database db, int version) async {
    await db.execute(
        "CREATE TABLE carts(id INTEGER PRIMARY KEY, product_id INTEGER, product_title TEXT, product_img1 TEXT, product_price INTEGER, product_sale INTEGER, product_quantity INTEGER)");
  }
}

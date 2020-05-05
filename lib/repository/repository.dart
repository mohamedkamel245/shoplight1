import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
import 'db_connection.dart';
class Repository {
  DatabaseConnection _connection;
  String _baseUrl = 'https://www.sh-oplight.com/api';
  String _baseUrr = 'https://www.sh-oplight.com/api/productsCat.php?catId=';

  var _headers = {"Content-type": "application/x-www-form-urlencoded", "Accept": "application/json"};

  Repository(){
    _connection = DatabaseConnection();
  }

static Database _database;
 Future<Database> get database async {
    if(_database != null)
        return _database;
    _database = await _connection.initDatabase();

    return _database;
  }

  httpGet(String api) async {
  return await http.get(_baseUrl + "/" + api);
}

httpgtr(String catId) async{
return http.get(_baseUrr + catId);
}





httpPost(String api, data) async {
    print(data);
    return await http.post(_baseUrl + "/" + api);
  }

httpGetById(String api, catId) async {
return await http.get(_baseUrl + "/" + api + "/" + catId);

}


 getAllLocal(table) async {
    var conn = await database;
    return await conn.query(table);
  }

saveLocal(table, data) async{
  var conn = await database;
  return await conn.insert(table, data);
}

updateLocal(table, columnName, data) async{
  var conn = await database;
  return await conn.update(table, data, where: '$columnName =?', whereArgs: [data['product_id']]);
}

  getLocalByCondition(table,  columnName,  conditionalValue) async {
    var conn = await database;
    return await conn.rawQuery('SELECT * FROM $table WHERE $columnName =?', ['$conditionalValue']);
  }

  deleteLocalById(table, product_id) async {
    var conn = await database;
    return await conn.rawDelete("DELETE FROM $table WHERE product_id = $product_id");
  }

  deleteLocal(table) async {
    var conn = await database;
    return await conn.rawDelete("DELETE FROM $table");
  }


}


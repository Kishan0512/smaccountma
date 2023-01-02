import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class bussiness extends GetxController
{
  static Database? database;
  TextEditingController t =TextEditingController();

  RxBool temp=false.obs;
      RxList name=[].obs;
      RxList credit=[].obs;
      RxList debit=[].obs;
      RxList balance=[].obs;
      RxList id=[].obs;
List<Map> m=[];
Future get_database()
  async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'account.db');
     database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(
              'CREATE TABLE demo (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT)');
        });
  }
  Future get_account()async
  {
    name.value.clear();

    id.value.clear();
    temp.value=false;
    String qur="select * from demo";
    m = await database!.rawQuery(qur);
      m.forEach((element) {
        name.add(element['name']);

        id.add(element['id']);
      });
      temp.value=true;

  }
  add_account(String name1)
  {
    String qur="insert into demo values(null,'$name1')";
    database!.rawInsert(qur);
  }
  delete_account(int id1)
  {
    String qur="delete from demo where id=$id1";
    database!.rawDelete(qur);
  }
  update_account(int id1,String name1)
  {
    String qur="update demo set name='$name1' where id=$id1";
    database!.rawUpdate(qur);
  }

}
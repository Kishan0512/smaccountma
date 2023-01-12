
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class bussiness extends GetxController
{


  RxBool temp=false.obs;
  RxList list=[].obs;
  RxList templist=[].obs;
  RxList trans_list=[].obs;
  RxString gvalue="credit".obs;
  String r1="credit";
  String r2="debit";
  RxInt credit=0.obs;
  RxInt debit=0.obs;
  RxInt total=0.obs;
  RxInt credit1=0.obs;
  RxInt debit1=0.obs;
  RxInt total1=0.obs;
  RxList creditlist=[].obs;
  RxList debitlist=[].obs;
  RxList totallist=[].obs;
List<Map> m=[];
Future<Database> get_database()
  async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'account.db');
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(
              'CREATE TABLE account (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT)');
          await db.execute(
              'CREATE TABLE account_tran (id INTEGER PRIMARY KEY, acid INTEGER, date TEXT, amount INTEGER,type TEXT,reason TEXT)');
        });
    return database;
  }
  Future get_account()async
  {


    temp.value=false;
    get_database().then((value) {
    String qur="select * from demo";
    value.rawQuery(qur).then((value){
      list.value=value;
      list.forEach((element) {
        getaccbyid(element['id']);
      });
    });
    });

  }
  getaccbyid(int id) {

    //select * from account join accnt_trans on account.id=accnt_trans.acid where account.id=1
    get_database().then((value) {
      String q="select * from account join account_tran on account.id=account_tran.acid where account.id=$id";
      value.rawQuery(q).then((value){
        credit1.value=0;
        debit1.value=0;
        total1.value=0;
        templist.value=value;
        templist.forEach((element) {
          print(element['amount']);
          if(element['type']=="credit")
          {
            credit1.value=credit1.value+element['amount'] as int;
          }
          if(element['type']=="debit")
          {
            debit1.value=debit1.value+element['amount'] as int;
          }
        });
        total1.value=credit1.value-debit1.value;
        creditlist.add(credit1.value);
        debitlist.add(debit1.value);
        totallist.add(total1.value);
      });
      // print("templist=${templist.value}");
    });
  }
  get_transaction(int id) {
    credit.value=0;
    debit.value=0;

    get_database().then((value) {
      String q="select * from accnt_trans where acid=$id";
      value.rawQuery(q).then((value){
        trans_list.value=value;
        trans_list.forEach((element) {
          print(element['amount']);
          if(element['type']=="credit")
          {
            credit.value=credit.value+element['amount'] as int;
          }
          if(element['type']=="debit")
          {
            debit.value=debit.value+element['amount'] as int;
          }
        });
        print(credit.value);
        print(debit.value);

        total.value=credit.value-debit.value;
      });
      print(trans_list.value);
    });
  }
  add_account(String name1)
  { get_database().then((value) {
    String qur="insert into demo values(null,'$name1')";
    value.rawInsert(qur);});
  }
  delete_account(int id1)
  {get_database().then((value) {
    String qur="delete from demo where id=$id1";
    value.rawDelete(qur);});
  }
  update_account(int id1,String name1)
  {get_database().then((value) {
    String qur="update demo set name='$name1' where id=$id1";
    value.rawUpdate(qur);});
  }
  insert_transaction(String date,String amount,String type,String reason,int id)
  {
    //id INTEGER PRIMARY KEY, acid INTEGER, date TEXT, amount INTEGER,type TEXT,reason TEXT
    get_database().then((value) {
      String q="insert into accnt_trans values (null,'$id','$date','$amount','$type','$reason')";
      value.rawInsert(q).then((value){
        print(value);
        if(value>=1)
        {
          get_transaction(id);
        }
      });
    });
  }
}
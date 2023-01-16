import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smaccountma/bussiness.dart';
import 'package:smaccountma/data.dart';
import 'package:smaccountma/main.dart';

class passbook extends StatelessWidget {
  bussiness c =Get.put(bussiness());
  Account a;
  passbook(this.a,context);
  TextEditingController t1 =TextEditingController();
  TextEditingController t2 =TextEditingController();
  TextEditingController t3 =TextEditingController();
  @override
  Widget build(BuildContext context) {
    if(a!=null)
    {
      c.get_transaction(a.id!);
    }
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.purple.shade900,
          title: Text("${a.name}"),
          actions: [
            IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          actions: [
                            Row(mainAxisAlignment: MainAxisAlignment.end,children: [
                              TextButton(onPressed: () {
                                t1.clear();
                                      t2.clear();
                                      t3.clear();
                                      Navigator.pop(context);
                              }, child: Text("CANCEL",style: TextStyle(fontSize: 20),)),
                              TextButton(style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => Colors.purple.shade900)),onPressed: () {
                                c.insert_transaction(t1.text, t2.text, c.gvalue.value, t3.text, a.id!);
                                t1.text="";
                                t2.text="";
                                t3.text="";
                                Navigator.pop(context);
                              }, child: Text("ADD",style: TextStyle(fontSize: 20,color: Colors.white),)),
                            ],)
                          ],
                          content: Container(height: 250,width: 300,child: Column(
                            children: [
                              Container(color: Colors.purple.shade900,alignment: Alignment.center,height: 50,child: Text("Add Transaction",
                                  style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 20)),),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextField(decoration: InputDecoration(hintText: "Date"),readOnly: true,onTap: () {
                                      showDatePicker(context: context, initialDate: DateTime.now(), firstDate:DateTime(2000) , lastDate: DateTime(2025)).then((value) {
                                        t1.text="${value!.day}/${value.month}/${value.year}";
                                      });

                                    },controller: t1,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                  ),
                                ],),

                              Obx(()=>Row(children: [
                                Radio(value: c.r1, groupValue: c.gvalue.value, onChanged: (value) {
                                  c.gvalue.value=c.r1;
                                },),
                                Text("Credit(+)",style: TextStyle(fontSize: 20),),
                                Radio(value: c.r2, groupValue: c.gvalue.value, onChanged: (value) {
                                  c.gvalue.value=c.r2;
                                },),
                                Text("Debit(-)",style: TextStyle(fontSize: 20),),
                              ],),),

                              Expanded(child: TextField(keyboardType: TextInputType.number,controller: t2,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),decoration: InputDecoration(hintText: "Amount")),),
                              Expanded(child: TextField(controller: t3,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),decoration: InputDecoration(hintText: "Particular"),),),],
                          ),),
                        );

                      },
                    );
                  },
                  icon: Icon(Icons.add)),

            PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(child: Text("save as PDF")),
                PopupMenuItem(child: Text("save as Excel"))
              ],
            )
          ]),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                  child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        "Date",
                        style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),
                      ))),
              Expanded(
                  flex: 2,
                  child: Container(
                      alignment: Alignment.center,
                      child:
                          Text("Particular", style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold)))),
              Expanded(
                  child: Container(
                      alignment: Alignment.center,
                      child:
                          Text("Credit(₹)", style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold)))),
              Expanded(
                  child: Container(
                      alignment: Alignment.center,
                      child: Text("Debit(₹)", style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold)))),
            ],
          ),
          SizedBox(height: 10,),
          Row(children: [
            Obx(() => Expanded(
              child: ListView.builder(shrinkWrap:true,itemCount:c.trans_list.length,
                itemBuilder: (context, index) {
                  Transaction t=Transaction.fromMap(c.trans_list.value[index]);
                  print(t);
                  return InkWell(
                    onTap: () {
                      showDialog(context: context, builder: (context) {
                        return SimpleDialog(
                          children: [
                            TextButton(onPressed: () {
                              t1.text=t.date;
                              t2.text='${t.amount}';
                              t3.text=t.reason;
                              c.gvalue.value=t.type;
                              Navigator.pop(context);
                              showDialog(context: context, builder: (context) {
                                return AlertDialog(
                                    title: Text("Add Transaction"),
                                    actions: [
                                      TextButton(onPressed: () {
                                        c.update_transaction(t1.text, t2.text, c.gvalue.value, t3.text, t.id,a.id!);
                                        t1.text="";
                                        t2.text="";
                                        t3.text="";
                                        Navigator.pop(context);
                                      }, child: Text("OK")),
                                      TextButton(onPressed: () {
                                        Navigator.pop(context);
                                      }, child: Text("Cancel")),
                                    ],
                                    content: SingleChildScrollView(
                                      child: Container(height: 200,width: 300,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Expanded(child: TextField(
                                              controller:t1,
                                              readOnly: true,
                                              onTap: () {
                                                showDatePicker(context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime(2000,1,1),
                                                    lastDate: DateTime(2030,1,1)).then((value) {
                                                  print(value);
                                                  t1.text="${value!.day}/${value.month}/${value.year}";
                                                });

                                              },
                                            ),),
                                            Expanded(child: TextField(controller:t2,),),
                                            Obx(() => Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Radio(value:c.r1, groupValue: c.gvalue.value, onChanged: (value) {
                                                    c.gvalue.value=c.r1;
                                                  },),
                                                  Text("Credit"),
                                                  Radio(value: c.r2, groupValue: c.gvalue.value, onChanged: (value) {
                                                    c.gvalue.value=c.r2;
                                                  },),
                                                  Text("Debit"),
                                                ]),),
                                            Expanded(child: TextField(controller:t3,),),
                                          ],),
                                      ),
                                    ),
                                );

                              },);
                            }, child: Text("Edit")),
                            TextButton(onPressed: () {
                              c.delete_transaction(t.id, a.id!);
                              Navigator.pop(context);
                            }, child: Text("Delete")),
                          ],
                        );
                      },);
                      //
                    },
                    child: Row(
                      children: [
                        Expanded(child: Container(alignment: Alignment.center,child: t.type=="credit"?Text("${t.date}",style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold),):Text("${t.date}",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),))),

                         Expanded(flex: 2,child: Container(alignment: Alignment.center,child:t.type=="credit"? Text("${t.reason}",style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold)):Text("${t.reason}",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),)),),
                        Expanded(child: t.type=="credit"?Container(alignment: Alignment.center,child: Text("${t.amount}",style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold))):Container(alignment: Alignment.center,child: Text("0",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold))),),
                        Expanded(child: t.type=="debit"?Container(alignment: Alignment.center,child: Text("${t.amount}",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold))):Container(alignment: Alignment.center,child: Text("0",style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold))),),
                      ],
                    ),
                  );
                },),
            ))
          ],
          ),
          ],),
      bottomNavigationBar: Obx(()=>Row(
          children: [
          Expanded(child: Container(alignment: Alignment.center,color: Colors.grey.shade100,height: 70,child: Text(
        "Credit(↑)\n₹${c.credit}"),)),
          Expanded(child: Container(alignment: Alignment.center,height: 70,color: Colors.black12,child: Text(
              "Debit(↓)\n₹${c.debit}"))),
          Expanded(child: Container(alignment: Alignment.center,height: 70,color: Colors.purple.shade900, child: Text(
            "Balance\n₹${c.total}",
            style: TextStyle(color: Colors.white),
          ))),
        ],),
      ),
    );
  }
}

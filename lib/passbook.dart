import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smaccountma/bussiness.dart';
import 'package:smaccountma/data.dart';

class passbook extends StatelessWidget {
  bussiness c =Get.put(bussiness());
  Account a;
  passbook(this.a,context)
  {
    showDatePicker(context: context, initialDate: DateTime.now(), firstDate:DateTime(2000) , lastDate: DateTime(2025)).then((value) {
      t1.text="${value!.day}/${value.month}/${value.year}";
    });
  }
  TextEditingController t1 =TextEditingController();
  TextEditingController t2 =TextEditingController();
  TextEditingController t3 =TextEditingController();
  @override
  Widget build(BuildContext context) {
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
                          title: Text("Add Transaction",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                          actions: [
                            Row(
                              children: [
                                TextField(readOnly: true,onTap: () {
                                  showDatePicker(context: context, initialDate: DateTime.now(), firstDate:DateTime(2000) , lastDate: DateTime(2025)).then((value) {
                                    t1.text="${value!.day}/${value.month}/${value.year}";
                                  });

                                },controller: t1,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                              ],),
                            Obx( ()=> Row(children: [
                                Radio(value: c.r1, groupValue: c.gvalue.value, onChanged: (value) {
                                  c.gvalue.value=c.r1;
                                },),
                                Text("Credit(+)",style: TextStyle(fontSize: 20),),
                                Radio(value: c.r2, groupValue: c.gvalue.value, onChanged: (value) {
                                  c.gvalue.value=c.r2;
                                },),
                              Text("Debit(-)",style: TextStyle(fontSize: 20),),
                              ],),
                            ),
                            TextField(keyboardType: TextInputType.number,controller: t2,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),decoration: InputDecoration(hintText: "Amount")),
                            TextField(controller: t3,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),decoration: InputDecoration(hintText: "Particular")),
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
                        style: TextStyle(fontSize: 12),
                      ))),
              Expanded(
                  flex: 2,
                  child: Container(
                      alignment: Alignment.center,
                      child:
                          Text("Particular", style: TextStyle(fontSize: 12)))),
              Expanded(
                  child: Container(
                      alignment: Alignment.center,
                      child:
                          Text("Credit(₹)", style: TextStyle(fontSize: 12)))),
              Expanded(
                  child: Container(
                      alignment: Alignment.center,
                      child: Text("Debit(₹)", style: TextStyle(fontSize: 12)))),
            ],
          ),

        ],
      ),
      bottomNavigationBar: Row(
        children: [
        Expanded(child: Container(alignment: Alignment.center,color: Colors.grey.shade100,height: 70,child: Text(
      "Credit(↑)\n₹"),)),
        Expanded(child: Container(alignment: Alignment.center,height: 70,color: Colors.black12,child: Text(
            "Debit(↓)\n₹"))),
        Expanded(child: Container(alignment: Alignment.center,height: 70,color: Colors.purple.shade900, child: Text(
          "Balance\n₹",
          style: TextStyle(color: Colors.white),
        ))),
      ],),
    );
  }
}

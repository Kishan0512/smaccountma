import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smaccountma/bussiness.dart';

class passbook extends StatelessWidget {
  bussiness c =Get.put(bussiness());
  int id;
  String name;
  DateTime? date;
  passbook(this.id, this.name)
  {
    c.t.text=DateTime.now().toString().substring(0,10);
  }


  TextEditingController t2 =TextEditingController();
  TextEditingController t3 =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.purple.shade900,
          title: Text("$name"),
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

                                Expanded(child:  Container(child: TextField(controller: c.t,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),)),

                                IconButton(onPressed: () async {
                                  date= await showDatePicker(context: context, initialDate: DateTime.now(), firstDate:DateTime(2000) , lastDate: DateTime(2025));
                                  if(date!=null)
                                  {
                                   c.t.text=DateTime.now().toString().substring(0,10);
                                  }}, icon:Icon(Icons.date_range)),
                              ],),
                            TextField(keyboardType: TextInputType.number,controller: t2,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),decoration: InputDecoration(hintText: "Amount")),
                            TextField(controller: t3,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),decoration: InputDecoration(hintText: "Particular")),
                            Row(mainAxisAlignment: MainAxisAlignment.end,children: [
                              TextButton(onPressed: () {
                                      t2.clear();
                                      t3.clear();
                                      Navigator.pop(context);
                              }, child: Text("CANCEL",style: TextStyle(fontSize: 20),)),
                              TextButton(style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => Colors.purple.shade900)),onPressed: () {

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

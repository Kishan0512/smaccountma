import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smaccountma/bussiness.dart';
import 'package:smaccountma/passbook.dart';

void main() {
  runApp(GetMaterialApp(home: dashbord(), debugShowCheckedModeBanner: false));
}

class dashbord extends StatelessWidget {
  bussiness c = Get.put(bussiness());

  dashbord() {
    c.get_database().then((value) => c.get_account());
  }

  TextEditingController t = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.purple.shade900,
          title: Text("Dashbord"),
          actions: [
            IconButton(onPressed: () => null, icon: Icon(Icons.search_rounded)),
            PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(child: Text("save as PDF")),
                PopupMenuItem(child: Text("save as Excel"))
              ],
            )
          ]),
      body: c.temp.value
          ? Obx(
              () => ListView.builder(
                itemCount: c.name.length,
                itemBuilder: (context, index) {
                  return InkWell(onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return passbook(c.id[index],c.name[index]);
                    },));
                  },
                    child: Card(
                        shadowColor: Colors.black,
                        margin: EdgeInsets.all(5),
                        child: Container(
                          height: 140,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                    "   ${c.name.value[index]}",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  )),
                                  IconButton(
                                      onPressed: () {
                                        t.text = c.name.value[index];
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text("Update account"),
                                              actions: [
                                                TextField(
                                                  controller: t,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(context);
                                                        },
                                                        child: Text("CANCEL")),
                                                    TextButton(
                                                        style: ButtonStyle(
                                                            backgroundColor:
                                                                MaterialStateColor
                                                                    .resolveWith(
                                                                        (states) => Colors
                                                                            .purple
                                                                            .shade900)),
                                                        onPressed: () {
                                                          String name1 = t.text;
                                                          c.update_account(
                                                              c.id.value[index],
                                                              name1);
                                                          Navigator.pop(context);
                                                          c
                                                              .get_account()
                                                              .then((value) {
                                                            c.temp.value = true;
                                                          });
                                                        },
                                                        child: Text(
                                                          "UPDATE",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ))
                                                  ],
                                                )
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      icon:
                                          Icon(Icons.mode_edit_outline_outlined)),
                                  IconButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text("Are you sure"),
                                              actions: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(context);
                                                        },
                                                        child: Text("No")),
                                                    TextButton(
                                                        style: ButtonStyle(
                                                            backgroundColor:
                                                                MaterialStateColor
                                                                    .resolveWith(
                                                                        (states) => Colors
                                                                            .purple
                                                                            .shade900)),
                                                        onPressed: () {
                                                          c.delete_account(
                                                              c.id.value[index]);
                                                          Navigator.pop(context);
                                                          c
                                                              .get_account()
                                                              .then((value) {
                                                            c.temp.value = true;
                                                          });
                                                        },
                                                        child: Text(
                                                          "Yes",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ))
                                                  ],
                                                )
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      icon: Icon(Icons.delete)),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.all(5),
                                    height: 80,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        borderRadius: BorderRadius.circular(10)),
                                    child: Text(
                                        "Credit(↑)\n₹"),
                                  )),
                                  Expanded(
                                      child: Container(
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.all(5),
                                          height: 80,
                                          decoration: BoxDecoration(
                                              color: Colors.black12,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Text(
                                              "Debit(↓)\n₹"))),
                                  Expanded(
                                      child: Container(
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.all(5),
                                          height: 80,
                                          decoration: BoxDecoration(
                                              color: Colors.purple.shade900,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Text(
                                            "Balance\n₹",
                                            style: TextStyle(color: Colors.white),
                                          ))),
                                ],
                              ),
                            ],
                          ),
                        )),
                  );
                },
              ),
            )
          : Center(
              child: CircularProgressIndicator(
              color: Colors.purple.shade900,
            )),
      drawer: Drawer(
        backgroundColor: Colors.purple.shade900,
        shape: UnderlineInputBorder(borderRadius: BorderRadius.circular(30)),
        child: Text("hello"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MaterialStateColor.resolveWith(
            (states) => Colors.deepOrangeAccent.shade700),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Add new account"),
                actions: [
                  TextField(
                    controller: t,
                    decoration: InputDecoration(hintText: "Account name"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            t.text = "";
                          },
                          child: Text("CANCEL")),
                      TextButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.purple.shade900)),
                          onPressed: () {
                            String name = t.text;
                            c.add_account(name);
                            Navigator.pop(context);
                            t.text = "";
                            c.get_account().then((value) {
                              c.temp.value = true;
                            });
                          },
                          child: Text(
                            "SAVE",
                            style: TextStyle(color: Colors.white),
                          ))
                    ],
                  )
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
      backgroundColor: Colors.grey.shade400,
    );
  }
}

import 'package:demo1/shayari2.dart';
import 'package:demo1/shphoto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: onepage(),
      )
  );
}

class onepage extends StatefulWidget {
  const onepage({super.key});

  @override
  State<onepage> createState() => _onepageState();
}

class _onepageState extends State<onepage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    perm();
  }

  List <bool> temp = List.filled(photo.img.length, false);

  perm() async {
    var status = await Permission.storage.status;
    if (status.isDenied) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.location,
        Permission.storage,
      ].request();
    }
    print(status);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Love Shayari"),),

      body:
      WillPopScope(child: ListView.builder(
        itemCount: photo.img.length, itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            if (index < photo.ti.length) {
              temp[index] = true;
            }
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return twopage(index, photo.ti, photo.img);
            },
            ));
            setState(() {});
            temp[index] = false;
          },
          onTapCancel: () {
            temp[index] = false;
            setState(() {});
          },
          onTapDown: (details) {
            temp[index] = true;
            setState(() {});
          },
          child: Card(
            child: ListTile(
              tileColor: (temp[index] == true) ? Colors.pinkAccent : null,
              trailing: Icon(Icons.chevron_right, color: Colors.white,),
              title: Text("${photo.ti[index]}",
                style: TextStyle(fontSize: 25),
              ),
              leading: CircleAvatar(
                backgroundImage: AssetImage("${photo.img[index]}"),
              ),
            ),
          ),
        );
      },),
        onWillPop: () async {
        final value = await showDialog<bool>(context: context, builder: (context) {
          return AlertDialog(
            title: const Text("Alert"),
            content: const Text("Do you want to Exit"),
            actions: [
              ElevatedButton(onPressed: () => Navigator.of(context).pop(false),
                child: const Text("No"),),
              ElevatedButton(onPressed: () => Navigator.of(context).pop(true),
                child: const Text("Exit"),),
            ],
          );
        });
        if(value!=null){
          return Future.value(value);
        }else{
          return Future.value(false);
        }
      },),
    );
  }
}
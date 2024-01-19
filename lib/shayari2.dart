import 'package:demo1/shayari3.dart';
import 'package:demo1/shphoto.dart';
import 'package:flutter/material.dart';

class twopage extends StatefulWidget {
  int index;
  List ti;
  List img;

  twopage(this.index, this.ti, this.img);

  @override
  State<twopage> createState() => _twopageState();
}

class _twopageState extends State<twopage> {
  List a=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  switch(widget.index)
      {
    case 0:
      {
        a = photo.sh;
        break;
      }
    case 1:
      {
        a = photo.sh2;
        break;
      }
      case 2:
     {
      a = photo.sh3;
      break;
     }
    case 3:
      {
        a = photo.sh4;
        break;
      }
    case 4:
      {
        a = photo.sh5;
        break;
      }
    case 5:
      {
        a = photo.sh6;
        break;
      }
    case 6:
      {
        a = photo.sh7;
        break;
      }
    case 7:
      {
        a = photo.sh8;
        break;
      }
  }
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.ti[widget.index]}"),
      ),
      body: ListView.builder(
        itemCount: a.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return three(index,a);
              },));
            },
                leading: Image.asset("${widget.img[widget.index]}"),
                 title: Text("${a[index]}",maxLines: 1,)
            ),
          );
        },
      ),
    );
  }
}

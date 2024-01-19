import 'dart:math';

import 'package:demo1/shayari4.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

class three extends StatefulWidget {
  int index;
  List ti;

  three(this.index, this.ti);

  @override
  State<three> createState() => _threeState();
}

class _threeState extends State<three> {
  PageController? controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = PageController(initialPage: widget.index);
  }

  int pos1 = 0, pos2 = 1;
  bool color_status = false;
  List a = [
    Colors.brown,
    Colors.lightBlue,
    Colors.grey,
    Colors.black,
    Colors.red,
    Colors.lightGreenAccent,
    Colors.green,
    Colors.brown,
    Colors.pinkAccent,
    Colors.orange,
    Colors.amber,
    Colors.white24,
    Colors.lightBlue,
    Colors.grey,
    Colors.black,
    Colors.red,
    Colors.lightGreenAccent,
    Colors.green,
    Colors.brown,
    Colors.pinkAccent,
    Colors.orange,
    Colors.amber,
    Colors.white24
  ];

  @override
  Widget build(BuildContext context) {
    double Screen_hight = MediaQuery.of(context).size.height;
    double status_bar = MediaQuery.of(context).padding.top;
    double appbar_hight = kToolbarHeight;
    return Scaffold(
      appBar: AppBar(
        title: Text("Love shayari"),
      ),
      body: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        barrierColor: Colors.transparent,
                        context: context,
                        builder: (context) {
                          return Container(
                            height:
                                Screen_hight - status_bar - appbar_hight - 10,
                            child: GridView.builder(
                              itemCount: a.length - 1,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    pos1 = index;
                                    pos2 = index + 1;
                                    color_status = true;
                                    Navigator.pop(context);
                                    setState(() {});
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            colors: [a[index], a[index + 1]])),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      );
                    },
                    icon: Icon(Icons.restart_alt_outlined)),
                Text(
                  "${widget.index + 1}/${widget.ti.length}",
                  style: TextStyle(fontSize: 30),
                ),
                IconButton(
                    onPressed: () {
                      color_status = true;
                      a.shuffle();
                      setState(() {});
                    },
                    icon: Icon(Icons.restart_alt_outlined)),
              ],
            ),
          ),
          Expanded(
            flex: 6,
            child: PageView.builder(
              onPageChanged: (value) {
                widget.index = value;
                setState(() {});
              },
              controller: controller,
              itemCount: widget.ti.length,
              // controller: PageController(initialPage: widget.index),
              itemBuilder: (context, index) {
                return Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: (color_status == false) ? Colors.grey : null,
                      gradient: (color_status == true)
                          ? LinearGradient(colors: [a[pos1], a[pos2]])
                          : null),
                  child: Text("${widget.ti[index]}"),
                );
              },
            ),
          ),
          Expanded(child: Text("")),
          SizedBox(
            height: 150,
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.lightBlue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: () {
                        Clipboard.setData(
                            ClipboardData(text: "${widget.ti[widget.index]}"));
                      },
                      icon: Icon(Icons.copy)),
                  IconButton(
                      onPressed: () {
                        if (widget.index != 0) {
                          widget.index--;
                          controller!.jumpToPage(widget.index);
                          setState(() {});
                        }
                      },
                      icon: Icon(Icons.arrow_back_ios_sharp)),
                  IconButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return fourth(widget.ti, widget.index);
                          },
                        ));
                      },
                      icon: Icon(Icons.edit)),
                  IconButton(
                      onPressed: () {
                        if (widget.index + 1 < widget.ti.length) {
                          widget.index++;
                          controller!.jumpToPage(widget.index);
                          setState(() {});
                        }
                      },
                      icon: Icon(Icons.arrow_forward_ios_sharp)),
                  IconButton(
                      onPressed: () {
                        Share.share("${widget.ti[widget.index]}");
                      },
                      icon: Icon(Icons.share)),
                ],
              ),
            ),
          ),
          Expanded(child: Text("")),
        ],
      ),
    );
  }
}

import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:demo1/shphoto.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

class fourth extends StatefulWidget {
  List l;
  int index;

  fourth(this.l, this.index);

  @override
  State<fourth> createState() => _fourthState();
}

class _fourthState extends State<fourth> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    perm();
  }

  int pos1 = 0, pos2 = 1, epos = 0;
  Color background = Colors.grey;
  Color font = Colors.black;
  bool color_status = true;
  bool text_color = false;
  bool font_status = false;
  double fs = 10;
  List emoji = [
    "😀 😃 😄 😁 😆 😅",
    "😂 🤣 🥲 🥹 ☺️ 😊",
    "😍 🥰 😘 😗 😙 😚",
    " 😋 😛 😝 😜 🤪 🤨",
    "😏 😒 😞 😔 😟 😕",
    "😑😁⛹‍♀⛹🏿🧘",
    "🏼🏄🏻‍♀🏆🏵🎲",
    "🎯🎳🎮🎰🧩😍",
    "🥰😘😗😙😚😛",
    "😜😜🤪🤨🧐🧐",
    "🤓😎🥸🤩🥳😏",
    "😞😒😔😟😕🙁",
    "😣😖😫😩🥺😢",
    "😤😠😡🤬🤯😳",
    "🥵🥶😶‍🌫😨😱",
    "😰😥😓🤗🤔🫣",
    "🤭🫢🫡🤫🫠🤥",
    "🫥😐🫤😑😲🥱",
    "😴🤤😮‍💨😵",
  ];
  WidgetsToImageController controller = WidgetsToImageController();
  Uint8List? bytes;
  perm() async {
    var status = await Permission.storage.status;
    if(status.isDenied){
      Map<Permission, PermissionStatus> statuses = await [
        Permission.location,
        Permission.storage,
      ].request();
    }
    print(status);
  }


  @override
  Widget build(BuildContext context) {
    double Screen_hight = MediaQuery.of(context).size.height;
    double status_bar = MediaQuery.of(context).padding.top;
    double appbar_hight = kToolbarHeight;
    return Scaffold(
      appBar: AppBar(
        title: Text("write shayari"),
      ),
      body: Column(
        children: [
          Expanded(flex: 2,
            child: WidgetsToImage(
              child: Container(
              height: 300,
              width: double.infinity,
              margin: EdgeInsets.all(15),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: (color_status == true) ? background : null,
                  gradient: (color_status == false) ? LinearGradient(colors: [photo.a[pos1], photo.a[pos2]]) : null),
              child: Text("${emoji[epos]}\n${widget.l[widget.index]}\n${emoji[epos]}",
                style: TextStyle(
                  fontFamily: (font_status == true) ? photo.f[pos1] : null,
                  color:font,
                  fontSize: fs,
                ),
              ),
            ), controller: controller,),


          ),

    //     ----------------------------------------------------------------------------------

          Expanded(
            child: Container(
              height: 150,
              width: double.infinity,
              margin: EdgeInsets.all(15),
              color: Colors.brown,
              child: Column(
                children: [
                  Row(
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
                            height: Screen_hight -
                                status_bar -
                                appbar_hight -
                                20,
                            child: GridView.builder(
                              itemCount: photo.a.length - 1,
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
                                    color_status = false;
                                    Navigator.pop(context);
                                    setState(() {});
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(colors: [
                                      photo.a[index],
                                      photo.a[index + 1]
                                    ])),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      );
                    },
                    icon: Icon(Icons.add_circle_outline),
                  ),
                  IconButton(
                      onPressed: () {
                        color_status = false;
                        photo.a.shuffle();
                        setState(() {});
                      },
                      icon: Icon(Icons.restart_alt_outlined)),
                    ],
                  ),

       //---------------------------------------back ground-----------------------------------

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            showModalBottomSheet(
                              isScrollControlled: true, isDismissible: false,
                              //       barrierColor: Colors.transparent,
                              context: context,
                              builder: (context) {
                                return Container(
                                    height: 100,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Expanded(
                                          child: GridView.builder(
                                            itemCount: photo.a.length,
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 8,
                                                    mainAxisSpacing: 2,
                                                    crossAxisSpacing: 2),
                                            itemBuilder: (context, index) {
                                              return InkWell(
                                                onTap: () {
                                                  color_status = true;
                                                  background = photo.a[index];
                                                  setState(() {});
                                                },
                                                child: Container(
                                                  color: photo.a[index],
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            icon: Icon(Icons.close),
                                            color: Colors.red)
                                      ],
                                    ));
                              },
                            );
                          },
                          child: Text("Background"),
                        ),
                      ),

       //     ----------------------------------Text color-----------------------------------------------

                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            showModalBottomSheet(
                              isScrollControlled: true, isDismissible: false,
                              // barrierColor: Colors.transparent,
                              context: context,
                              builder: (context) {
                                return Container(
                                    height: 100,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Expanded(
                                          child: GridView.builder(
                                            itemCount: photo.a.length,
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 8,
                                                    mainAxisSpacing: 2,
                                                    crossAxisSpacing: 2),
                                            itemBuilder: (context, index) {
                                              return InkWell(
                                                onTap: () {
                                                  font=photo.a[index];
                                                  setState(() {});
                                                },
                                                child: Container(
                                                  color: photo.a[index],
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            icon: Icon(Icons.close),
                                            color: Colors.red)
                                      ],)
                                );
                              },
                            );
                          },
                          child: Text("Text color"),
                        ),
                      ),

       //     ----------------------------------share-----------------------------------------------

                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            bytes = await controller.capture();

                             //var path
                            var path = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS)+"/demo";
                            Directory dir =Directory(path);
                            if(!await dir.exists()){
                            dir.create();
                            }
                            // create img
                            String img="${Random().nextInt(1000)}myimg.jpg";

                            File file=File("${dir.path}/${img}");
                            file.writeAsBytes(bytes!);
                            Share.shareFiles(["${file.path}"],text: " ");
                          },
                          child: Text("share"),
                        ),
                      )
                    ],
                  ),

                  //     -------------------next coloum--------------------------------

                  //     -------------------font--------------------------------

                  SizedBox(
                    height: 50 - 17,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                            onPressed: () {
                              showModalBottomSheet(
                                isScrollControlled: true,
                                isDismissible: false,
                                barrierColor: Colors.transparent,
                                context: context,
                                builder: (context) {
                                  return Container(
                                    height: 100,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              height: 25,
                                              width: 50,
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Icon(Icons.close,
                                                    color: Colors.red),
                                              ),
                                            ),
                                          ],),
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: ListView.builder(
                                                  itemCount: photo.f.length,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return InkWell(
                                                      onTap: () {
                                                        pos1 = index;
                                                        font_status = true;
                                                        Navigator.pop(context);
                                                        setState(() {});
                                                      },
                                                      child: Container(
                                                        width: 70,
                                                        margin:
                                                            EdgeInsets.all(10),
                                                        alignment:
                                                            Alignment.center,
                                                        color:
                                                            Colors.pinkAccent,
                                                        child: Text(
                                                          "शायरी",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 15,
                                                              fontFamily: photo
                                                                  .f[index]),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],),
                                        ),
                                      ],),
                                  );
                                },
                              );
                            },
                            child: Text("Font")),
                      ),

                      //     -------------------emoje--------------------------------

                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                    isScrollControlled: true,
                                    isDismissible: false,
                                    context: context,
                                    builder: (context) {
                                      return Container(
                                        height: 100,
                                        color: Colors.black26,
                                        child: Column(children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                height: 25,
                                                width: 50,
                                                child: InkWell(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Icon(Icons.close, color: Colors.red),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: ListView.separated(
                                                      itemBuilder:
                                                          (context, index) {
                                                        return InkWell(
                                                            onTap: () {
                                                              epos = index;
                                                              setState(() {});
                                                            },
                                                            child: Text(
                                                                "${emoji[index]}",textAlign: TextAlign.center));
                                                      },
                                                      separatorBuilder:
                                                          (context, index) {
                                                        return Divider();
                                                      },
                                                      itemCount: emoji.length),
                                                ),
                                              ],),
                                          ),
                                        ]),
                                      );
                                    },
                                  );
                                },
                                child: Text("emoji"),
                              ),
                            ),
                          ],),
                      ),

                      //     -------------------font size--------------------------------

                     Expanded(
                       child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
                         Expanded(
                           child: ElevatedButton(
                             onPressed: () {
                               showModalBottomSheet(
                                 isScrollControlled: true,
                                 isDismissible: false,
                                 context: context,
                                 builder: (context) {
                                   return ConstrainedBox(constraints: BoxConstraints(maxWidth: 70),
                                    child: Container(
                                         height: Screen_hight - status_bar - appbar_hight - 350,
                                         color: Colors.white,
                                         child:
                                         Expanded(
                                           child: Row(
                                             mainAxisAlignment:
                                             MainAxisAlignment.center,
                                             children: [
                                               Expanded(
                                                 child: StatefulBuilder(
                                                   builder: (context, setState1) {
                                                     return Slider(
                                                       min: 10,
                                                       max: 30,
                                                       value: fs,
                                                       onChanged: (value) {
                                                         fs = value;
                                                         setState(() {});
                                                         setState1(() {});
                                                       },
                                                     );
                                                   },
                                                 ),
                                               ),
                                               IconButton(
                                                   onPressed: () {
                                                     Navigator.pop(context);
                                                   },
                                                   icon: Icon(Icons.close),color: Colors.red),
                                             ],),
                                         ),
                                       ),
                                   );
                                 },
                               );
                             },
                             child: Text("Font size"),
                           ),
                         ),
                       ],),
                     ),
                    ],),
                ],),
            ),
          ),
        ],),
    );
  }
}

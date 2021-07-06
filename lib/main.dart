import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'services/world_time.dart';
import 'dart:async';

String my_api_key = "agJlAhrvkT6EqnrOGs7XLRnIidN8r4ctUHOP06rq";
String robotsName = "curiosity";
String sol = "100";
int page = 1;
String camera = "&camera=fhaz";
String earthDate = "2015-09-09";
bool earthDayModeOn = true;

Future<int> fetchAlbumLength() async {
  if (earthDayModeOn) {
    String adress = "https://api.nasa.gov/mars-photos/api/v1/rovers/" +
        robotsName +
        "/photos?earth_date=" +
        earthDate +
        "&camera=" +
        camera +
        "&page=" +
        page.toString() +
        "&api_key=" +
        my_api_key;
    final response = await http.get(Uri.parse(adress));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      Album f = Album.fromJson(jsonDecode(response.body));
      return f.photos.length;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  } else {
    String adress = "https://api.nasa.gov/mars-photos/api/v1/rovers/" +
        robotsName +
        "/photos?sol=" +
        sol +
        "&camera=" +
        camera +
        "&page=" +
        page.toString() +
        "&api_key=" +
        my_api_key;
    final response = await http.get(Uri.parse(adress));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      Album f = Album.fromJson(jsonDecode(response.body));
      return f.photos.length;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}

Future<List> getUrlList() async {
  print("robot is " + robotsName);
  if (earthDayModeOn) {
    String adress = "https://api.nasa.gov/mars-photos/api/v1/rovers/" +
        robotsName +
        "/photos?earth_date=" +
        earthDate +
        "&camera=" +
        camera +
        "&page=" +
        page.toString() +
        "&api_key=" +
        my_api_key;
    final response = await http.get(Uri.parse(adress));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      Album f = Album.fromJson(jsonDecode(response.body));
      // print("&&&&&&&&&&&&&&&&&&&--------------------------");

      //print(tmp);

      return f.photos;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  } else {
    String adress = "https://api.nasa.gov/mars-photos/api/v1/rovers/" +
        robotsName +
        "/photos?sol=" +
        sol +
        "&camera=" +
        camera +
        "&page=" +
        page.toString() +
        "&api_key=" +
        my_api_key;
    final response = await http.get(Uri.parse(adress));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      Album f = Album.fromJson(jsonDecode(response.body));
      // print("&&&&&&&&&&&&&&&&&&&--------------------------");

      //print(tmp);

      return f.photos;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}

// Future<Map> getUrlList2(int i) async {
//   print("robot is " + robotsName);
//   String adress = "https://api.nasa.gov/mars-photos/api/v1/rovers/" +
//       robotsName +
//       "/photos?sol=" +
//       sol +
//       "&camera=" +
//       camera +
//       "&page=" +
//       page.toString() +
//       "&api_key=" +
//       my_api_key;
//   final response = await http.get(Uri.parse(adress));

//   if (response.statusCode == 200) {
//     // If the server did return a 200 OK response,
//     // then parse the JSON.
//     Album f = Album.fromJson(jsonDecode(response.body));
//     // print("&&&&&&&&&&&&&&&&&&&--------------------------");
//     Map tmp = f.photos[0];
//     //print(tmp);

//     return f.photos[i];
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load album');
//   }
// }

class Album {
  final List photos;
  Album({
    required this.photos,
  });
  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      photos: json['photos'],
    );
  }
}

void main() => runApp(const MyApp());

/// This is the main application widget.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int lengthOfPage = 0;
  List my_list = [];
  List<String> url_List_of_this_page = [];
  List<String> dates_of_images = [];
  List<String> Names_of_cameras_of_images = [];

  @override
  void initState() {
    super.initState();

    fetchAlbumLength().then((int result) {
      setState(() {
        lengthOfPage = result;
        url_List_of_this_page = [];
        dates_of_images = [];
        Names_of_cameras_of_images = [];
      });
    });
    getUrlList().then((List result) {
      setState(() {
        my_list = result;
        url_List_of_this_page = [];
        dates_of_images = [];
        Names_of_cameras_of_images = [];
      });
    });
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (_selectedIndex == 0) {
      setState(() {
        robotsName = 'curiosity';
      });
      fetchAlbumLength().then((int result) {
        setState(() {
          lengthOfPage = result;
        });
      });
      getUrlList().then((List result) {
        setState(() {
          my_list = result;
          url_List_of_this_page = [];
          dates_of_images = [];
          Names_of_cameras_of_images = [];
        });
      });
      print("length: " + lengthOfPage.toString());
    } else if (_selectedIndex == 1) {
      setState(() {
        robotsName = 'opportunity';
      });

      fetchAlbumLength().then((int result) {
        setState(() {
          lengthOfPage = result;
        });
      });
      getUrlList().then((List result) {
        setState(() {
          my_list = result;
          url_List_of_this_page = [];
          dates_of_images = [];
          Names_of_cameras_of_images = [];
        });
      });
      print("length: " + lengthOfPage.toString());
    } else if (_selectedIndex == 2) {
      setState(() {
        robotsName = 'spirit';
      });
      fetchAlbumLength().then((int result) {
        setState(() {
          lengthOfPage = result;
        });
      });
      getUrlList().then((List result) {
        setState(() {
          my_list = result;
          url_List_of_this_page = [];
          dates_of_images = [];
          Names_of_cameras_of_images = [];
        });
      });
      print("length: " + lengthOfPage.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mustafa Can Aydin\'s flutter app'),
      ),
      body: GridView.custom(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 1.0,
          crossAxisSpacing: 1.0,
        ),
        childrenDelegate: SliverChildListDelegate(_buildItems()),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.camera),
            label: 'Curiosity',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.adb_sharp),
            label: 'Opportunity',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.ac_unit),
            label: 'Spirit',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }

  List<Widget> _buildItems() {
    List<Widget> listItems = [];
    int count = 0;
    setState(() {
      count = lengthOfPage;
    });
    count = lengthOfPage;

    print("count is " + count.toString());
    if (earthDayModeOn) {
      listItems.add(Card(
          margin: EdgeInsets.all(1.0),
          color: Colors.cyan[50],
          elevation: 0,
          child: Center(
            child: Column(
              children: <Widget>[
                TextField(
                  onChanged: (value) => _runFilterEarthDate(value),
                  decoration: InputDecoration(
                      labelText: 'Enter earth date in international format: ',
                      suffixIcon: Icon(Icons.search_rounded)),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.cyan[800],
                  ),
                  onPressed: changeToSolButton,
                  child: Text('Change to sol '),
                ),
              ],
            ),
          )));
    } else {
      listItems.add(Card(
          margin: EdgeInsets.all(1.0),
          color: Colors.cyan,
          elevation: 0,
          child: Center(
            child: Column(
              children: <Widget>[
                TextField(
                  onChanged: (value) => _runFilter(value),
                  decoration: InputDecoration(
                      labelText: 'Enter sol value: ',
                      suffixIcon: Icon(Icons.search)),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.yellowAccent,
                  ),
                  onPressed: changeToEarthDateButton,
                  child: Text('Change to earth date format'),
                ),
              ],
            ),
          )));
    }

    if (robotsName == "curiosity") {
      listItems.add(Card(
          margin: EdgeInsets.all(1.0),
          color: Colors.lightBlue,
          elevation: 0,
          child: Center(
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(Colors.purple[900]),
                        side: MaterialStateProperty.all(
                            BorderSide(width: 1, color: Colors.red)),
                      ),
                      onPressed: fhazbutton,
                      child: Text('fhaz'),
                    ),
                    TextButton(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(Colors.blueGrey[900]),
                        side: MaterialStateProperty.all(
                            BorderSide(width: 1, color: Colors.red)),
                      ),
                      onPressed: rhazbutton,
                      child: Text('rhaz'),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(Colors.pink[900]),
                        side: MaterialStateProperty.all(
                            BorderSide(width: 1, color: Colors.red)),
                      ),
                      onPressed: mastbutton,
                      child: Text('mast'),
                    ),
                    TextButton(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(Colors.purple[600]),
                        side: MaterialStateProperty.all(
                            BorderSide(width: 1, color: Colors.red)),
                      ),
                      onPressed: chemcambutton,
                      child: Text('chemcam'),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(Colors.yellowAccent),
                        side: MaterialStateProperty.all(
                            BorderSide(width: 1, color: Colors.red)),
                      ),
                      onPressed: mahlibutton,
                      child: Text(
                        'mahli',
                      ),
                    ),
                    TextButton(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(Colors.cyan[900]),
                        side: MaterialStateProperty.all(
                            BorderSide(width: 1, color: Colors.red)),
                      ),
                      onPressed: mardibutton,
                      child: Text(
                        'mardi',
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(Colors.amber[900]),
                        side: MaterialStateProperty.all(
                            BorderSide(width: 1, color: Colors.red)),
                      ),
                      onPressed: navcambutton,
                      child: Text(
                        'navcam',
                      ),
                    ),
                  ],
                ),
              ]))));
    } else {
      listItems.add(Card(
          margin: EdgeInsets.all(1.0),
          color: Colors.lightBlue,
          elevation: 0,
          child: Center(
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(Colors.purple[900]),
                        side: MaterialStateProperty.all(
                            BorderSide(width: 1, color: Colors.red)),
                      ),
                      onPressed: fhazbutton,
                      child: Text('fhaz'),
                    ),
                    TextButton(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(Colors.blue[900]),
                        side: MaterialStateProperty.all(
                            BorderSide(width: 1, color: Colors.red)),
                      ),
                      onPressed: rhazbutton,
                      child: Text('rhaz'),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(Colors.yellow[900]),
                        side: MaterialStateProperty.all(
                            BorderSide(width: 1, color: Colors.red)),
                      ),
                      onPressed: navcambutton,
                      child: Text('navcam'),
                    ),
                    TextButton(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(Colors.red[900]),
                        side: MaterialStateProperty.all(
                            BorderSide(width: 1, color: Colors.red)),
                      ),
                      onPressed: pancambutton,
                      child: Text('pancam'),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(Colors.green[900]),
                        side: MaterialStateProperty.all(
                            BorderSide(width: 1, color: Colors.red)),
                      ),
                      onPressed: minitesbutton,
                      child: Text(
                        'minites',
                      ),
                    ),
                  ],
                ),
              ]))));
    }

    // for (int i = 0; i < count; i++) {
    //   listItems.add(
    //     Card(
    //       margin: EdgeInsets.all(1.0),
    //       color: Colors.amber[50],
    //       elevation: 0,
    //       child: Center(
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //           crossAxisAlignment: CrossAxisAlignment.center,
    //           children: <Widget>[
    //             FutureBuilder<Map>(
    //               future: getUrlList2(i),
    //               builder: (context, snapshot) {
    //                 if (snapshot.hasData) {
    //                   // print("here---------------------------->>>>>>>>>>>");
    //                   // print(snapshot.data!);
    //                   // print((snapshot.data!)['earth_date']);

    //                   return Center(
    //                     child: Column(
    //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                       children: [
    //                         Center(
    //                             child: Text("Date taken: " +
    //                                 snapshot.data!['earth_date'])),
    //                         Center(
    //                             child: Text(
    //                                 snapshot.data!['camera']['full_name'])),
    //                         SizedBox(
    //                             width: 140,
    //                             child: Image.network(
    //                                 (snapshot.data!)['img_src'],
    //                                 fit: BoxFit.fitWidth)),
    //                       ],
    //                     ),
    //                   );
    //                 } else if (snapshot.hasError) {
    //                   return Text("hey   ${snapshot.error}");
    //                 }
    //                 // By default, show a loading spinner.
    //                 return CircularProgressIndicator();
    //               },
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   );
    // }

    url_List_of_this_page = [];
    dates_of_images = [];
    Names_of_cameras_of_images = [];
    setState(() {
      for (int i = 0; i < my_list.length; i++) {
        var temp = my_list[i];

        Map myTempMap = temp;
        //String imgUrl = myTempMap['img_url'];
        // print("VERY IMPORTANT ::: :::: ::: ::: ");
        // print(myTempMap['img_src']);
        url_List_of_this_page.add(myTempMap['img_src']);
        Names_of_cameras_of_images.add(myTempMap['camera']['full_name']);
        dates_of_images.add(myTempMap['earth_date']);
      }
    });

    for (int i = 0; i < count; i++) {
      listItems.add(
        Card(
          margin: EdgeInsets.all(1.0),
          color: Colors.amber[50],
          elevation: 0,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Date taken: " + dates_of_images[i]),
                      SizedBox(
                        width: 140,
                        child: Image.network(
                          url_List_of_this_page[i],
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      Text("By " + Names_of_cameras_of_images[i]),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }

    listItems.add(Card(
        margin: EdgeInsets.all(1.0),
        color: Colors.purple[50],
        elevation: 3.0,
        child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
              TextButton.icon(
                icon: Icon(Icons.next_plan),
                label: Text('Next Page'),
                onPressed: nextpagebutton,
                style: ButtonStyle(
                    side: MaterialStateProperty.all(
                        BorderSide(width: 5, color: Colors.purple)),
                    foregroundColor:
                        MaterialStateProperty.all(Colors.purple[900]),
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(vertical: 8, horizontal: 30)),
                    textStyle:
                        MaterialStateProperty.all(TextStyle(fontSize: 18))),
              )
            ]))));
    return listItems;
  }

  void nextpagebutton() {
    setState(() {
      page++;
    });
    fetchAlbumLength().then((int result) {
      setState(() {
        lengthOfPage = result;
        url_List_of_this_page = [];
        dates_of_images = [];
        Names_of_cameras_of_images = [];
      });
    });
    getUrlList().then((List result) {
      setState(() {
        my_list = result;
        url_List_of_this_page = [];
        dates_of_images = [];
        Names_of_cameras_of_images = [];
      });
    });

    print(page);
  }

  void changeToEarthDateButton() {
    setState(() {
      earthDayModeOn = true;
    });
    getUrlList().then((List result) {
      setState(() {
        my_list = result;
        url_List_of_this_page = [];
        dates_of_images = [];
        Names_of_cameras_of_images = [];
      });
    });
    fetchAlbumLength().then((int result) {
      setState(() {
        lengthOfPage = result;
        url_List_of_this_page = [];
        dates_of_images = [];
        Names_of_cameras_of_images = [];
      });
    });
    getUrlList().then((List result) {
      setState(() {
        my_list = result;
        url_List_of_this_page = [];
        dates_of_images = [];
        Names_of_cameras_of_images = [];
      });
    });

    print(earthDayModeOn);
  }

  void changeToSolButton() {
    setState(() {
      earthDayModeOn = false;
    });
    fetchAlbumLength().then((int result) {
      setState(() {
        lengthOfPage = result;
        url_List_of_this_page = [];
        dates_of_images = [];
        Names_of_cameras_of_images = [];
      });
    });
    getUrlList().then((List result) {
      setState(() {
        my_list = result;
        url_List_of_this_page = [];
        dates_of_images = [];
        Names_of_cameras_of_images = [];
      });
    });

    print(earthDayModeOn);
  }

  void fhazbutton() {
    setState(() {
      camera = "&camera=fhaz";
    });
    fetchAlbumLength().then((int result) {
      setState(() {
        lengthOfPage = result;
        url_List_of_this_page = [];
        dates_of_images = [];
        Names_of_cameras_of_images = [];
      });
    });
    getUrlList().then((List result) {
      setState(() {
        my_list = result;
        url_List_of_this_page = [];
        dates_of_images = [];
        Names_of_cameras_of_images = [];
      });
    });

    print(camera);
  }

  void rhazbutton() {
    setState(() {
      camera = "&camera=rhaz";
    });
    fetchAlbumLength().then((int result) {
      setState(() {
        lengthOfPage = result;
        url_List_of_this_page = [];
        dates_of_images = [];
        Names_of_cameras_of_images = [];
      });
    });
    getUrlList().then((List result) {
      setState(() {
        my_list = result;
        url_List_of_this_page = [];
        dates_of_images = [];
        Names_of_cameras_of_images = [];
      });
    });

    print(camera);
  }

  void mastbutton() {
    setState(() {
      camera = "&camera=mast";
    });
    fetchAlbumLength().then((int result) {
      setState(() {
        lengthOfPage = result;
        url_List_of_this_page = [];
        dates_of_images = [];
        Names_of_cameras_of_images = [];
      });
    });
    getUrlList().then((List result) {
      setState(() {
        my_list = result;
        url_List_of_this_page = [];
        dates_of_images = [];
        Names_of_cameras_of_images = [];
      });
    });

    print(camera);
  }

  void chemcambutton() {
    setState(() {
      camera = "&camera=chemcam";
    });
    fetchAlbumLength().then((int result) {
      setState(() {
        lengthOfPage = result;
        url_List_of_this_page = [];
        dates_of_images = [];
        Names_of_cameras_of_images = [];
      });
    });
    getUrlList().then((List result) {
      setState(() {
        my_list = result;
        url_List_of_this_page = [];
        dates_of_images = [];
        Names_of_cameras_of_images = [];
      });
    });

    print(camera);
  }

  void mahlibutton() {
    setState(() {
      camera = "&camera=mahli";
    });
    fetchAlbumLength().then((int result) {
      setState(() {
        lengthOfPage = result;
        url_List_of_this_page = [];
        dates_of_images = [];
        Names_of_cameras_of_images = [];
      });
    });
    getUrlList().then((List result) {
      setState(() {
        my_list = result;
        url_List_of_this_page = [];
        dates_of_images = [];
        Names_of_cameras_of_images = [];
      });
    });

    print(camera);
  }

  void mardibutton() {
    setState(() {
      camera = "&camera=mardi";
    });
    fetchAlbumLength().then((int result) {
      setState(() {
        lengthOfPage = result;
        url_List_of_this_page = [];
        dates_of_images = [];
        Names_of_cameras_of_images = [];
      });
    });
    getUrlList().then((List result) {
      setState(() {
        my_list = result;
        url_List_of_this_page = [];
        dates_of_images = [];
        Names_of_cameras_of_images = [];
      });
    });

    print(camera);
  }

  void pancambutton() {
    setState(() {
      camera = "&camera=pancam";
    });
    fetchAlbumLength().then((int result) {
      setState(() {
        lengthOfPage = result;
        url_List_of_this_page = [];
        dates_of_images = [];
        Names_of_cameras_of_images = [];
      });
    });
    getUrlList().then((List result) {
      setState(() {
        my_list = result;
        url_List_of_this_page = [];
        dates_of_images = [];
        Names_of_cameras_of_images = [];
      });
    });

    print(camera);
  }

  void navcambutton() {
    setState(() {
      camera = "&camera=navcam";
    });
    fetchAlbumLength().then((int result) {
      setState(() {
        lengthOfPage = result;
        url_List_of_this_page = [];
        dates_of_images = [];
        Names_of_cameras_of_images = [];
      });
    });
    getUrlList().then((List result) {
      setState(() {
        my_list = result;
        url_List_of_this_page = [];
        dates_of_images = [];
        Names_of_cameras_of_images = [];
      });
    });

    print(camera);
  }

  void minitesbutton() {
    setState(() {
      camera = "&camera=minites";
    });
    fetchAlbumLength().then((int result) {
      setState(() {
        lengthOfPage = result;
        url_List_of_this_page = [];
        dates_of_images = [];
        Names_of_cameras_of_images = [];
      });
    });
    getUrlList().then((List result) {
      setState(() {
        my_list = result;
        url_List_of_this_page = [];
        dates_of_images = [];
        Names_of_cameras_of_images = [];
      });
    });

    print(camera);
  }

  //----------------------------------------------------------------------------------

  void _runFilter(String enteredKeyword) {
    String results = "";
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = "1000";
    } else {
      results = enteredKeyword;

      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      sol = results;
    });
    fetchAlbumLength().then((int result) {
      setState(() {
        lengthOfPage = result;
        url_List_of_this_page = [];
        dates_of_images = [];
        Names_of_cameras_of_images = [];
      });
    });
    getUrlList().then((List result) {
      setState(() {
        my_list = result;
        url_List_of_this_page = [];
        dates_of_images = [];
        Names_of_cameras_of_images = [];
      });
    });
  }

  void _runFilterEarthDate(String enteredKeyword) {
    String results = "";
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = "2015-09-09";
    } else {
      results = enteredKeyword;

      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      earthDate = results;
    });
    getUrlList().then((List result) {
      setState(() {
        my_list = result;
        url_List_of_this_page = [];
        dates_of_images = [];
        Names_of_cameras_of_images = [];
      });
    });
    fetchAlbumLength().then((int result) {
      setState(() {
        lengthOfPage = result;
        url_List_of_this_page = [];
        dates_of_images = [];
        Names_of_cameras_of_images = [];
      });
    });
    getUrlList().then((List result) {
      setState(() {
        my_list = result;
        url_List_of_this_page = [];
        dates_of_images = [];
        Names_of_cameras_of_images = [];
      });
    });
  }
}

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'services/world_time.dart';
import 'dart:async';

String my_api_key = "skvxTUxep5E65T0ZwzEWC3MzvnDAruvN4uNqDeP4";
String robotsName = "curiosity";
String sol = "100";
int page = 1;
String camera = "&camera=mast";

Future<Album> fetchAlbum() async {
  String adress = "https://api.nasa.gov/mars-photos/api/v1/rovers/" +
      robotsName +
      "/photos?sol=" +
      sol +
      camera +
      "&page=" +
      page.toString() +
      "&api_key=" +
      my_api_key;
  final response = await http.get(Uri.parse(adress));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<int> fetchAlbumLength() async {
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

Future<Map> getUrlList2(int i) async {
  print("robot is" + robotsName);

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
    Map tmp = f.photos[0];
    print(tmp);

    return f.photos[i];
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<List> getUrlList() async {
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
    Album f = Album.fromJson(jsonDecode(response.body));
    return f.photos;
  } else {
    throw Exception('Failed to load album');
  }
}

class Album {
  final List photos;
  final String url1;

  final String title;

  Album({
    required this.photos,
    required this.url1,
    required this.title,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      photos: json['photos'],
      url1: json['photos'][0]['img_src'],
      title: json['photos'][0]['camera']['full_name'],
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
  late Future<Album> futureAlbum;
  int lengthOfPage = 0;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();

    fetchAlbumLength().then((int result) {
      setState(() {
        lengthOfPage = result;
      });
    });
  }

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

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
      print(lengthOfPage);
    } else if (_selectedIndex == 1) {
      setState(() {
        robotsName = 'opportunity';
      });

      fetchAlbumLength().then((int result) {
        setState(() {
          lengthOfPage = result;
        });
      });
      print(lengthOfPage);
    } else if (_selectedIndex == 2) {
      setState(() {
        robotsName = 'spirit';
      });
      fetchAlbumLength().then((int result) {
        setState(() {
          lengthOfPage = result;
        });
      });
      print(lengthOfPage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mustafa Can Aydin\'s flutter app'),
      ),
      body: GridView.custom(
        //childAspectRatio: 9/16,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 15.0,
          crossAxisSpacing: 10.0,
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
    // fetchAlbumLength().then((int result) {
    //   setState(() {
    //     lengthOfPage = result;
    //   });
    // });
    int count = lengthOfPage;

    print(count);
    listItems.add(Card(
        color: Colors.cyan,
        elevation: 0,
        child: Center(
          child: Column(
            children: <Widget>[
              TextField(
                onChanged: (value) => _runFilter(value),
                decoration: InputDecoration(
                    labelText: 'Search', suffixIcon: Icon(Icons.search)),
              ),
            ],
          ),
        )));

    listItems.add(Card(
        color: Colors.lightBlue,
        elevation: 0,
        child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.deepOrange,
                ),
                onPressed: fhazbutton,
                child: Text('fhaz'),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.redAccent,
                ),
                onPressed: rhazbutton,
                child: Text('rhaz'),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.red,
                ),
                onPressed: mastbutton,
                child: Text('mast'),
              ),
            ]))));

    listItems.add(Card(
        color: Colors.lightBlue,
        elevation: 0,
        child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.deepOrangeAccent,
                ),
                onPressed: chemcambutton,
                child: Text('chemcam'),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.red[800],
                ),
                onPressed: mahlibutton,
                child: Text('mahli'),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.deepPurple,
                ),
                onPressed: navcambutton,
                child: Text('navcam'),
              ),
            ]))));
    listItems.add(Card(
        color: Colors.lightBlue,
        elevation: 0,
        child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.purple,
                ),
                onPressed: pancambutton,
                child: Text('pancam'),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.pink,
                ),
                onPressed: minitesbutton,
                child: Text('minites'),
              ),
            ]))));

    for (int i = 0; i < count; i++) {
      listItems.add(
        Card(
          color: Colors.amber,
          elevation: 5.0,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // FutureBuilder<Album>(
                //   future: futureAlbum,
                //   builder: (context, snapshot) {

                //     if (snapshot.hasData) {
                //       return  Expanded(
                //      child: SizedBox(
                //          width: 300,
                //          child: Image.network(snapshot.data!.url1, fit: BoxFit.fitWidth)));
                //     } else if (snapshot.hasError) {
                //       return Text("${snapshot.error}");
                //     }
                //     // By default, show a loading spinner.
                //     return CircularProgressIndicator();
                //   },
                // ),
                FutureBuilder<Map>(
                  future: getUrlList2(i),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      print("here---------------------------->>>>>>>>>>>");
                      print(snapshot.data!);
                      print((snapshot.data!)['earth_date']);
                      return Center(
                        child: Text(snapshot.data!['earth_date']),
                      );
                    } else if (snapshot.hasError) {
                      return Text("hey   ${snapshot.error}");
                    }
                    // By default, show a loading spinner.
                    return CircularProgressIndicator();
                  },
                ),
                FutureBuilder<Map>(
                  future: getUrlList2(i),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      print("here---------------------------->>>>>>>>>>>");
                      print(snapshot.data!);
                      print((snapshot.data!)['img_src']);
                      return Expanded(
                          child: SizedBox(
                              width: 300,
                              child: Image.network((snapshot.data!)['img_src'],
                                  fit: BoxFit.fitWidth)));
                    } else if (snapshot.hasError) {
                      return Text("hey   ${snapshot.error}");
                    }
                    // By default, show a loading spinner.
                    return CircularProgressIndicator();
                  },
                ),
                FutureBuilder<Map>(
                  future: getUrlList2(i),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      print("here---------------------------->>>>>>>>>>>");
                      print(snapshot.data!);
                      print((snapshot.data!)['earth_date']);
                      return Center(
                        child: Text(snapshot.data!['camera']['full_name']),
                      );
                    } else if (snapshot.hasError) {
                      return Text("hey   ${snapshot.error}");
                    }
                    // By default, show a loading spinner.
                    return CircularProgressIndicator();
                  },
                ),

                //             FutureBuilder<List<dynamic>>(
                //   future: getUrlList(),
                //   builder: (context, snapshot) {
                //     print(snapshot.data![i]);
                //     print(snapshot.data!.length);
                //     return ListView.builder(

                //       itemCount: snapshot.data!.length,
                //       itemBuilder: (context, index) {
                //         return Text("snapshot.data![i]"

                //           // child: Column(
                //           //   children: <Widget>[
                //           //     ElevatedButton(
                //           //       onPressed: () async {
                //           //         print((snapshot.data![index]));
                //           //       },
                //           //       child: Text('Get Data'),
                //           //     ),
                //           //   ],
                //           // ),
                //         );
                //       },
                //     );
                //   },
                // )
                // Expanded(
                //     child: SizedBox(
                //         width: 300,
                //         child: Image.network(
                //           _urls[i %
                //               8], // will be i%25 since each page includes 25 images
                //           fit: BoxFit.fitWidth,
                //         )))
              ],
            ),
          ),
        ),
      );
    }

    listItems.add(Card(
        color: Colors.purpleAccent,
        elevation: 3.0,
        child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.blue,
                ),
                onPressed: nextpagebutton,
                child: Text('Next Page'),
              ),
            ]))));

    return listItems;
  }

  void nextpagebutton() {
    setState(() {
      page++;
    });

    print(page);
  }

  void fhazbutton() {
    setState(() {
      camera = "&camera=fhaz";
    });
  }

  void rhazbutton() {
    setState(() {
      camera = "&camera=rhaz";
    });
  }

  void mastbutton() {
    setState(() {
      camera = "&camera=mast";
    });

    print(camera);
  }

  void chemcambutton() {
    setState(() {
      camera = "&camera=chemcam";
    });

    print(camera);
  }

  void mahlibutton() {
    setState(() {
      camera = "&camera=mahli";
    });

    print(camera);
  }

  void mardibutton() {
    setState(() {
      camera = "&camera=mardi";
    });

    print(camera);
  }

  void pancambutton() {
    setState(() {
      camera = "&camera=pancam";
    });

    print(camera);
  }

  void navcambutton() {
    setState(() {
      camera = "&camera=nevcam";
    });

    print(camera);
  }

  void minitesbutton() {
    setState(() {
      camera = "&camera=minites";
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
  }
}

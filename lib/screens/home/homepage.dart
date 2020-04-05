import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:letsgo/screens/Services/auth.dart';
import 'package:letsgo/screens/my_rides.dart';
import 'package:letsgo/screens/profile_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import '../../shared/loading.dart';
import 'package:google_map_polyline/google_map_polyline.dart';
import 'package:flutter/cupertino.dart';


GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: "AIzaSyCvAHxu9Dcell6gHaS6sxlhMrYujWqyRn4");

class MyHomePage extends StatefulWidget {

  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final AuthService _auth = AuthService();
  GoogleMapController mapController;
  TextEditingController locationController = TextEditingController();
  TextEditingController destinationController = TextEditingController();
  static LatLng _initialposition;
  LatLng _destinationLocation;
  int _polylineCount = 1;
  Map<PolylineId, Polyline> _polylines = <PolylineId, Polyline>{};
  GoogleMapPolyline _googleMapPolyline =
      new GoogleMapPolyline(apiKey: "AIzaSyCvAHxu9Dcell6gHaS6sxlhMrYujWqyRn4");
  
  List<List<PatternItem>> patterns = <List<PatternItem>>[
    <PatternItem>[], //line
    <PatternItem>[PatternItem.dash(30.0), PatternItem.gap(20.0)], //dash
    <PatternItem>[PatternItem.dot, PatternItem.gap(10.0)], //dot
    <PatternItem>[
      //dash-dot
      PatternItem.dash(30.0),
      PatternItem.gap(20.0),
      PatternItem.dot,
      PatternItem.gap(20.0)
    ],
  ];

  _getPolylinesWithLocation() async {
    List<LatLng> _coordinates =
        await _googleMapPolyline.getCoordinatesWithLocation(
            origin: _initialposition,
            destination: _destinationLocation,
            mode: RouteMode.driving);

    setState(() {
      //_polylines.clear();
    });
    _addPolyline(_coordinates);
  }

  _addPolyline(List<LatLng> _coordinates) {
    PolylineId id = PolylineId("poly$_polylineCount");
    Polyline polyline = Polyline(
        polylineId: id,
        patterns: patterns[0],
        color: Colors.blueAccent,
        points: _coordinates,
        width: 7,
        startCap: Cap.roundCap,
        endCap: Cap.squareCap,
        onTap: () {});

    setState(() {
      _polylines[id] = polyline;
      _polylineCount++;
    });
  }

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.red,
        title: Text("Let's Go",
        style: TextStyle(color: Colors.white),),
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Logout'),
            onPressed: () async {
              await _auth.signOut();
            },
          )
        ],
      ),



      body: _initialposition == null
        ? Container(
            alignment: Alignment.center,
            child: Center(
              child: Loading(),
            ),
          )
        : Stack(
            children: <Widget>[
              GoogleMap(
                initialCameraPosition:
                    CameraPosition(target: _initialposition, zoom: 15.0),
                onMapCreated: onCreated,
                myLocationEnabled: true,
                mapType: MapType.normal,
                polylines: Set<Polyline>.of(_polylines.values),
              ),

              Positioned(
                top: 10.0,
                right: 15.0,
                left: 15.0,
                child: Container(
                  height: 60.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(1.0, 5.0),
                          blurRadius: 10,
                          spreadRadius: 3)
                    ],
                  ),
                  child: TextField(
                    cursorColor: Colors.black,
                    controller: locationController,
                    onTap: () async {
                      Prediction p = await PlacesAutocomplete.show(context: context, apiKey: "AIzaSyCvAHxu9Dcell6gHaS6sxlhMrYujWqyRn4", mode: Mode.overlay);
                      displayPrediction(p);
                    },
                    decoration: InputDecoration(
                      icon: Container(
                        margin: EdgeInsets.only(left: 20, top: 5),
                        width: 10,
                        height: 10,
                        child: Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                      ),
                      hintText: "Search Hospital",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 15.0, top: 16.0),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 5.0,
                right: 5.0,
                left: 5.0,
                child: ButtonTheme(
                    minWidth: double.infinity,
                    height: 70.0,
                    child: RaisedButton(
                      onPressed: () {
                        _getPolylinesWithLocation();
                      },
                      child: Text(
                        'Book Now',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      textColor: Colors.white,
                      color: Colors.red,
                      splashColor: Colors.deepOrangeAccent,
                    ),
                  ),
              ),
            ],
          ),
      
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('Sanjay Shamnani'),
              accountEmail: Text('sanjay@gmail.com'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage("https://pbs.twimg.com/profile_images/1214214436283568128/KyumFmOO.jpg"),
              ),
              decoration: BoxDecoration(color: Colors.red),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => new ProfilePage()));
              },
            ),
            Divider(),
            ListTile(
                leading: Icon(Icons.restore),
                title: Text('My Rides'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) => new MyRides()));
                }),
          ],
        ),
      ));
  }


  void onCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  void _getUserLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemark = await Geolocator()
        .placemarkFromCoordinates(position.latitude, position.longitude);
    setState(() {
      _initialposition = LatLng(position.latitude, position.longitude);
    });
  }

  Future<Null> displayPrediction(Prediction p) async {
    if (p != null) {
      PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId);
      double lat = detail.result.geometry.location.lat;
      double lng = detail.result.geometry.location.lng;
      locationController.text = p.description;
      _destinationLocation = LatLng(lat, lng);
    }
  }
}
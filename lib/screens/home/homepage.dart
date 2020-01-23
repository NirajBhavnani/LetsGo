import 'package:flutter/material.dart';
import 'package:letsgo/screens/Services/auth.dart';
import 'package:letsgo/screens/about.dart';
import 'package:letsgo/screens/profile.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[50],
      appBar: AppBar(
      backgroundColor: Colors.red[400],
      title: Text("Let's Go"),
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
      body: Map(),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('Sanjay Shamnani'),
              accountEmail: Text('sanjay@gmail.com'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage("http://i.pravatar.cc/300"),
              ),
              decoration: BoxDecoration(color: Colors.black87),
            ),
            ListTile(
              title: Text('Profile'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => new ProfilePage()));
              },
            ),
            Divider(),
            ListTile(
                title: Text('About Us'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) => new AboutPage()));
                }),
          ],
        ),
      ),
    );
  }
}

class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  GoogleMapController mapController;
  static const _initPosition = LatLng(19.07, 72.87);
  LatLng _lastPosition = _initPosition;
  final Set<Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: <Widget>[
          GoogleMap(
            initialCameraPosition: CameraPosition(target: _initPosition , zoom: 10.0),
            onMapCreated: onCreated,
            myLocationEnabled: true,
            mapType: MapType.normal,
            compassEnabled: true,
            markers: _markers,
            onCameraMove: _onCameraMove,
                                  ),
                                  Positioned(top: 40, right: 10, 
                                  child: FloatingActionButton(
                                    onPressed: _onAddMarkerPressed,
                                    tooltip: "Add marker",
                                    backgroundColor: Colors.black,
                                    child: Icon(Icons.add_location, color: Colors.white,),
                                 ),)
                              ],
                                   );
                                 }
                                                            
                                                              void onCreated(GoogleMapController controller) {
                                                                setState(() {
                                                                  mapController = controller;
                                                                });
                                                  }
                                                
                                                  void _onCameraMove(CameraPosition position) {
                                                    setState(() {
                                                      _lastPosition = position.target;
                                                    });
                                      }
                                    
                                      void _onAddMarkerPressed() {
                                        setState(() {
                                          _markers.add(Marker(markerId: MarkerId(_lastPosition.toString()), position: _lastPosition, 
                                          infoWindow: InfoWindow(title: "Remember Here", snippet: "Good Place"),
                                          icon: BitmapDescriptor.defaultMarker ));
                                        });
  }
}
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../utils/core.dart';
import 'package:geolocator/geolocator.dart';
import '../requests/google_maps_requests.dart';
import '../auth/login.dart';
import 'package:firebase_auth/firebase_auth.dart';





class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Map()
    );
  }
}

class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  GoogleMapController mapController;
  GoogleMapServices _googleMapServices = GoogleMapServices();
  TextEditingController locationController = TextEditingController();
  TextEditingController destinationController = TextEditingController();
  static LatLng _initialPosition;
  static LatLng _lastPosition = _initialPosition;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polyLine = {};

  @override
  void initState(){
    super.initState();
    _getUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    return _initialPosition == null? Container(
      alignment: Alignment.center,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    ) : Stack(
      children: <Widget>[
        GoogleMap(initialCameraPosition: CameraPosition(
            target: _initialPosition , zoom: 10),
        onMapCreated: onCreated,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        mapType: MapType.normal,
          compassEnabled: true,
          markers: _markers,
          onCameraMove: _onCameraMove,
          polylines: _polyLine,
        ),

        Positioned(
          top: 50.0,
          right: 15.0,
          left: 15.0,
          child: Container(
            height: 50.0,
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
              cursorColor: black,
              controller: destinationController,
              textInputAction: TextInputAction.go,
              onSubmitted: (value){
                sendRequest(value);
              },
              decoration: InputDecoration(
                icon: Container(
                  margin: EdgeInsets.only(left: 20, top: 5),
                  width: 10,
                  height: 10,
                  child: Icon(
                    Icons.location_on,
                    color: orange,
                  ),
                ),
                hintText: "Enter Pick up Location",
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 15.0, top: 16.0),
              ),
            ),
          ),
        ),

        Positioned(
          top: 105.0,
          right: 15.0,
          left: 15.0,
          child: Container(
            height: 50.0,
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
              cursorColor: black,
             // controller: appState.destinationController,
              textInputAction: TextInputAction.go,
              onSubmitted: (value) {
                //appState.sendRequest(value);
              },
              decoration: InputDecoration(
                icon: Container(
                  margin: EdgeInsets.only(left: 20, top: 5),
                  width: 10,
                  height: 10,
                  child: Icon(
                    Icons.directions_bike,
                    color: orange,
                  ),
                ),
                hintText: "Delivery location",
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 15.0, top: 16.0),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 40,
          left: 10 ,
          child: FloatingActionButton(
            onPressed: _onAddMarkerPressed,
            tooltip: "Add Marker",
            backgroundColor: orange,
            splashColor: black,
            child: Icon(Icons.add_location, color: white,),
          ),
        ),

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

  void _addMarker(LatLng location, String address) {
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId( _lastPosition.toString() ),
        position: location,
        infoWindow: InfoWindow(
          title: address,
          snippet: "Enter Pick up Location"
        ),
        icon: BitmapDescriptor.defaultMarker
      )
      );
    });
  }

  void createRoute (String encodedPoly) {
    setState(() {
      _polyLine.add(Polyline(polylineId: PolylineId(_lastPosition.toString()),
      width: 10,
      points: convertToLatLng(decodePoly(encodedPoly)),
      color: orange
      ));
    });
  }

  List<LatLng> convertToLatLng(List points) {
    List<LatLng> result = <LatLng>[];
    for (int i = 0; i < points.length; i++){
      if (i % 2 !=0) {
        result.add(LatLng(points[i-1], points[i]));
      }
    }
    return result;
  }


  List decodePoly(String poly){
    var list = poly.codeUnits;
    var lList=new List();
    int index =0;
    int len = poly.length;
    int c=0;

    do
      {
        var shift = 0;
        int result = 0;

        do
          {
            c =list[index] - 63;
            result|=(c & 0x1F) <<(shift*5);
            index++;
            shift++;
          }while(c>=32);
        if(result & 1==1)
          {
            result=~result;
          }
        var result1 = (result >> 1) * 0.00001;
        lList.add(result1);
      }while(index<len);

    for(var i=2; i<lList.length;i++)
      lList[i]+=lList[1-2];

    print(lList.toString());

    return lList;


  }

  void _getUserLocation() async{
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemark = await placemarkFromCoordinates(position.latitude, position.longitude);
    setState(() {
      _initialPosition = LatLng(position.longitude, position.latitude);
      locationController.text = placemark[0].name;
    });

  }

  void sendRequest(String intendedLocation) async{
   List<Location> location = await locationFromAddress(intendedLocation);

      //double latitude = placemark[0].position.latitude;
      //double longitude = placemark[0].position.longitude;
    //
   // LatLng destination = LatLng();
    //_addMarker(destination, intendedLocation);
    //String route = await _googleMapServices.getRouteCoordinates(_initialPosition, destination);
    //createRoute(route);
  }


  void _onAddMarkerPressed() {
    setState(() {
      return _initialPosition;
    });
  }
}


import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'Content/imagewidget.dart';
import 'package:geolocator/geolocator.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Future getWeather() async {
    // use try catch block for any exception
    try {
      var response = await Dio().get(
          'https://api.weatherapi.com/v1/current.json?key=68ea3b75c9c2462787e52106211203&q=$location&aqi=yes');
      Map<String, dynamic> data = jsonDecode(response.toString());

      setState(() {
        country = data['location']['country'].toString();
        location = data['location']['name'].toString();
        temp = data['current']['temp_c'].round();

        time = data['location']['localtime'].toString();

        tempf = data['current']['temp_f'].round();
        humidity = data['current']['humidity'].round();
        wind = data['current']['wind_kph'].round();

        cacheIcon = data['current']['condition']['icon'].toString();
        src = 'https:' + cacheIcon; 
        loading = true;
      });
    } on Exception catch (e) {
      print(e.toString().toUpperCase());
    }
  }


  Future getWeatherByLocation(latitude, longitude) async {
//http://api.openweathermap.org/data/2.5/weather?lat=28.67&lon=77.22&appid=0fe03700518423ac4a10d937dd52aba5
    String url =
        'http://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=0fe03700518423ac4a10d937dd52aba5&units=metric';
    var response = await Dio().get(url);
    var convert =
        jsonDecode(response.toString()); 
    setState(() {
      loading = true;
      location = convert['name'];
      temp = convert['main']['temp'].round();
      humidity = convert['main']['humidity'];
      country = convert['sys']['country'];
    });
  }

  TextEditingController controller = TextEditingController();

  Future getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    if (position != null) {
      getWeatherByLocation(position.latitude, position.longitude);
    }
  }

  bool loading = false;
  @override
  void initState() {
    super.initState();
    getWeather();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height.toDouble();
    return Container(
      decoration: const BoxDecoration(
        // background color
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xff0e1e29),
            Color(0xff5292a4),
          ],
        ),
      ),
      child: loading
          ? Scaffold(
              backgroundColor: Colors.transparent,
              appBar: buildAppBar(),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            child: buildTextField(),
                            width: size.width / 1.6,
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.search,
                              size: 20,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                location = controller.text;
                                loading = false;
                              });
                              getWeather();
                            },
                          )
                        ],
                      ),
                    ),
                    buildTempField(height),
                    const SizedBox(
                      height: 10
                    ),
                    buildRowData(
                      data: humidity.toString() + ' %',
                      text: 'Humidity',
                    ),
                    const SizedBox(
                      height: 20
                      ),
                    
                    const Divider(
                      thickness: 2
                    ),
                    const SizedBox(
                      height: 10
                    ),
                   
                  ],
                ),
              ),
            )
          : Scaffold(
              body: Container(
                  child: const Center(
                child: CircularProgressIndicator(),
              )),
            ),
    );
  }

  Image buildWeatherIcon() {
    return Image.network(
      src,
      height: 70,
      width: 70,
      fit: BoxFit.cover,
    );
  }

  Row buildRowData({
    required String text,
    required String data,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: customGrey,
        ),
        Text(
          data,
          style: customGrey,
        ),
      ],
    );
  }

  FittedBox buildTempField(double height) {
    return FittedBox(
      fit: BoxFit.fill,
      child: Row(
        children: [
          Text(
            temp.toString(),
            style: TextStyle(
              fontSize: height / 8, 
              color: Colors.white
            ),
          ),
          const SizedBox(
            width: 5
          ),
          Text(
            '°C',
            style: TextStyle(
              fontSize: height / 8.5,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  TextField buildTextField() {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(
        hintText: 'Search City',
        hintStyle: TextStyle(
          color: Colors.grey,
        ),
      ),
      style: const TextStyle(
        color: Colors.white,
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: [
        IconButton(
          icon: const Icon(
            Icons.refresh,
            color: Colors.grey,
          ),
          onPressed: () {
            setState(() {
            });
          },
        ),
      ],
      title: appData(),
    );
  }

  Column appData() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          time.toString(),
          style: smallText,
        ),
        const SizedBox(
          height: 7
        ),
        FittedBox(
          fit: BoxFit.fitWidth,
          child: Row(
            children: [
              const Icon(
                Icons.room,
                color: Colors.red,
                size: 20,
              ),
              const SizedBox(
                width: 5
              ),
              Text(
                location.toString() + " ," + country.toString().toUpperCase(),
                style: smallText.copyWith(
                  color: Colors.white54,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
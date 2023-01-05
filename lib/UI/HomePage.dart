
import 'dart:async';


import 'package:dio/dio.dart';
import 'package:first_test/models/City.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';

import '../models/dailyCityWeather.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {



  late Future<cityWeather> city_weather_future ;
  late StreamController<List<dailyCityWeather>> streamController_dayliforcast ;

  var cityname ='birjand' ;


  TextEditingController txt_cityname = TextEditingController();


  @override
  void initState() {

    super.initState() ;
    city_weather_future = sendRequestCurrentWeather(cityname) ;
    streamController_dayliforcast = StreamController <List<dailyCityWeather>> () ;
  }

  Future<cityWeather> sendRequestCurrentWeather(String cityname) async
  {
    var apikey= "3340656428927741ac1304138ff0a62f";

    var respone =  await Dio().get("https://api.openweathermap.org/data/2.5/weather",queryParameters: {'q':cityname,'appid':apikey , 'units':'metric'}) ;

    var data_model =  cityWeather(
        respone.data["name"],
        respone.data["coord"]["lat"],
        respone.data["coord"]["lon"],
        respone.data["weather"][0]["main"],
        respone.data["weather"][0]["description"],
        respone.data["main"]["temp"] ,
        respone.data["main"]["temp_min"],
        respone.data["main"]["temp_max"],
        respone.data["main"]["pressure"],
        respone.data["main"]["humidity"],
        respone.data["wind"]["speed"],
        respone.data["dt"],
        respone.data["sys"]["country"],
        respone.data["sys"]["sunrise"],
        respone.data["sys"]["sunset"]
    ) ;

    getdailyForcast(respone.data["coord"]["lat"], respone.data["coord"]["lon"]) ;

    return data_model ;
  }

  void getdailyForcast(var lat , var lng )async
  {

    List<dailyCityWeather> weekly_weather = [] ;

    var apikey= "3340656428927741ac1304138ff0a62f";




    var respone =  await Dio().get("https://api.openweathermap.org/data/3.0/onecall",
        queryParameters: {'lat':lat,
                          'lon':lng,
                          'exclude':'minutely,hourly' ,
                          'appid':apikey ,
                          'units':'metric'}) ;


    /**

        the code has problem with api
        cant get data
        because onecall 3.0 isnt free .... :(
        and I must find another free api
     **/




  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar:  AppBar(
        title: Text("CityForcast"),
        actions: [
          PopupMenuButton(itemBuilder: (BuildContext context ){
              return {'seeting' , 'logout'}.map((String choise ) {
                  return PopupMenuItem(
                       value: choise,
                      child:Text(choise)
                  ) ;
              }).toList() ;
            }
          )
        ],
      ),
      body: FutureBuilder<cityWeather>(
        future: city_weather_future,
        builder: (context , snappshot)
        {
          if(snappshot.hasData)
          {
            cityWeather? city_datamodel = snappshot.data  ;

              return Container(
                color: Colors.yellow,
                child: Center(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: ElevatedButton(
                                    onPressed: ()=>{

                                      setState(() {
                                       city_weather_future = sendRequestCurrentWeather(txt_cityname.text) ;
                                      })
                                    }, child: Text("find")),
                              ) ,
                              Expanded(
                                  child:TextField(
                                    controller: txt_cityname,
                                    decoration: InputDecoration(
                                        hintStyle: TextStyle(color: Colors.white),
                                        hintText: "enter city name ",
                                        border: UnderlineInputBorder()
                                    ),
                                    style: TextStyle(color: Colors.white),
                                  )
                              )
                            ],
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(top: 100),
                          child:  Text(city_datamodel!.cityname , style: TextStyle(color: Colors.black , fontSize: 35),),
                        ) ,
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child:  Text(city_datamodel.description , style: TextStyle(color: Colors.grey , fontSize: 20),),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child:  Icon(Icons.wb_sunny_outlined , color: Colors.grey, size:70),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child:  Text(city_datamodel.temp.toString()+ "\u00B0" , style: TextStyle(color: Colors.grey , fontSize: 70),),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 5),
                                    child:  Text("max" , style: TextStyle(color: Colors.grey , fontSize: 25),),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 5),
                                    child:  Text(city_datamodel.temp_max.toString()+ "\u00B0" , style: TextStyle(color: Colors.grey , fontSize: 22),),
                                  ),
                                ],
                              ),
                            ) ,
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 5),
                                    child:  Text("min" , style: TextStyle(color: Colors.grey , fontSize: 25),),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 5),
                                    child:  Text(city_datamodel.temp_min.toString()+ "\u00B0" , style: TextStyle(color: Colors.grey , fontSize: 22),),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Container(
                            color: Colors.white,
                            height: 1,
                            width: double.infinity,

                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 100,
                          child: Center(
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: 6,
                                itemBuilder:(BuildContext context ,  int pos )
                                {

                                  return Container(
                                    width: 50,
                                    height: 50,
                                    child: Card(
                                      child:Column(

                                        children: [
                                          Text("day" , style: TextStyle(color: Colors.grey , fontSize: 25),),
                                          Icon(Icons.wb_sunny_outlined , color: Colors.grey, size:25),
                                          Text("14"+ "\u00B0" , style: TextStyle(color: Colors.grey , fontSize: 20),),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                            ),
                          ),
                        )
                      ],
                    ))
                ,
              ) ;
          }
          else
            {
              return Center(
                  child: JumpingDotsProgressIndicator(
                    color: Colors.red,
                    fontSize: 60,
                    dotSpacing: 2,
                  ) ,
              ) ;

            }
        },

      ),


    ) ;
  }
}

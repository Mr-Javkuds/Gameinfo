import 'package:flutter/material.dart';
import 'package:gaminfo/model/gameFilter.dart';
import 'package:gaminfo/model/gameNoFilter.dart';
import 'package:gaminfo/model/game_list.dart';
import 'package:gaminfo/page/detail.dart';
import 'package:gaminfo/service.dart';
import 'package:gaminfo/utils/rounded_image.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class search_page extends StatefulWidget {
  const search_page({Key? key}) : super(key: key);

  @override
  State<search_page> createState() => _search_pageState();
}

class _search_pageState extends State<search_page> {
  bool isLoaded = false;
  GameFilter? gamefilter;
  GameList? gamelist;
  GamenoFilter? gamenofilter;
  TextEditingController _searchController = TextEditingController();

  Future<void> _runFilters( value) async {
    try {
      final response = await API_SERVICE().getFilter(value: value);
      setState(() {
        gamefilter = response;
        isLoaded = true;
      });
    } catch (e) {
      print('Error: $e');
      // Handle error here
    }
  }

  Future getdata() async {
    gamelist = await API_SERVICE().getGamelist();
    setState(() {
      isLoaded = true;
    });
  }


  @override
  void initState() {
    super.initState();
    print(_searchController.text);
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    var check = _searchController.text == '' ? false : true;


    return Scaffold(
      backgroundColor: HexColor("#1B2838"),
      appBar: AppBar(
        backgroundColor: HexColor("#1B2838"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,color: Colors.white,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Search Page',style: TextStyle(color: Colors.white),),
      ),
      body: Column(
        children: [
          Container(
            color: HexColor("#1B2838"),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Card(
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    _runFilters(value);
                  },

                  decoration: InputDecoration(
                    disabledBorder: InputBorder.none,
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search',
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide.none, // Remove underline border
                    ),
                  ),
                ),
              ),
            ),
          ),

          check != false
              ? Expanded(
            child: ListView.builder(
              itemCount: gamefilter?.results?.length ?? 0,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      String realesed=gamelist?.results?[index].released.toString()??'';

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                detail(id: gamefilter?.results?[index].id.toString() ?? "0",
                                  date_realesed: realesed,)),
                      );
                    },
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: HexColor("#174D75"),
                      ),
                      child: Row(
                        children: [
                          rounded_image(
                            imageUrl: '${gamefilter?.results?[index].backgroundImage ?? ''}',
                            width: 80,
                            height: 100,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            height: 100,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(gamefilter?.results![index].slug ?? "Loading...",style: TextStyle(color: Colors.white)),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                    "Release Date : ${DateFormat('yyyy-MM-dd').format(DateTime.parse( gamefilter?.results![0].released.toString() ?? ''))}",style: TextStyle(color: Colors.white)),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                    "Rating : ${gamefilter?.results![index].rating ?? "Loading..."}",style: TextStyle(color: Colors.white)),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          )
              : Expanded(
            child: ListView.builder(
              itemCount: gamelist?.results?.length ?? 0,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      String realesed=gamelist?.results?[index].released.toString()??'';
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                detail(id: gamelist?.results?[index].id.toString() ?? "0", date_realesed: realesed,)),
                      );
                    },
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: HexColor("#174D75"),
                      ),
                      child: Row(
                        children: [
                          rounded_image(
                            imageUrl: '${gamelist?.results?[index].backgroundImage??""}',
                            width: 120,
                            height: 100,
                          ),

                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(gamelist?.results![index].name ?? "Loading...",style: TextStyle(color: Colors.white),),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                  "Release Date : ${gamelist?.results![index].released ?? "Loading..."}",style: TextStyle(color: Colors.white),),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                  "Rating : ${gamelist?.results![index].rating ?? "Loading..."}",style: TextStyle(color: Colors.white),),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

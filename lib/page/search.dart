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
  bool isloading = false;

  GameFilter? gamefilter;
  Gamenofilter? gamenofilter;

  List<Map<String, dynamic>> allData = [];
  List<Map<String, dynamic>>filteredData = [];

  Future<void> getdata() async {

    gamenofilter = await API_SERVICE().getnoFilter();
    if (gamenofilter != null) {
      allData = gamenofilter!.results?.map((data) {
        return {
          'id': data.id.toString(),
          'name': data.name.toString(),
          'slug': data.slug.toString(),
          'rating': data.rating.toString(),
          'released': data.released.toString(),
          'image': data.backgroundImage.toString(),
        };
      }).toList() ?? [];
      filteredData = allData;
    }else{
      setState(() {
        isloading = false;
      });
    }
  }

  Future<void> _searchFilter(String value) async {
    List<Map<String, dynamic>> results = [];
      results = allData
          .where((user) =>
          user["name"].toLowerCase().contains(value.toLowerCase()))
          .toList();

    setState(() {
      filteredData = results;
    });
  }

  @override
  void initState() {

    getdata();
    _searchFilter("");
    super.initState();
    // Pemanggilan ini akan menampilkan semua data saat halaman pertama kali dibuka.
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
 //   var check = _searchController.text == '' ? false : true;


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

                  onChanged: (value) => _searchFilter(value),
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

          // gamenofilter != null
               Expanded(
            child: ListView.builder(
              itemCount: filteredData?.length ?? 0,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      String realesed=filteredData?[index]['released'].released.toString()??'';
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                detail(id: filteredData?[index]['id'].toString() ?? "0",
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
                            imageUrl: '${filteredData?[index]['image'].toString() ?? ''}',
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
                                Text(filteredData?[index]['slug']?? "Loading...",style: TextStyle(color: Colors.white)),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                    "Release Date : ${DateFormat('yyyy-MM-dd').format(DateTime.parse( filteredData?[index]['released'].toString() ?? ''))}",style: TextStyle(color: Colors.white)),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                    "Rating : ${filteredData?[index]['rating'].toString()?? "Loading..."}",style: TextStyle(color: Colors.white)),
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
         //      : Expanded(
         //   child: ListView.builder(
         //     itemCount: allData?.length ?? 0,
         //     itemBuilder: (context, index) {
         //       return Container(
         //         margin: const EdgeInsets.all(8.0),
         //         child: InkWell(
         //           onTap: () {
         //             String realesed=allData?[index]['released'].released.toString()??'';
         //             Navigator.push(
         //               context,
         //               MaterialPageRoute(
         //                   builder: (context) =>
         //                       detail(id: allData?[index]['id'].toString() ?? "0",
         //                         date_realesed: realesed,)),
         //             );
         //           },
         //           child: Container(
         //             height: 100,
         //             decoration: BoxDecoration(
         //               borderRadius: BorderRadius.circular(8),
         //               color: HexColor("#174D75"),
         //             ),
         //             child: Row(
         //               children: [
         //                 rounded_image(
         //                   imageUrl: '${allData?[index]['image'].toString() ?? ''}',
         //                   width: 80,
         //                   height: 100,
         //                 ),
         //                 SizedBox(
         //                   width: 20,
         //                 ),
         //                 Container(
         //                   height: 100,
         //                   child: Column(
         //                     crossAxisAlignment: CrossAxisAlignment.start,
         //                     mainAxisAlignment: MainAxisAlignment.center,
         //                     children: [
         //                       Text(allData?[index]['slug']?? "Loading...",style: TextStyle(color: Colors.white)),
         //                       SizedBox(
         //                         height: 10,
         //                       ),
         //                       Text(
         //                           "Release Date : ${DateFormat('yyyy-MM-dd').format(DateTime.parse( allData?[index]['released'].toString() ?? ''))}",style: TextStyle(color: Colors.white)),
         //                       SizedBox(
         //                         height: 10,
         //                       ),
         //                       Text(
         //                           "Rating : ${allData?[index]['rating'].toString()?? "Loading..."}",style: TextStyle(color: Colors.white)),
         //                     ],
         //                   ),
         //                 )
         //               ],
         //             ),
         //           ),
         //         ),
         //       );
         //     },
         //   ),
         // )
          // Expanded(
          //   child: ListView.builder(
          //     itemCount: gamelist?.results?.length ?? 0,
          //     itemBuilder: (context, index) {
          //       return Container(
          //         margin: const EdgeInsets.all(8.0),
          //         child: InkWell(
          //           onTap: () {
          //             String realesed=gamelist?.results?[index].released.toString()??'';
          //             Navigator.push(
          //               context,
          //               MaterialPageRoute(
          //                   builder: (context) =>
          //                       detail(id: gamelist?.results?[index].id.toString() ?? "0", date_realesed: realesed,)),
          //             );
          //           },
          //           child: Container(
          //             height: 100,
          //             decoration: BoxDecoration(
          //               borderRadius: BorderRadius.circular(8),
          //               color: HexColor("#174D75"),
          //             ),
          //             child: Row(
          //               children: [
          //                 rounded_image(
          //                   imageUrl: '${gamelist?.results?[index].backgroundImage??""}',
          //                   width: 120,
          //                   height: 100,
          //                 ),
          //
          //                 SizedBox(
          //                   width: 20,
          //                 ),
          //                 Column(
          //                   crossAxisAlignment: CrossAxisAlignment.start,
          //                   mainAxisAlignment: MainAxisAlignment.center,
          //                   children: [
          //                     Text(gamelist?.results![index].name ?? "Loading...",style: TextStyle(color: Colors.white),),
          //                     SizedBox(
          //                       height: 10,
          //                     ),
          //                     Text(
          //                       "Release Date : ${gamelist?.results![index].released ?? "Loading..."}",style: TextStyle(color: Colors.white),),
          //                     SizedBox(
          //                       height: 10,
          //                     ),
          //                     Text(
          //                       "Rating : ${gamelist?.results![index].rating ?? "Loading..."}",style: TextStyle(color: Colors.white),),
          //                   ],
          //                 )
          //               ],
          //             ),
          //           ),
          //         ),
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gaminfo/model/gameGenre.dart';
import 'package:gaminfo/page/detail.dart';
import 'package:gaminfo/page/search.dart';
import 'package:gaminfo/service.dart';
import 'package:gaminfo/utils/rounded_image.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shimmer/shimmer.dart';

import '../model/game_list.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  bool isloaded = false;
  GameList? gamelist;
  GameGenre? gamegenre;
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future getList() async {
    gamelist = await API_SERVICE().getGamelist();
    setState(() {
      isloaded = true;
    });
  }

  Future getGenre() async {
    gamelist = await API_SERVICE().getGenre();
    setState(() {
      isloaded = true;
    });
  }

  @override
  void initState() {
    super.initState();
    getList();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: HexColor("#1B2838"),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: HexColor("#1B2838"),
            title: const Text('Game Info', style: TextStyle(color: Colors.white)),
            floating: true,
            actions: [],
          ),
          SliverToBoxAdapter(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => search_page(),
                  ),
                );
              },
              child: Container(
                color: HexColor("#1B2838"),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Card(
                    child: ListTile(
                      leading: new Icon(Icons.search, color: Colors.black45),
                      title: Text("Search", style: TextStyle(color: Colors.black45)),
                    ),
                  ),
                ),
              ),
            ),
          ),
          gamelist == null
              ? SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: 100,
                            width: width,
                            color: Colors.white,
                          ),
                        ),
                        Positioned(
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            child: Container(
                              height: 100,
                              padding: EdgeInsets.only(
                                left: 10,
                                right: 10,
                                bottom: 10,
                              ),
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              childCount: 10,
            ),
          )
              : SliverList(
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        String realesed= gamelist?.results?[index].released ?? "0";
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => detail(
                                  id: gamelist?.results?[index].id.toString() ?? "0",
                                 date_realesed: realesed,)),
                        );
                      },
                      child: Container(
                        height: 100,
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: HexColor("#174D75"),
                          // gradient: LinearGradient(
                          //   colors: [Color(0xFF00AFFF), Color(0xFF0E1D24)],
                          //   begin: Alignment.bottomRight,
                          //   end: Alignment.topRight,
                          // ),
                        ),
                        child: Row(
                          children: [
                            rounded_image(
                              imageUrl:
                              '${gamelist?.results?[index].backgroundImage ?? ''}',
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
                                Text(
                                  gamelist?.results![index].name ?? "Loading...",
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Release Date : ${gamelist?.results![index].released ?? "Loading..."}",
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Rating : ${gamelist?.results![index].rating ?? "Loading..."}",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
                childCount: gamelist?.results?.length ?? 0,
              ))
        ],
      ),
    );
  }

  Widget _buildShimmerLoading() {
    double width = MediaQuery.of(context).size.width;
    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              padding: EdgeInsets.all(8),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: 100,
                      width: width,
                      color: Colors.white,
                    ),
                  ),
                  Positioned(
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      child: Container(
                        height: 100,
                        padding: EdgeInsets.only(
                          left: 10,
                          right: 10,
                          bottom: 10,
                        ),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        childCount: 10,
      ),
    );
  }
}

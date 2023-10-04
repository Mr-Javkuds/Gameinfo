import 'package:flutter/material.dart';

import 'package:gaminfo/DB/DB_favorit.dart';
import 'package:gaminfo/model/game_fav.dart';
import 'package:gaminfo/model/game_detail.dart';
import 'package:gaminfo/service.dart';
import 'package:gaminfo/utils/rounded_image.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import '../model/game_detail.dart';
import '../service.dart';
class detail extends StatefulWidget {
  const detail({super.key,required this.id, required this.date_realesed});
  final String id;
  final String date_realesed;

  @override
  State<detail> createState() => _detailState();
}

class _detailState extends State<detail> {

  bool isloaded = false; // Inisialisasi dengan false pada awalnya
  GameDetail? gameDetail;
  FavoriteModel? favorite;
  bool checkExist = false;
  Color colorChecked = Colors.red;


  Future getAPi() async {


    gameDetail = await API_SERVICE().getDetail(id: widget.id);
    print(gameDetail?.name??'');
    setState(() {
      isloaded = true;
    });

  }
  Future<void> removeFromFavorite(FavoriteModel favorite) async {
    try {
      setState(() {});
      await Fav_DB.instance.delete(favorite.name.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Removed from favorites')),
      );
      setState(() {
        checkExist = false;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> addToFavorites(FavoriteModel favorite) async {
    setState(() {
      checkExist = true;
    });
    try {
      await Fav_DB.instance.create(favorite);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Added to favorites')),
      );
      setState(() {
        checkExist = true;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<bool> isFavorite(FavoriteModel favorite) async {
    bool exist = await Fav_DB.instance.read(favorite.name.toString());
    return exist;
  }

  void updateState() {
    setState(() {});
  }


  @override
  void initState() {
    super.initState();
    getAPi();
  }
// Text(gameDetail?.name??''),
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    final String htmlDescription = gameDetail?.descriptionRaw ?? '';
    String idstring = widget.id.toString();
    FavoriteModel favorite = FavoriteModel(

      image: gameDetail?.backgroundImage.toString() ?? '',
      name: gameDetail?.name.toString() ?? '',
      slug: gameDetail?.slug.toString() ?? '',
      released: gameDetail?.released.toString() ?? '',
      rating: gameDetail?.rating.toString() ?? '',
      idDetail:widget.id,
    );



    print(widget.id);
    // var description = parse(Html_description);
    return Scaffold(
      backgroundColor: HexColor("#1B2838"),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            ),
            title: Text(gameDetail?.name??'', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)),
            backgroundColor: HexColor("#1B2838"),
            floating: true,
            actions: [
              FutureBuilder<bool>(
                future: isFavorite(favorite),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  if (snapshot.hasData) {
                    bool isFav = snapshot.data!;
                    return IconButton(
                      onPressed: () async {
                        if (isFav) {
                          await removeFromFavorite(favorite);
                        } else {
                          await addToFavorites(favorite);
                        }
                        updateState();
                      },
                      icon: Icon(
                        isFav
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: checkExist ? Colors.red : Colors.red,
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
          gameDetail == null
              ? SliverToBoxAdapter(
            child: Container(
              color: Colors.black.withOpacity(0.5),
              height: 200,
              width: width,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          )
              :
          SliverToBoxAdapter(
            child: Container(
              height: 200,
              width: width,

              child: Image.network(gameDetail?.backgroundImage??'',fit: BoxFit.cover,),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(10),
              child: Text(gameDetail?.name??'', style: TextStyle(fontSize: 25,color: Colors.white)),
            ),
          ),

            SliverToBoxAdapter(
            child:  Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(
                color: Colors.white,
                thickness: 1,
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment. start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Release Date  ", style: TextStyle(fontSize: 14,color: Colors.white)),
                          SizedBox(height: 5,),
                      Text("${widget.date_realesed}", style: TextStyle(fontSize: 14,color: Colors.white)),
                      //    Text("${DateFormat('yyyy-MM-dd').format(DateTime.parse(gameDetail?.released.toString()?? ''))}", style: TextStyle(fontSize: 14,color: Colors.white)),
                        ],
                      ),
                      Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Genre  ", style: TextStyle(fontSize: 14,color: Colors.white)),
                          SizedBox(height: 5,),
                          Container(
                            height: 40,
                            width: 200,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                              itemCount: gameDetail?.genres?.length??0,
                              itemBuilder: (context, index) {
                                return Container(
                                  height: 30,
                                    margin: EdgeInsets.only(right: 5),
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.grey,
                                    ),

                                    child: Text("${gameDetail?.genres?[index].name??''}", style: TextStyle(fontSize: 14,color: Colors.white)));
                              }),
                          ),
                          //
                          // Text("Rating  ", style: TextStyle(fontSize: 14,color: Colors.white)),
                          // SizedBox(width: 5,),
                          // Text("${gameDetail?.rating??''}", style: TextStyle(fontSize: 14,color: Colors.white)),
                        ],
                      ),
                    ]
                  ),
                    SizedBox(height: 15,),
                  Divider(
                    color: Colors.white,
                    thickness: 1,
                  ),
                ],
              ),
            ),
          ),


          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment. start,
                children: [
                  Text("Developer", style: TextStyle(fontSize: 18,color: Colors.white)),
                  SizedBox(height: 10,),
                  Container(
                    height: 160,
                    width: 300,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:gameDetail?.developers?.length ?? 0,
                        itemBuilder: (context, index) {
                          return Container(
                              height: 100,
                              width: 150,
                              margin: EdgeInsets.only(right: 5),

                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),

                              ),

                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  gameDetail==null?Container(): rounded_image(width: width,height: 100, imageUrl: gameDetail?.developers?[index].imageBackground??''),
                                 SizedBox(height: 15,),
                                  Text("${gameDetail?.developers?[index].name??''}", style: TextStyle(fontSize: 14,color: Colors.white)),

                                ],
                              ));
                        }),
                  ),
                  SizedBox(height: 10,),
                  Divider(
                    color: Colors.white,
                    thickness: 1,
                  ),

                  Text("Description", style: TextStyle(fontSize: 18,color: Colors.white)),
                  SizedBox(height: 10,),
                  Text(
                   gameDetail?.descriptionRaw ?? "",
                    style: TextStyle(fontSize: 14,color: Colors.white,),


                  ),
                  SizedBox(height: 10,),
                  Divider(
                    color: Colors.white,
                    thickness: 1,
                  ),
                  SizedBox(height: 10,),

                ],
              ),
            ),
          )

        ],
      ),
    );
  }
}

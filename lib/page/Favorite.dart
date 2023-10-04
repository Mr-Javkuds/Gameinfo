import 'package:flutter/material.dart';
import 'package:gaminfo/DB/DB_favorit.dart';
import 'package:gaminfo/model/game_fav.dart';
import 'package:gaminfo/model/game_list.dart';
import 'package:gaminfo/page/Tabbar.dart';
import 'package:gaminfo/page/detail.dart';
import 'package:gaminfo/page/home.dart';
import 'package:gaminfo/utils/rounded_image.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  late List<FavoriteModel> dataListFavorite = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    read();
  }
  @override
  void dispose() => super.dispose();

  Future<void> read() async {
    setState(() {
      isLoading = true;
    });

    dataListFavorite = await Fav_DB.instance.readAll();

    setState(() {
      isLoading = false;
    });
  }

  Future<void> refresh() async {
    await read();
  }

  void showDeleteDialog(BuildContext context, String? name) {
    Widget cancelButton = TextButton(
      child: Text("Tidak"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop('dialog');
      },
    );
    Widget okButton = TextButton(
      child: Text("Hapus"),
      onPressed: () async {
        setState(() {});
        await Fav_DB.instance.delete(name);
        await read(); // Tambahkan await di sini
        Navigator.pop(context); // Pindahkan ini ke atas await read()
        Navigator.of(context, rootNavigator: true).pop('dialog');
        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Tabbar(halamanke: 0,)));

      },

    );

    AlertDialog alert = AlertDialog(
      content: Text("Apakah anda yakin ingin menghapus?"),
      actions: [cancelButton, okButton],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: HexColor("#1B2838"),
      appBar: AppBar(
        backgroundColor:HexColor("#1B2838"),
        title: Text(
          "Favorit Game",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Colors.white),
        ),
        actions: [],
      ),
      body: Container(
        color:HexColor("#1B2838"),
        padding: EdgeInsets.only(left: 25, right: 25, top: 5),
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : dataListFavorite.length == 0
                ? Center(
                    child: Text("Tidak ada data favorit",style: TextStyle(color: Colors.white)),
                  )
                : RefreshIndicator(
                    onRefresh: () async {
                      await refresh();
                    },
                    child: ListView.builder(
                      itemCount: dataListFavorite.length,
                      itemBuilder: (context, index) {
                        final item = dataListFavorite[index];
                        return InkWell(
                          onTap: () {

                            print(item.id);
                            String ids=item.idDetail.toString();
                            int idt=int.parse(ids);
                            // Implementasi tindakan ketika item diklik
                            String realesed=DateFormat('yyyy-MM-dd').format(DateTime.parse(item.released.toString() ?? ''));
                            Navigator.push(

                              context,
                              MaterialPageRoute(
                                  builder: (context) => detail(id:idt.toString(), date_realesed: realesed,)),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 5),
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color:  HexColor("#174D75"),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.04),
                                  offset: Offset(0.0, 4.0),
                                  blurRadius: 4.0,
                                ),
                              ],
                            ),
                            child: Row(
                              children: <Widget>[
                                rounded_image(
                                  imageUrl:
                                  item.image,
                                  width: 100,
                                  height: 100,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(

                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        item.name ?? "Loading...",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),

                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      // Text(
                                      //   "Realesed : ${item.released  ?? "Loading..."}",
                                      //   style: TextStyle(
                                      //     fontSize: 14,
                                      //   ),
                                      // ),
                                      Text(
                                        "Realesed : ${DateFormat('yyyy-MM-dd').format(DateTime.parse(item.released ?? ''))}," ,
                                          style: TextStyle(fontSize: 14,color: Colors.white),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "Rating : ${item.rating ?? "Loading..."}",
                                        style: TextStyle(fontSize: 14,color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                Spacer(),
                                IconButton(
                                  onPressed: () {
                                    showDeleteDialog(context, item.name);
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
      ),
    );
  }
}

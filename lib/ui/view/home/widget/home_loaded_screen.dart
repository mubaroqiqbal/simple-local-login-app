import 'package:flutter/material.dart';
import 'package:majootestcase/models/home/data.dart';
import 'package:majootestcase/ui/view/home/detail_movie.dart';

class HomeLoadedScreen extends StatelessWidget {
  final List<Data> data;

  const HomeLoadedScreen({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
          itemCount: data.length,
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 2, crossAxisSpacing: 2),
          itemBuilder: (BuildContext context, int index) {
            return GridTile(
              child: InkResponse(
                enableFeedback: true,
                child: data[index].i?.imageUrl != null
                    ? Image.network(
                        data[index].i!.imageUrl!,
                        fit: BoxFit.fill,
                      )
                    : Container(),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => DetailMovie(data: data[index])),
                ),
              ),
              footer: Container(
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                color: Colors.black,
                child: Text(
                  data[index].title ?? "",
                  textDirection: TextDirection.ltr,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            );
          }),
    );
  }

  Widget movieItemWidget(Data data) {
    return Container(
      height: 250,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25.0))),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(25),
              child: data.i?.imageUrl != null
                  ? Image.network(
                      data.i!.imageUrl!,
                    )
                  : Container(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              child: Text(data.title ?? "", textDirection: TextDirection.ltr),
            ),
          ],
        ),
      ),
    );
  }
}

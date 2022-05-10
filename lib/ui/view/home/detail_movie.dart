import 'package:flutter/material.dart';
import 'package:majootestcase/models/home/data.dart';

class DetailMovie extends StatelessWidget {
  final Data data;

  DetailMovie({
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  expandedHeight: 300.0,
                  pinned: true,
                  elevation: 0.0,
                  flexibleSpace: FlexibleSpaceBar(
                      background: data.i?.imageUrl != null
                          ? Image.network(
                              data.i!.imageUrl!,
                              fit: BoxFit.fill,
                            )
                          : Container()),
                ),
              ];
            },
            body: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        (data.title ?? "") + (data.releaseYear != null ? "(" + data.releaseYear.toString() + ")" : ""),
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(margin: EdgeInsets.only(top: 8.0, bottom: 8.0)),
                    ],
                  ),
                ),
                if ((data.series?.length ?? 0) <= 0)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text("Preview Not available"),
                  ),
                Container(
                  height: 300,
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: data.series?.length ?? 0,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (ctx, index) {
                        return Column(
                          children: [
                            Container(
                              height: 200,
                              margin: EdgeInsets.symmetric(horizontal: 4),
                              child: Image.network(
                                data.series![index].i!.imageUrl!,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 8),
                              width: MediaQuery.of(context).size.width * 0.85,
                              child: Text(
                                data.series?[index].l ?? "",
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.clip,
                              ),
                            )
                          ],
                        );
                      }),
                )
              ],
            )),
      ),
    );
  }
}

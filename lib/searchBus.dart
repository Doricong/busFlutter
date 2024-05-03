import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBusPage extends StatefulWidget {
  const SearchBusPage({super.key});


  @override
  State<SearchBusPage> createState() => _SearchBusPageState();
}

class _SearchBusPageState extends State<SearchBusPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Text(""),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SearchBar(
              onChanged: (value) {
                print("검색 값 = $value");
              },
              trailing: [
                IconButton(
                  onPressed: () {
                  },
                  icon: const Icon(Icons.search),
                  constraints: BoxConstraints(minHeight: 20),
                )
              ],
              backgroundColor: MaterialStatePropertyAll(Colors.white),
              shape: MaterialStateProperty.all(ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(10)
              )),
              hintText: "버스 노선 검색",
              hintStyle: MaterialStateProperty.all(TextStyle(color: Colors.grey)),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _search,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
        shape: CircleBorder(),
        backgroundColor: Colors.lightBlueAccent,
      ),
    );
  }

  void _search() {
  }
}
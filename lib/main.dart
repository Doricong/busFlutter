import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'my bus app',
        home: const MyHomePage(title: 'MY BUS'),
        theme: ThemeData(
          // AlterDialog 테마 설정
          dialogTheme: DialogTheme(
            backgroundColor: const Color(0xffE8F7FA),
            titleTextStyle: const TextStyle(
                color: Colors.blueGrey,
                fontSize: 20,
                fontWeight: FontWeight.w600),
            contentTextStyle: const TextStyle(color: Colors.black),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
        ),
        debugShowCheckedModeBanner: false // 디버그 띠 제거
        );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> list = ['1', '2', '3', '4', '10', '110'];
  List<String> filteredList = [];
  final TextEditingController textController = TextEditingController();

  late AlertDialog _searchDialog;

  late String selectedBusNumber;
  late String selectedTerminal;

  late String addedBus;

  @override
  void initState() {
    super.initState();
    _searchDialog = AlertDialog(
      title: const Text("노선 검색"),
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: 250,
                child: TextField(
                  controller: textController,
                  decoration: const InputDecoration(
                    hintText: "버스 노선 검색",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                  onChanged: (value) {
                    // 검색창에 입력하면 실행
                    setState(() {
                      filteredList = list
                          .where((element) =>
                              element
                                  .toLowerCase()
                                  .contains(value.toLowerCase()) &&
                              value.isNotEmpty)
                          .toList();
                    });
                  },
                ),
              ),
              const SizedBox(height: 10),
              filteredList.isEmpty
                  ? const Text("해당 데이터 없음")
                  : SizedBox(
                      height: 200,
                      width: 250,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemCount: filteredList.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(filteredList[index]),
                                  onTap: () {
                                    selectedBusNumber = filteredList[index];
                                    Navigator.of(context).pop();
                                    _showNewDialog(selectedBusNumber);
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ))
            ],
          );
        },
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            _clearFilteredList();
          },
          child: const Text("취소",
              style: TextStyle(color: Colors.lightBlueAccent)),
        ),
      ],
    );
  }

  void _showNewDialog(String selectedBus) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("종점 선택"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 200,
                width: 250,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: filteredList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(filteredList[index]),
                      onTap: () {
                        selectedTerminal = filteredList[index];
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                _clearFilteredList();
                selectedBusNumber = '';
                selectedTerminal = '';
              },
              child: const Text("취소",
                  style: TextStyle(color: Colors.lightBlueAccent)),
            ),
            TextButton(
              onPressed: () {
                _clearFilteredList();
              },
              child: const Text("완료",
                  style: TextStyle(color: Colors.lightBlueAccent)),
            ),
          ],
        );
      },
    );
  }

  void _clearFilteredList() {
    setState(() {
      filteredList.clear();
      textController.clear();
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title:
            Text(widget.title, style: const TextStyle(color: Colors.blueGrey)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              '자주 타는 버스를 추가해보세요.',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return _searchDialog;
            },
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
        shape: const CircleBorder(),
        backgroundColor: Colors.lightBlueAccent,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

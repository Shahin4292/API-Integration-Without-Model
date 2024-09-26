import 'package:api_integration/Service/service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  dynamic postModelData = [];
  bool isLoaded = false;

  getPost() {
    isLoaded = true;
    ApiService().getRequestWithoutModel().then((value) {
      setState(() {
        postModelData = value;
        isLoaded = false;
      });
    }).onError((error, stackTrace) {
      print(error);
    });
  }

  @override
  void initState() {
    getPost();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Api Without Model"),
      ),
      body: isLoaded
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              shrinkWrap: true,
              itemCount: postModelData.length,
              itemBuilder: (context, index) {
                // final postData = postModelData[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      userInfo(index, "Name : ",
                          postModelData[index]["Name"].toString()),
                    ],
                  ),
                );
              }),
    );
  }

  Row userInfo(int index, name, value) {
    return Row(
      children: [
        const Text(
          "name : ",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        Text(
          value.toString(),
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}

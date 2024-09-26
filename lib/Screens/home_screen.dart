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
      backgroundColor: Colors.blue,
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
                  child: Material(
                    elevation: 2,
                    borderRadius: BorderRadius.circular(20),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          userInfo(index, "Name : ",
                              postModelData[index]["name"].toString()),
                          userInfo(index, "Email : ",
                              postModelData[index]["email"].toString()),
                          userInfo(index, "City : ",
                              postModelData[index]["address"]["city"].toString()),
                          userInfo(index, "Street : ",
                              postModelData[index]["address"]["street"].toString()),
                          userInfo(index, "Phone : ",
                              postModelData[index]["phone"].toString()),
                          userInfo(index, "Website : ",
                              postModelData[index]["website"].toString()),
                        ],
                      ),
                    ),
                  ),
                );
              }),
    );
  }

  Row userInfo(int index, name, value) {
    return Row(
      children: [
        Text(
          name,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 22,
          ),
        ),
      ],
    );
  }
}

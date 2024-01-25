import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart';
import 'package:simple_example_retrofit/api/ads_api.dart';
import 'package:simple_example_retrofit/model/ads_model.dart';
import 'package:simple_example_retrofit/model/ads_request.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController latController = TextEditingController();
  TextEditingController lotController = TextEditingController();

  final dio = Dio();
  late AdsApi client;
  bool isLoading = false;

  Future<void> getData() async {
    setState(() {
      isLoading = true;
    });
    Ads ads = await client.getAds(
      AdsRequest(
          lot: int.parse(lotController.text),
          lat: int.parse(latController.text),
          title: titleController.text,
          description: descriptionController.text),
    );
    setState(() {
      isLoading = false;
    });
    print("DATAAAA -----------${ads.toJson()  }");
  }

  @override
  void initState() {
    client = AdsApi(dio);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: ListView(
        children: [
          Text("TItle"),
          TextField(
            controller: titleController,
          ),
          Text("Description"),
          TextField(
            controller: descriptionController,
          ),
          Text("Lat"),
          TextField(
            controller: latController,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
          Text("Lot"),
          TextField(
              controller: lotController,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly]),
          ElevatedButton(
            onPressed: () async {
              getData();
            },
            child: Text("SEND REQUEST"),
          )
        ],
      ),
    );
  }
}

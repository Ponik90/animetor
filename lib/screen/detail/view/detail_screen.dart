import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../home/provider/home_provider.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with TickerProviderStateMixin {
  HomeProvider? providerR;
  HomeProvider? providerW;
  AnimationController? controller;
  Tween<double>? turnsTween;

  @override
  void initState() {
    super.initState();
    context.read<HomeProvider>().getJsonData();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    turnsTween = Tween<double>(begin: 0, end: 1);
    controller!.addListener(() {
      setState(() {});
    });
    controller!.repeat();
  }

  @override
  Widget build(BuildContext context) {
    providerR = context.read<HomeProvider>();
    providerW = context.watch<HomeProvider>();

    int index = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Planet Detail"),
        actions: [
          IconButton(
            onPressed: () {
              print("add");
              providerR!.setBookMarkData(providerR!.planetList[index].image!);
            },
            icon: const Icon(Icons.favorite_border),
          ),
        ],
      ),
      body: Column(
        children: [
          RotationTransition(
            turns: turnsTween!.animate(controller!),
            child: Hero(
              tag: "$index",
              child: Image.network(providerR!.planetList[index].image!),
            ),
          ),
          Text("${providerR!.planetList[index].name}"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${providerR!.planetList[index].distance}"),
              Text("${providerR!.planetList[index].velocity}")
            ],
          ),
          Text("${providerR!.planetList[index].description}"),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }
}

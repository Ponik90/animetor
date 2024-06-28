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
      body: Stack(
        children: [
          Container(
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xff7538ed),
                  Colors.greenAccent,
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0, left: 8, right: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    const Text(
                      "Planet Detail",
                      style: TextStyle(
                        fontSize: 26,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        providerR!.setBookMarkData(
                          providerR!.planetList[index].image!,
                          providerR!.planetList[index].name!,
                        );
                      },
                      icon: const Icon(Icons.favorite_border),
                    ),
                  ],
                ),
                RotationTransition(
                  turns: turnsTween!.animate(controller!),
                  child: Hero(
                    tag: "$index",
                    child: Image.network(providerR!.planetList[index].image!),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "${providerR!.planetList[index].name}",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
                Text("Distance:-${providerR!.planetList[index].distance}"),
                const SizedBox(height: 10,),
                Text("Velocity:- ${providerR!.planetList[index].velocity}"),
                const SizedBox(height: 10,),
                const Text("Planet Info:-"),
                const SizedBox(height: 5,),
                Text("${providerR!.planetList[index].description}"),
              ],
            ),
          ),
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

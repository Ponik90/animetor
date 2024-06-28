import 'package:animetor_app/screen/home/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
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
      duration: const Duration(seconds: 4),
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Planet App"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, 'fav');
            },
            icon: Icon(Icons.favorite),
          ),
        ],
      ),
      body: GridView.builder(
        itemCount: providerW!.planetList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) {
          return RotationTransition(
            turns: turnsTween!.animate(controller!),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  'detail',
                  arguments: index,
                );
              },
              child: Hero(
                tag: "$index",
                child: Image.network(providerR!.planetList[index].image!),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }
}

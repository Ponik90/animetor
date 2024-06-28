import 'package:animetor_app/screen/home/provider/home_provider.dart';
import 'package:animetor_app/utils/shared_helper.dart';
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
            padding: const EdgeInsets.only(top: 30),
            child: Column(
              children: [
                const Text(
                  "Planet App",
                  style: TextStyle(fontSize: 26),
                ),
                Expanded(
                  child: GridView.builder(
                    itemCount: providerW!.planetList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
                            child: Image.network(
                                providerR!.planetList[index].image!),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: Stack(
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
              padding: const EdgeInsets.only(top: 50,left: 10,right: 10,),
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, 'fav');
                    },
                    title: const Text("Favorite"),
                    trailing: const Icon(Icons.favorite),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Change Theme"),
                      Switch(
                        value: providerW!.isTheme,
                        onChanged: (value) {
                          SharedHelper helper = SharedHelper();
                          helper.setTheme(value);
                          providerR!.changeTheme();
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }
}

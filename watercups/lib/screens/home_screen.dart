import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watercups/my_flutter_app_icons.dart';
import 'package:watercups/widgets/chart.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late SharedPreferences prefs;
  static const sizeofBottle = 750;
  static const sizeofPet = 500;
  static const sizeofCoffe = 350;
  var cupofwaterToday = 0;
  var sizeofCup = sizeofPet; //default size

  Future initPref() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs.getInt('cupofwaterToday') != null) {
      setState(() {
        cupofwaterToday = prefs.getInt('cupofwaterToday')!;
      });
    }
    if (prefs.getInt('sizeofCup') != null) {
      setState(() {
        sizeofCup = prefs.getInt('sizeofCup')!;
      });
    }
    print(sizeofCup);
  }

  void plusCup() async {
    cupofwaterToday += 1;

    await prefs.setInt('cupofwaterToday', cupofwaterToday);
    setState(() {});
  }

  void minusCup() async {
    cupofwaterToday -= 1;
    if (cupofwaterToday < 0) cupofwaterToday = 0;

    await prefs.setInt('cupofwaterToday', cupofwaterToday);
    setState(() {});
  }

  void setSizeofCup<int>(item) async {
    sizeofCup = item;
    await prefs.setInt('sizeofCup', sizeofCup);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    print("initstate!");
    initPref();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            const Text(
              "My daily water cups",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "Hello, sieon",
              style: TextStyle(
                color: Colors.black.withOpacity(0.8),
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).cardColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Icon(
                      Icons.water_drop_outlined,
                      size: 40,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "$cupofwaterToday cups",
                          style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 25,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "${sizeofCup}ml",
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.7),
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: plusCup,
                      child: const Icon(
                        Icons.add_circle,
                        size: 30,
                      ),
                    ),
                    GestureDetector(
                      onTap: minusCup,
                      child: Icon(
                        Icons.remove_circle,
                        color: Colors.red[400],
                        size: 30,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              "set my cup!",
              style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).textTheme.displayLarge!.color),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).cardColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () => setSizeofCup(sizeofPet),
                      child: CupItem(
                        cupName: "Pet",
                        cupIcon: MyFlutterApp.cup_1,
                        cupSize: sizeofPet,
                        chosen: (sizeofPet == sizeofCup),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => setSizeofCup(sizeofBottle),
                      child: CupItem(
                        cupName: "Bottle",
                        cupIcon: MyFlutterApp.cup,
                        cupSize: sizeofBottle,
                        chosen: sizeofBottle == sizeofCup,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => setSizeofCup(sizeofCoffe),
                      child: CupItem(
                        cupName: "Coffee",
                        cupIcon: Icons.coffee,
                        cupSize: sizeofCoffe,
                        chosen: sizeofCoffe == sizeofCup,
                      ),
                    ),
                    GestureDetector(
                      child: const Column(
                        children: [
                          Text("Custom"),
                          Icon(Icons.add_circle_outline_outlined),
                          Text("__ml"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const LineChartSample2()
          ],
        ),
      ),
    );
  }
}

class CupItem extends StatelessWidget {
  final String cupName;
  final IconData cupIcon;
  final int cupSize;
  final bool chosen;
  const CupItem({
    super.key,
    required this.cupName,
    required this.cupIcon,
    required this.cupSize,
    required this.chosen,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: chosen ? Colors.blue : Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
              blurRadius: chosen ? 15 : 0,
              offset: chosen ? const Offset(10, 10) : const Offset(0, 0),
              color: chosen ? Colors.black.withOpacity(0.5) : Colors.black)
        ],
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Text(
            cupName,
            style: TextStyle(
              color: chosen ? Colors.white : Colors.black,
            ),
          ),
          Icon(
            cupIcon,
            color: chosen ? Colors.white : Colors.black,
          ),
          Text(
            "${cupSize}ml",
            style: TextStyle(
              color: chosen ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

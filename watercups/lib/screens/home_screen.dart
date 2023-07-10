import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watercups/my_flutter_app_icons.dart';
import 'package:watercups/widgets/DrinksLineChart.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/CupItem.dart';

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
  late var db;
  var userData = [];

  Future initFireStore() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    db = FirebaseFirestore.instance;

    await db.collection("dailyCupsOfWater").get().then((event) {
      for (var doc in event.docs) {
        userData = doc.data()['shinsieon']['drinks'];

        setState(() {});
      }
    });
  }

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
    initPref();
    initFireStore();
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
            DrinksLineChart(
              userData: userData,
            )
          ],
        ),
      ),
    );
  }
}

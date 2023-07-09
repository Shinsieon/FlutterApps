import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late SharedPreferences prefs;
  late int cupofwaterToday;

  Future initPref() async {
    prefs = await SharedPreferences.getInstance();
    cupofwaterToday = prefs.getInt('cupofwaterToday') ?? 0;
  }

  void plusCup() async {
    await prefs.setInt('cupofwaterToday', cupofwaterToday);
    setState(() {
      cupofwaterToday += 1;
    });
  }

  void minusCup() async {
    await prefs.setInt('cupofwaterToday', cupofwaterToday);
    setState(() {
      cupofwaterToday -= 1;
      if (cupofwaterToday < 0) cupofwaterToday = 0;
    });
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
                          "150ml",
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
            )
          ],
        ),
      ),
    );
  }
}

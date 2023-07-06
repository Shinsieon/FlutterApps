import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                        const Text(
                          "3 cups",
                          style: TextStyle(
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
                    const Icon(
                      Icons.add_circle,
                      size: 40,
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

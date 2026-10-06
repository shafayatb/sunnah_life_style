import 'package:flutter/material.dart';
import 'package:sunnah_life_style/widgets/routine_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sunnah LifeStyle',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFFC67139),
          primary: const Color(0xFFC67139),
          surface: const Color(0xFFF5EAD8),
          surfaceContainer: const Color(0xFFebddc5),
          onSurface: const Color(0xFF201e1d),
        ),
        scaffoldBackgroundColor: const Color(0xFFF5EAD8),
        textTheme: const TextTheme(
          titleMedium: TextStyle(fontSize: 15),
          bodySmall: TextStyle(fontSize: 13),
          labelSmall: TextStyle(fontSize: 11),
        ),
      ),
      home: const MyHomePage(title: 'Sunnah LifeStyle'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final List<({String title, String description, String badgeLevel})>
    routines = [
      (
        title: 'Wake with gratitude',
        description:
            'Recall Allah before rising and begin the day with intention.',
        badgeLevel: 'Established Sunnah',
      ),
      (
        title: 'Pray Tahajjud',
        description: 'Pray to Allah and ask for anything',
        badgeLevel: 'Established Sunnah',
      ),
      (
        title: 'Pray Fajr',
        description: 'Start the day with mandatory Morning Prayer.',
        badgeLevel: 'Obligatory Act/Prayer',
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text(title), const Icon(Icons.dark_mode_outlined)],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Today ${DateTime.now()}"),
                    const SizedBox(height: 8),
                    const Text("4 out of 9"),
                    const SizedBox(height: 12),
                    LinearProgressIndicator(
                      value: 4 / 9,
                      minHeight: 8,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'A steady rhythm, not a race — every day starts fresh.',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 11
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 10),
              child: Text(
                'AFTER WAKING',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
            ...routines.map(
              (routine) => Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                child: RoutineCard(
                  title: routine.title,
                  description: routine.description,
                  badgeLevel: routine.badgeLevel,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Today',
          ),
          NavigationDestination(
            icon: Icon(Icons.bar_chart_outlined),
            label: 'Progress',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import './meeting_page.dart';
import './participant_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int atualPage = 0;
  late PageController pc;

  @override
  void initState() {
    pc = PageController(initialPage: atualPage);
    super.initState();
  }

  setAtualPage(page) {
    setState(() => atualPage = page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pc,
        onPageChanged: setAtualPage,
        children: const [
          ParticipantPage(),
          MeetingPage(),
        ]
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: atualPage,
        onDestinationSelected: (index) => setState(() {
          atualPage = index;
          pc.animateToPage(
            atualPage,
            duration: const Duration(milliseconds: 400),
            curve: Curves.ease,
          );
        }),
        animationDuration: const Duration(milliseconds: 400),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.person_2_outlined),
            selectedIcon: Icon(Icons.person_2),
            label: 'Participantes',
          ),
          NavigationDestination(
            icon: Icon(Icons.meeting_room_outlined),
            selectedIcon: Icon(Icons.meeting_room),
            label: 'Reuniões'
          ),
        ]
      ),
    );
  }
}
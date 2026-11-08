import 'package:flutter/material.dart';

void main() {
  runApp(const FaresLudoApp());
}

class FaresLudoApp extends StatelessWidget {
  const FaresLudoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FARES LUDO',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6C4DFF),
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF101020),
        useMaterial3: true,
      ),
      home: const MainNavigation(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int selectedIndex = 0;

  static const pages = [
    HomePage(),
    RoomsPage(),
    GiftsPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: pages[selectedIndex]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) =>
            setState(() => selectedIndex = index),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_rounded), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.meeting_room_rounded), label: 'Rooms'),
          NavigationDestination(icon: Icon(Icons.card_giftcard_rounded), label: 'Gifts'),
          NavigationDestination(icon: Icon(Icons.person_rounded), label: 'Profile'),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Row(
          children: [
            const CircleAvatar(
              radius: 23,
              backgroundColor: Color(0xFF6C4DFF),
              child: Icon(Icons.sports_esports, color: Colors.white),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                'FARES LUDO',
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.w900),
              ),
            ),
            _CoinPill(label: '2,500'),
          ],
        ),
        const SizedBox(height: 26),
        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF714DFF), Color(0xFFB044D8)],
            ),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('READY TO PLAY?',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900)),
              const SizedBox(height: 8),
              const Text('Meet friends and enjoy Ludo together.'),
              const SizedBox(height: 18),
              FilledButton.icon(
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF4E35B8),
                ),
                onPressed: () => _showNotice(context),
                icon: const Icon(Icons.play_arrow_rounded),
                label: const Text('Quick Play'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const SectionTitle('Game modes'),
        const SizedBox(height: 12),
        Row(
          children: const [
            Expanded(child: ModeCard(title: '2 Players', subtitle: '1 vs 1', icon: Icons.people_alt)),
            SizedBox(width: 12),
            Expanded(child: ModeCard(title: '4 Players', subtitle: 'Classic match', icon: Icons.groups)),
          ],
        ),
        const SizedBox(height: 24),
        const SectionTitle('Your next challenge'),
        const SizedBox(height: 12),
        const LudoBoardPreview(),
        const SizedBox(height: 12),
        const Text(
          'Prototype preview — online matches are not connected yet.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white54, fontSize: 12),
        ),
      ],
    );
  }
}

class RoomsPage extends StatelessWidget {
  const RoomsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const SectionTitle('Play rooms'),
        const SizedBox(height: 8),
        const Text('Join a table or create a private room.',
            style: TextStyle(color: Colors.white60)),
        const SizedBox(height: 18),
        FilledButton.icon(
          onPressed: () => _showNotice(context),
          icon: const Icon(Icons.add),
          label: const Text('Create private room'),
        ),
        const SizedBox(height: 18),
        const RoomTile(name: 'Golden Lounge', players: '2 / 4 players', code: 'Public'),
        const RoomTile(name: 'Friends Table', players: '1 / 2 players', code: 'Private'),
        const RoomTile(name: 'Night Tournament', players: '3 / 4 players', code: 'Public'),
        const SizedBox(height: 12),
        const Text('Demo rooms only. Real matchmaking will be added with the backend.',
            style: TextStyle(color: Colors.white54, fontSize: 12)),
      ],
    );
  }
}

class GiftsPage extends StatelessWidget {
  const GiftsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final gifts = [
      ('Rose', '🌹', '100 coins'),
      ('Golden Trophy', '🏆', '500 coins'),
      ('Diamond', '💎', '1,000 coins'),
      ('Crown', '👑', '2,500 coins'),
    ];
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const SectionTitle('Gift shop'),
        const SizedBox(height: 8),
        const Text('Send a little celebration to another player.',
            style: TextStyle(color: Colors.white60)),
        const SizedBox(height: 18),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: gifts.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.1,
          ),
          itemBuilder: (context, index) {
            final gift = gifts[index];
            return Card(
              color: const Color(0xFF202039),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () => _showNotice(context),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(gift.$2, style: const TextStyle(fontSize: 38)),
                    const SizedBox(height: 8),
                    Text(gift.$1, style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(gift.$3, style: const TextStyle(color: Colors.amber)),
                  ],
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 12),
        const Text('Purchases and gift transfers are not active in this prototype.',
            style: TextStyle(color: Colors.white54, fontSize: 12)),
      ],
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Center(
          child: Column(
            children: [
              CircleAvatar(
                radius: 42,
                backgroundColor: Color(0xFF6C4DFF),
                child: Icon(Icons.person, size: 48),
              ),
              SizedBox(height: 12),
              Text('Guest Player', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              Text('Level 1 • New challenger', style: TextStyle(color: Colors.white60)),
            ],
          ),
        ),
        const SizedBox(height: 26),
        const Row(
          children: [
            Expanded(child: StatCard(value: '0', label: 'Wins')),
            SizedBox(width: 10),
            Expanded(child: StatCard(value: '0', label: 'Friends')),
            SizedBox(width: 10),
            Expanded(child: StatCard(value: '1', label: 'Level')),
          ],
        ),
        const SizedBox(height: 20),
        ListTile(
          leading: const Icon(Icons.emoji_events),
          title: const Text('Leaderboard'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _showNotice(context),
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Settings'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _showNotice(context),
        ),
      ],
    );
  }
}

class LudoBoardPreview extends StatelessWidget {
  const LudoBoardPreview({super.key});

  @override
  Widget build(BuildContext context) {
    const colors = [
      Color(0xFFE94B5B),
      Color(0xFF36B879),
      Color(0xFF3F8CFF),
      Color(0xFFF5C542),
    ];
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFFECECF3),
          borderRadius: BorderRadius.circular(18),
        ),
        child: GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          children: [
            _BoardHome(color: colors[0]),
            _BoardPath(),
            _BoardHome(color: colors[1]),
            _BoardPath(),
            const Center(child: Icon(Icons.star, color: Color(0xFF6C4DFF), size: 52)),
            _BoardPath(),
            _BoardHome(color: colors[2]),
            _BoardPath(),
            _BoardHome(color: colors[3]),
          ],
        ),
      ),
    );
  }
}

class _BoardHome extends StatelessWidget {
  final Color color;
  const _BoardHome({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(3),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
      child: const Center(
        child: Icon(Icons.circle, color: Colors.white, size: 24),
      ),
    );
  }
}

class _BoardPath extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: const Color(0xFFD7D7E2),
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) => Text(
        title,
        style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w800),
      );
}

class ModeCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  const ModeCard({required this.title, required this.subtitle, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF202039),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, size: 30, color: const Color(0xFFB7A7FF)),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(subtitle, style: const TextStyle(color: Colors.white60, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

class RoomTile extends StatelessWidget {
  final String name;
  final String players;
  final String code;
  const RoomTile({required this.name, required this.players, required this.code});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF202039),
      child: ListTile(
        leading: const CircleAvatar(child: Icon(Icons.casino)),
        title: Text(name),
        subtitle: Text(players),
        trailing: Text(code, style: const TextStyle(color: Color(0xFFB7A7FF))),
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final String value;
  final String label;
  const StatCard({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF202039),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text(label, style: const TextStyle(color: Colors.white60, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

class _CoinPill extends StatelessWidget {
  final String label;
  const _CoinPill({required this.label});

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: const Icon(Icons.monetization_on, color: Colors.amber, size: 18),
      label: Text(label),
      backgroundColor: const Color(0xFF292944),
    );
  }
}

void _showNotice(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('This feature will be connected in the next development stage.')),
  );
}

import 'package:flutter/material.dart';
import 'dart:developer' as developer;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BandMgr')),
      body: ListView(
        children: const [
          _NavTile(label: 'Members', icon: Icons.group, route: '/members'),
          _NavTile(label: 'Events', icon: Icons.event, route: '/events'),
          _NavTile(
              label: 'Setlists', icon: Icons.queue_music, route: '/setlists'),
          _NavTile(label: 'Songs', icon: Icons.music_note, route: '/songs'),
        ],
      ),
    );
  }
}

class _NavTile extends StatelessWidget {
  final String label;
  final IconData icon;
  final String route;
  const _NavTile(
      {required this.label, required this.icon, required this.route});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        if (route == '/songs') {
          Navigator.of(context).pushNamed('/songs');
          return;
        }
        // TODO: implement routes
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Route $route not implemented')),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';

class SectionShell extends StatelessWidget {
  const SectionShell({super.key, required this.title, required this.child});
  final String title; final Widget child;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: size.width < 900 ? 24 : 64, vertical: 56),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 20),
        DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).cardTheme.color,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [BoxShadow(blurRadius: 26, spreadRadius: -12, color: Color(0x1A000000))],
          ),
          child: Padding(padding: const EdgeInsets.all(24), child: child),
        ),
      ]),
    );
  }
}
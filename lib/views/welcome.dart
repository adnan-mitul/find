import 'package:flutter/material.dart';

import '../loginPage.dart';

import '../loginPage.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> with SingleTickerProviderStateMixin {
  bool _showOverlay = false;
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  // List of options with icons and labels
  final List<Map<String, dynamic>> options = [
    {'icon': Icons.family_restroom, 'label': 'Family'},
    {'icon': Icons.person, 'label': 'Bachelors'},
    {'icon': Icons.house_siding, 'label': 'Sublets'},
    {'icon': Icons.cleaning_services, 'label': 'Maid'},
    {'icon': Icons.miscellaneous_services, 'label': 'Others'},
  ];

  // List of options for the 3-dot menu
  final List<Map<String, dynamic>> menuOptions = [
    {'icon': Icons.shopping_cart, 'label': 'Cart'},
    {'icon': Icons.star, 'label': 'Rating'},
    {'icon': Icons.favorite, 'label': 'Favourite'},
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  void _toggleOverlay() {
    setState(() {
      _showOverlay = !_showOverlay;
      if (_showOverlay) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  void _navigateToLoginPage() {
    // Navigate to login page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.more_vert, color: Colors.lightBlue),
          onPressed: _toggleOverlay,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: Colors.lightBlue),
            onPressed: _navigateToLoginPage, // Navigate to login page
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    prefixIcon: Icon(Icons.search, color: Colors.lightBlue),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      // First row with 3 icons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: options.take(3).map((option) {
                          return OptionCard(
                            icon: option['icon'],
                            label: option['label'],
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 32), // Gap between rows
                      // Second row with 2 centered icons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Spacer(),
                          OptionCard(
                            icon: options[3]['icon'],
                            label: options[3]['label'],
                          ),
                          const Spacer(flex: 2),
                          OptionCard(
                            icon: options[4]['icon'],
                            label: options[4]['label'],
                          ),
                          const Spacer(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: OptionCard(
                  icon: Icons.local_offer,
                  label: 'Hot Deals',
                ),
              ),
            ],
          ),
          SlideTransition(
            position: _offsetAnimation,
            child: GestureDetector(
              onTap: _toggleOverlay,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width * 0.5,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.horizontal(
                    right: Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: Offset(3, 0), // shadow direction: right
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Center(
                      child: Column(
                        children: [
                          Icon(Icons.person, size: 80, color: Colors.lightBlue),
                          GestureDetector(
                            onTap: _navigateToLoginPage, // Navigate to login page
                            child: Text(
                              'Sign In',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.lightBlue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: ListView(
                        children: menuOptions.map((option) {
                          return ListTile(
                            leading: Icon(option['icon'], color: Colors.lightBlue),
                            title: Text(option['label'], style: TextStyle(color: Colors.lightBlue)),
                            onTap: () {
                              // Handle menu option tap
                            },
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OptionCard extends StatelessWidget {
  final IconData icon;
  final String label;

  const OptionCard({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          // Handle option tap
        },
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 3,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 24, color: Colors.lightBlue),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.lightBlue, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

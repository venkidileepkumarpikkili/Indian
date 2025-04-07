//1st screen

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BookingHomePageWithNav(),
    );
  }
}

// COMBINED MAIN SCREEN WITH BOTTOM NAV
class BookingHomePageWithNav extends StatefulWidget {
  const BookingHomePageWithNav({super.key});

  @override
  State<BookingHomePageWithNav> createState() => _BookingHomePageWithNavState();
}

class _BookingHomePageWithNavState extends State<BookingHomePageWithNav>
    with TickerProviderStateMixin {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _getScreenByIndex(int index) {
    switch (index) {
      case 0:
        return const BookingHomePage(); // Your main travel booking UI
      case 1:
        return const Center(child: Text('Search Screen'));
      case 2:
        return const HomePage(); // FAB as Home
      case 3:
        return ProfileScreen();
      default:
        return const BookingHomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getScreenByIndex(_selectedIndex),
      bottomNavigationBar: CurvedBottomNav(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
      floatingActionButton: SizedBox(
        height: 60,
        width: 60,
        child: FloatingActionButton(
          shape: const CircleBorder(),
          backgroundColor: _selectedIndex == 2 ? Colors.white : Colors.orange,
          onPressed: () => _onItemTapped(2),
          child: Icon(Icons.shopping_basket,
              color: _selectedIndex == 2 ? Colors.orange : Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

// BOTTOM NAV BAR
class CurvedBottomNav extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CurvedBottomNav(
      {super.key, required this.selectedIndex, required this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 6,
      color: Colors.orange,
      child: SizedBox(
        height: 70,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  _navItem(Icons.home, "Home", 0, onItemTapped),
                  const SizedBox(width: 40),
                  _navItem(Icons.search, "Search", 1, onItemTapped),
                ],
              ),
              Row(
                children: [
                  _navItem(Icons.person, "Profile", 3, onItemTapped),
                  const SizedBox(width: 40),
                  _navItem(Icons.search, "Search", 4, onItemTapped),
                  //const SizedBox(width: 24), // Balance gap
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navItem(
      IconData icon, String label, int index, Function(int) onItemTapped) {
    return InkWell(
      onTap: () => onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          Icon(icon, color: selectedIndex == index ? Colors.blue : Colors.white),
          Text(
            label,
            style: TextStyle(
                color: selectedIndex == index ? Colors.blue : Colors.white,
                fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Home Screen'),
    );
  }
}

class BookingHomePage extends StatelessWidget {
  const BookingHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),

            // SECTION 1 — Transport Icons Row
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 6)
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _TransportIcon(icon: Icons.directions_bus, label: "BUS", isSelected: true, onTap: () {
                    Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const BookingHomePage()),
        );
                  }),
                  _TransportIcon(icon: Icons.train, label: "TRAIN", isSelected: false, onTap: () {
                    Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const BookingHomePage()),
        );
                  }),
                  _TransportIcon(icon: Icons.flight_takeoff, label: "FLIGHT", isSelected: false, onTap: () {
                    Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const BookingHomePage()),
        );
                  }),
                  _TransportIcon(icon: Icons.apartment, label: "HOTEL", isSelected: false, onTap: () {
                    Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const BookingHomePage()),
        );
                  }),
                  _TransportIcon(icon: Icons.local_taxi, label: "CAB", isSelected: false, onTap: () {
                    Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
                  }),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // SECTION 2 — Orange Card + Floating Nested Card
            const IndianBusCard(),

            // SECTION 3 — Offers
            const OffersSection(),

            const SizedBox(height: 50), // Extra padding at bottom
          ],
        ),
      ),
    );
  }
}

class _TransportIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _TransportIcon({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, color: isSelected ? Colors.orange : Colors.grey),
          const SizedBox(height: 5),
          Text(label,
              style:
                  TextStyle(color: isSelected ? Colors.black : Colors.grey)),
        ],
      ),
    );
  }
}

class IndianBusCard extends StatefulWidget {
  const IndianBusCard({super.key});

  @override
  State<IndianBusCard> createState() => _IndianBusCardState();
}

class _IndianBusCardState extends State<IndianBusCard> {
  final TextEditingController fromController =
      TextEditingController(text: "Hyderabad");
  final TextEditingController toController =
      TextEditingController(text: "Allagadda");
  String fromLocation = "Hyderabad";
  String toLocation = "Allagadda";
  DateTime selectedDate = DateTime.now();
  List<DateTime> dates = List.generate(5, (index) => DateTime.now().add(Duration(days: index)));

  String? getWeekday(int weekday) {
    switch (weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      default:
        return null;
      
    }
  }

  void updateSelectedDate(DateTime date) {
    setState(() {
      selectedDate = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // 🔶 Orange Header
          Container(
            height: 220,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            padding: const EdgeInsets.only(top: 20),
            alignment: Alignment.topCenter,
            child: const Text(
              "IndianBus",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),

          // ⚪ Floating White Card
          Positioned(
            top: 85,
            left: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  )
                ],
              ),
              child: Column(
                children: [
                  // 🚀 From-To Input Section (Column)
                  Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.location_on,
                                    color: Colors.orange),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: TextFormField(
                                    controller: fromController,
                                    style: const TextStyle(fontSize: 18),
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "From",
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        fromLocation = value;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const Divider(thickness: 1),
                            Row(
                              children: [
                                const Icon(Icons.place_outlined,
                                    color: Colors.orange),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: TextFormField(
                                    controller: toController,
                                    style: const TextStyle(fontSize: 18),
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "To",
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        toLocation = value;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // 🔁 Interchange Icon
                      Positioned(
                        right: 4,
                        top: 40,
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.orange,
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.swap_vert,
                                color: Colors.white),
                            onPressed: () {
                              _swapLocations();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // 📅 Date Selection
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (var date in dates)
                          GestureDetector(
                            onTap: () => updateSelectedDate(date),
                            child: DateBox(
                              day: date.day.toString(),
                              week: getWeekday(date.weekday) ?? '',
                              isSelected: selectedDate.day == date.day,
                            ),
                          ),
                        _buildMonthSelector(),
                        GestureDetector(
                          onTap: () async {
                            DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: selectedDate,
                              firstDate:
                                  DateTime.now().subtract(const Duration(days: 30)),
                              lastDate:
                                  DateTime.now().add(const Duration(days: 365)),
                            );
                            if (picked != null) {
                              setState(() {
                                selectedDate = picked;
                                dates = List.generate(7, (index) => DateTime(picked.year, picked.month, picked.day).add(Duration(days: index)));
                              });
                            }
                          },
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    DateFormat('MMMM').format(selectedDate),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '${selectedDate.year}',
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                              const Icon(Icons.arrow_drop_down),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40), // Space for floating button
                ],
              ),
            ),
          ),

          // Floating Search Button with Overflow
          Positioned(
            bottom:30,
            left: 140,
            right: 140,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 6,
                shadowColor: Colors.black26,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => IndianBusApp()),
                );
              },
              child: const Text(
                "search",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _swapLocations() {
    setState(() {
      String temp = fromLocation;
      fromLocation = toLocation;
      toLocation = temp;
      fromController.text = fromLocation;
      toController.text = toLocation;
    });
  }

  /// **Date Item Widget**
  Widget _buildDateItem(String day, String weekday, {bool isSelected = false}) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10), // Adjusted padding
          decoration: BoxDecoration(
            color: isSelected ? Colors.orange : Colors.transparent,
            shape: BoxShape.circle,
          ),
          child: Text(
            day,
            style: TextStyle(
              fontSize: 16, // Slightly smaller font
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          weekday,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  /// **Month Selector Widget**
  Widget _buildMonthSelector() {
    return const SizedBox.shrink();
  }

  Widget _buildInput(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.orange),
          const SizedBox(width: 10),
          Text(label,
              style: const TextStyle(fontSize: 16, color: Colors.black87)),
        ],
      ),
    );
  }
}

class DateBox extends StatelessWidget {
  final String day;
  final String week;
  final bool isSelected;

  const DateBox({
    Key? key,
    required this.day,
    required this.week,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.orange : Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            day,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            week,
            style: TextStyle(
              color: isSelected ? Colors.white70 : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}


class OffersSection extends StatelessWidget {
  const OffersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Text(
            "Offers",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 170,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 16),
            children: [
              _offerCard('https://www.gstatic.com/flutter-onestack-prototype/genui/example_1.jpg', 'Eid', 'Mubarak', "20%"),
              _offerCard('https://www.gstatic.com/flutter-onestack-prototype/genui/example_1.jpg', 'Holi', 'Hai!', "30%"),
              _offerCard('https://www.gstatic.com/flutter-onestack-prototype/genui/example_1.jpg', 'Diwali', 'Special', "50%"),
            ],
          ),
        ),
      ],
    );
  }

  Widget _offerCard(String image, String title, String subtitle, String discount) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: SizedBox(
          width: 280,
          child: Container(
            decoration: BoxDecoration(color: Colors.grey[200]),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(image, fit: BoxFit.cover),
                Positioned(
                  top: 10,
                  left: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold)),
                      Text(subtitle,
                         style: const TextStyle(
                              color: Colors.amberAccent,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                Positioned(
                  top:10,
                  right: 16,
                  child: Text(
                    discount,
                    style: const TextStyle(
                      color: Colors.yellow,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(color: Colors.black45, blurRadius: 4, offset: Offset(2, 2))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//profile screen

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F8),
      body: Stack(
        children: [
          Column(
            children: [
              // Centered Profile Header
              // Profile Header with Centered Title
              Container(
                color: const Color(0xFFFFA500),
                padding: const EdgeInsets.only(top:10, left: 20, right: 20, bottom: 30),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        'Profile',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const CircleAvatar(
                          radius: 35,
                          backgroundImage: NetworkImage('https://www.gstatic.com/flutter-onestack-prototype/genui/example_1.jpg'),
                        ),
                        const SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Kayal Vizhi',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              '+41 6232 283 8324',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        const Icon(Icons.edit, color: Colors.white70, size: 20),
                      ],
                    ),
                  ],
                ),
              ),

              // Cards List
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.only(top: 10, bottom: 100),
                  children: [
                    _buildCardItem(Icons.receipt_long, 'Bookings'),
                    _buildCardItem(Icons.groups_2_outlined, 'Passengers list'),
                    _buildCardItem(Icons.account_balance_wallet_outlined, 'Wallet'),
                    _buildCardItem(Icons.card_giftcard_outlined, 'Refer & Earn'),
                    _buildCardItem(Icons.local_offer_outlined, 'Offers'),
                    _buildCardItem(Icons.help_outline, 'FAQ’s & Support'),
                    _buildCardItem(Icons.info_outline, 'About Us'),
                  ],
                ),
              ),
            ],
          ),

          // Floating Navigation Bar
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                height: 60,
                width: 240,
                decoration: BoxDecoration(
                  color: const Color(0xFF033944),
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Icon(Icons.home, color: Colors.white),
                    const Icon(Icons.confirmation_number_outlined, color: Colors.white),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      child: Row(
                        children: [
                          const Icon(Icons.person_outline, color: Color(0xFF033944)),
                          const SizedBox(width: 5),
                          const Text(
                            "Profile",
                            style: TextStyle(
                              color: Color(0xFF033944),
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
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

  Widget _buildCardItem(IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          leading: Icon(icon, color: const Color(0xFF033944)),
          title: Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          onTap: () {},
        ),
      ),
    );
  }
}






//2nd screen
class IndianBusApp extends StatelessWidget {
  const IndianBusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BusBookingScreen(),
    );
  }
}

class BusBookingScreen extends StatelessWidget {
  const BusBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F3B5F),
      body: Column(
        children: [
          const SizedBox(height: 60),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Icon(Icons.arrow_back_ios, color: Colors.white),
                Icon(Icons.more_horiz, color: Colors.white),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Chennai, TN',
                      style: TextStyle(color: Colors.white70),
                    ),
                    Text(
                      'CHN',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Icon(Icons.directions_bus, color: Colors.white, size: 32),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Bangalore, KA',
                      style: TextStyle(color: Colors.white70),
                    ),
                    Text(
                      'BAG',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: 5,
              itemBuilder: (context, index) {
                final dates = [
                  'Nov 25',
                  'Nov 26',
                  'Nov 27',
                  'Nov 28',
                  'Nov 30',
                ];
                return Container(
                  margin: const EdgeInsets.only(right: 15),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: index == 2 ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    dates[index],
                    style: TextStyle(
                      color: index == 2 ? Colors.black : Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => MyAp()),
                      );
                    },
                    child: BusTile(
                      company: 'Virgin Travels',
                      timeStart: '6:50AM',
                      timeEnd: '12:15PM',
                      rating: 4.4,
                      seatsLeft: 34,
                      price: '£48',
                      tag: 'CHEAPEST',
                      tagColor: Colors.green,
                    ),
                  ),
                  BusTile(
                    company: 'Acela',
                    timeStart: '5:50AM',
                    timeEnd: '10:15AM',
                    rating: 4.4,
                    seatsLeft: 4,
                    price: '£52',
                    tag: 'FASTEST',
                    tagColor: Colors.blue,
                  ),
                  BusTile(
                    company: 'Essar',
                    timeStart: '6:50AM',
                    timeEnd: '12:15PM',
                    rating: 4.0,
                    seatsLeft: 12,
                    price: '£49',
                    tag: null,
                  ),
                ],
              ),
            ),
          ),
          const BottomFilterBar(),
        ],
      ),
    );
  }
}

class BusTile extends StatelessWidget {
  final String company;
  final String timeStart;
  final String timeEnd;
  final double rating;
  final int seatsLeft;
  final String price;
  final String? tag;
  final Color? tagColor;

  const BusTile({
    super.key,
    required this.company,
    required this.timeStart,
    required this.timeEnd,
    required this.rating,
    required this.seatsLeft,
    required this.price,
    this.tag,
    this.tagColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Icon(
                      Icons.directions_bus,
                      color: Colors.white,
                      size: 18,
                    ),
                    radius: 16,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    company,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              if (tag != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: tagColor!.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    tag!,
                    style: TextStyle(
                      color: tagColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                timeStart,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              Text('⟶', style: TextStyle(color: Colors.grey[600])),
              Text(
                timeEnd,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.star, size: 16, color: Colors.orange[400]),
              Text(" $rating"),
              const SizedBox(width: 10),
              Icon(Icons.event_seat, size: 16, color: Colors.grey),
              Text(" $seatsLeft"),
            ],
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              price,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}

class BottomFilterBar extends StatelessWidget {
  const BottomFilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          const BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          Icon(Icons.airline_seat_recline_extra, color: Colors.blue),
          Icon(Icons.event_seat, color: Colors.grey),
          Icon(Icons.bolt, color: Colors.grey),
          Icon(Icons.favorite_border, color: Colors.grey),
          Icon(Icons.filter_alt, color: Colors.teal),
        ],
      ),
    );
  }
}

//3rd screen
class MyAp extends StatelessWidget {
  const MyAp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BusSeatBookingScreen(),
    );
  }
}

class BusSeatBookingScreen extends StatelessWidget {
  const BusSeatBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: const Color(0xFF013440),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 30,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Icon(Icons.arrow_back_ios, color: Colors.white),
                        Icon(Icons.camera_alt, color: Colors.white),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Chennai CMBT',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        Column(
                          children: const [
                            Icon(Icons.directions_bus, color: Colors.white),
                            Text(
                              '4.06hrs',
                              style: TextStyle(color: Colors.white54),
                            ),
                          ],
                        ),
                        const Text(
                          'Bangalore BS',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 20),
                            SizedBox(width: 5),
                            Text('4.4', style: TextStyle(color: Colors.white)),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.person, color: Colors.white54, size: 18),
                            SizedBox(width: 5),
                            Text('34', style: TextStyle(color: Colors.white)),
                          ],
                        ),
                        Text(
                          '£48',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildSeatLegend('Booked', Colors.grey),
                    buildSeatLegend('Available', Colors.green),
                    buildSeatLegend('Female', Colors.pinkAccent),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('All Prices'),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF013440),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Text(
                        '£30',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const Text('£40'),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Upper Deck',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 30,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemBuilder: (context, index) {
                    if ([5, 6, 7, 10, 11, 12, 25, 26].contains(index)) {
                      return const SizedBox();
                    }
                    Color color;
                    if ([0, 1, 2, 3].contains(index)) {
                      color = Colors.green;
                    } else if ([5, 10].contains(index)) {
                      color = Colors.pinkAccent;
                    } else {
                      color = Colors.grey.shade300;
                    }
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: color),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Sleeper, Seater\nS8.W11'),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                          Color(0xFF1ABC9C),
                        ),
                        padding: MaterialStatePropertyAll(
                          EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => PointsScreen()),
                        );
                      },
                      child: const Text('Confirm'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSeatLegend(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          margin: const EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
            color: color.withOpacity(0.3),
            border: Border.all(color: color),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        Text(label),
      ],
    );
  }
}

//screen4
class PointsScreen extends StatefulWidget {
  const PointsScreen({super.key});

  @override
  State<PointsScreen> createState() => _PointsScreenState();
}

class _PointsScreenState extends State<PointsScreen> {
  int selectedBoarding = 0;
  int selectedDeboarding = 3;

  final List<String> points = [
    'Chennai CMBT @ 5:50am',
    'Chennai CMBT @ 6:40am',
    'Chennai CMBT @ 7:38am',
    'Chennai CMBT @ 9:18am',
    'Chennai CMBT @ 9:20am',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF013440),
        foregroundColor: Colors.white,
        title: const Text("Points"),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Boarding points:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 10),
              ...List.generate(points.length, (index) {
                return RadioListTile(
                  contentPadding: EdgeInsets.zero,
                  activeColor: const Color(0xFF013440),
                  title: Text(points[index]),
                  value: index,
                  groupValue: selectedBoarding,
                  onChanged: (value) {
                    setState(() {
                      selectedBoarding = value as int;
                    });
                  },
                );
              }),
              const SizedBox(height: 20),
              const Text(
                "Deboarding points:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 10),
              ...List.generate(points.length, (index) {
                return RadioListTile(
                  contentPadding: EdgeInsets.zero,
                  activeColor: const Color(0xFF013440),
                  title: Text(points[index]),
                  value: index,
                  groupValue: selectedDeboarding,
                  onChanged: (value) {
                    setState(() {
                      selectedDeboarding = value as int;
                    });
                  },
                );
              }),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF013440),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => My()),
                    );
                  },
                  child: const Text("Proceed", style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//screen5
class My extends StatelessWidget {
  const My({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Passenger Details App',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: const PassengerDetailsScreen(),
    );
  }
}

class PassengerDetailsScreen extends StatelessWidget {
  const PassengerDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF003049),
        leading: const BackButton(color: Colors.white),
        title: const Text(
          'Passenger Details',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Boarding and Deboarding points:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _boardingPointsCard(),
            const SizedBox(height: 20),
            _sectionHeader("Passenger details:", trailing: "+ Add Passenger"),
            const SizedBox(height: 10),
            _textField("Name", "Eddy Kim"),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(child: _textField("Age", "29")),
                const SizedBox(width: 20),
                Expanded(child: _genderSelector()),
              ],
            ),
            const SizedBox(height: 20),
            _sectionHeader("Contact details:"),
            const SizedBox(height: 10),
            _textField("E-mail", "eddykimonline@krmail.eu"),
            const SizedBox(height: 10),
            _textField("Phone Number", "+144 638 4382 485"),
            const SizedBox(height: 10),
            Row(
              children: [
                Checkbox(value: true, onChanged: (val) {}),
                const Expanded(
                  child: Text(
                    "Send mail and message about the trip details?",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        height: 70,
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey, width: 0.5)),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Total\n£86",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => PaymentScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF21B781),
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                "Continue to pay",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader(String title, {String? trailing}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        if (trailing != null)
          Text(trailing, style: const TextStyle(color: Colors.blue)),
      ],
    );
  }

  Widget _textField(String label, String hint) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Widget _genderSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Gender", style: TextStyle(fontSize: 12)),
        Row(
          children: [
            Radio<bool>(
              value: true,
              groupValue: true,
              onChanged: (bool? val) {},
            ),
            const Text("Male"),
            Radio<bool>(
              value: false,
              groupValue: true,
              onChanged: (bool? val) {},
            ),
            const Text("Female"),
          ],
        ),
      ],
    );
  }

  Widget _boardingPointsCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xFFF6F8FB),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _locationRow(Icons.directions_bus, "Chennai CMBT @ 5:50am"),
          const SizedBox(height: 10),
          _locationRow(Icons.location_on, "Bangalore BS @ 11:15am"),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.grey),
              ),
              child: const Text("Change"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _locationRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.black54, size: 20),
        const SizedBox(width: 8),
        Text(text, style: const TextStyle(fontSize: 14)),
      ],
    );
  }
}

//screen 6
class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF013C50),
        elevation: 0,
        title: const Text('Payment'),
        leading: const Icon(Icons.arrow_back),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Payment details:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Row(
                  children: [
                    Icon(Icons.access_time, size: 18),
                    SizedBox(width: 5),
                    Text('6:29'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 15),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Tickets',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('1x Seater'), Text('£20')],
                  ),
                  const SizedBox(height: 4),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('1x Sleeper'), Text('£20')],
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Taxes & Fees',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('VAT (18%)'), Text('£20')],
                  ),
                  const SizedBox(height: 4),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('ArrowSpeed Fee (12%)'), Text('£20')],
                  ),
                  const Divider(height: 25),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '£89',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.shade300,
                  style: BorderStyle.solid,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Promo code:',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Pay with:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 15),
            ExpansionTile(
              title: Row(
                children: const [
                  Text('Credit or Debit Cards'),
                  SizedBox(width: 10),
                  Icon(Icons.credit_card, size: 20),
                  SizedBox(width: 4),
                  Icon(Icons.payment, size: 20),
                ],
              ),
              children: const [SizedBox()],
            ),
            ExpansionTile(
              title: const Text('Wallets'),
              children: const [SizedBox()],
            ),
            ExpansionTile(
              initiallyExpanded: true,
              title: const Text('Unified Payment Interface'),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('UPI ID'),
                      const SizedBox(height: 6),
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'example@okaxis',
                          filled: true,
                          fillColor: Colors.grey.shade200,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'Your UPI ID is invalid. Please check again',
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => Ap()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF20B486),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: const Text('Pay £89', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//screen 7
class Ap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Payment Status App',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: PaymentStatusScreen(),
    );
  }
}

class PaymentStatusScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF003049),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Payment Status',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check, size: 40, color: Colors.white),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          const Text(
            'Payment Successful!',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          const Text(
            'Your payment is processed and your ticket is\nconfirmed!',
            style: TextStyle(fontSize: 14, color: Colors.black54),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF003049),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                onPressed: () {
                  // Navigate to ticket
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => TicketDetailsScreen()),
                  );
                },
                child: const Text(
                  'View ticket',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//screen 8
class TicketDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF003049),
      appBar: AppBar(
        backgroundColor: const Color(0xFF003049),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Ticket Details',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Rest Stops Header
            TicketCard(),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Rest Stops',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Rest Stop Cards
            const Card(
              child: ListTile(
                leading: Icon(Icons.location_on, color: Colors.blue),
                title: Text("7:45AM, Thiruvallur"),
                subtitle: Text("20 min stop"),
                trailing: Icon(Icons.keyboard_arrow_right),
              ),
            ),
            const Card(
              child: ListTile(
                leading: Icon(Icons.location_on, color: Colors.blue),
                title: Text("9:00AM, Mysore"),
                subtitle: Text("15 min stop"),
                trailing: Icon(Icons.keyboard_arrow_right),
              ),
            ),
            const SizedBox(height: 30),
            Align(
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Help',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => TicketDetailsFullScreen1(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                    ),
                    icon: const Icon(Icons.chat),
                    label: const Text('Chat with us'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Align(
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Rate this bus',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  StarRating(),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Center(
              child: Text(
                '© All rights reserved by Busapp™',
                style: TextStyle(color: Colors.white54, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TicketCard extends StatefulWidget {
  @override
  _TicketCardState createState() => _TicketCardState();
}

class _TicketCardState extends State<TicketCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: const [
                FlutterLogo(size: 40),
                SizedBox(width: 10),
                Text(
                  "IndianBus",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "CHENNAI CMBT\nOct 10, 5:00am",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "BENGALURU BS\nOct 10, 11:15am",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Passengers:\n2 Adults"),
                Text("Seat No:\n11U/13D"),
                Text("Ticket No:\n42WLMNC"),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Passenger Name:\nSenthil, Winander"),
                Text("Ticket Fare:\n£89"),
                Text("Rest Stops:\n1 Stop"),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              "Ticket Status : CONFIRMED",
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SlideTransition(
              position: _offsetAnimation,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Container(
                  height: 60,
                  width: 200,
                  color: Colors.black12,
                  child: const Center(
                    child: Text(
                      "||||||||||||||||||",
                      style: TextStyle(letterSpacing: 2),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RestStopCard extends StatelessWidget {
  final String time;
  final String location;
  final String duration;

  const RestStopCard({
    required this.time,
    required this.location,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.location_on_outlined, color: Colors.red),
        title: Text('$time, $location'),
        trailing: Text(duration),
      ),
    );
  }
}

class StarRating extends StatelessWidget {
  const StarRating({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        5,
        (index) => const Icon(Icons.star_border, color: Colors.amber),
      ),
    );
  }
}

//screen 9

class TicketDetailsFullScreen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF03293D),
      appBar: AppBar(
        backgroundColor: const Color(0xFF03293D),
        title: Text('Ticket Details', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {},
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'CHENNAI CMBT',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text('Oct 10, 6:00am'),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'BENGALORE BS',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text('Oct 10, 11:15am'),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [Text('Passengers'), Text('2 Adults')],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [Text('Seat No.'), Text('S1W10')],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [Text('Ticket No.'), Text('42Wn04')],
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Passenger Name'),
                            Text('Satosh, Wiklander'),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [Text('Ticket Fare'), Text('£89')],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [Text('Rest Stops'), Text('1 Stop')],
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Ticket Status : CONFIRMED",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    Container(
                      width: 200,
                      height: 70,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTiZ_sR3YNItj2xuJ4s0rZm2u9ePg1d7nTcAw&s',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),
            Text(
              "Track your bus",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTurx2c1Hj5g-9np_IqhoFudCgdK5lZr3FYjg&s',
                height: 160,
                fit: BoxFit.cover,
                errorBuilder: (
                  BuildContext context,
                  Object exception,
                  StackTrace? stackTrace,
                ) {
                  return const Text('Failed to load image');
                },
              ),
            ),
            SizedBox(height: 4),
            Text(
              "Bus is delayed by 30mins",
              style: TextStyle(color: Colors.redAccent),
            ),
            SizedBox(height: 16),
            Text(
              "Rest Stops",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 8),
            buildRestStopCard("7:45AM, Thiruvallur", "Snack Cafe", "20 mins"),
            buildRestStopCard("9:00AM, Mysore", "Velvet Bistro", "15 mins"),
            SizedBox(height: 24),
            Text(
              "Help",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  icon: Icon(Icons.chat_bubble_outline),
                  label: Text("Chat with us"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => RestStopsScreen()),
                    );
                  },
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {},
                  child: Text("Cancel Ticket"),
                ),
              ],
            ),
            SizedBox(height: 32),
            Center(
              child: Text(
                "HAPPY JOURNEY!\nAll rights reserved by AcmeCorp™",
                style: TextStyle(color: Colors.white70),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRestStopCard(String time, String title, String duration) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: Icon(Icons.location_on, color: Colors.redAccent),
        title: Text(title),
        subtitle: Text(time),
        trailing: Text(duration),
      ),
    );
  }
}

//screen 10

class RestStopsScreen extends StatelessWidget {
  const RestStopsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFF00343F),
        appBar: AppBar(
          backgroundColor: const Color(0xFF00343F),
          elevation: 0,
          leading: const Icon(Icons.arrow_back_ios, color: Colors.white),
          title: const Text(
            'Rest Stops',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Rest Stops",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.local_cafe, color: Colors.green),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Standby Cafe",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "7:45AM, Thiruvallur",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Ratings",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Row(
                      children: List.generate(
                        4,
                        (index) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 24.0,
                        ),
                      )..add(
                        const Icon(
                          Icons.star_half,
                          color: Colors.amber,
                          size: 24.0,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      "4.3 (3.8k ratings)",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ...List.generate(
                  5,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      children: [
                        Text(
                          "${5 - index}",
                          style: const TextStyle(color: Colors.white),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: LinearProgressIndicator(
                            value: [0.6, 0.4, 0.3, 0.15, 0.1][index],
                            color: Colors.green,
                            backgroundColor: Colors.white24,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Reviews",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                _buildReview("Aerospeed user", "4 months ago"),
                _buildReview("Aerospeed user", "1 month ago"),
                const SizedBox(height: 20),
                const Text(
                  "Your Rating",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: List.generate(
                    5,
                    (index) =>
                        const Icon(Icons.star_border, color: Colors.amber),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white10,
                    hintText: 'What did you like the most',
                    hintStyle: const TextStyle(color: Colors.white60),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        child: const Text("Cleanliness"),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        child: const Text("Rest rooms"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildReview(String user, String timeAgo) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 20,
            backgroundColor: Colors.white,
            child: Icon(Icons.person),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      user,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      timeAgo,
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                const Text(
                  "Lorem ipsum dolor sit amet consectetur. Scelerisque la at et sapien eget et orci posuere donec. Vel dignissim hendrerit pellentesque gravida malesuada varius.",
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

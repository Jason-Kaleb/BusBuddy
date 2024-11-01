import 'package:flutter/material.dart';

class AboutView extends StatefulWidget {
  const AboutView({super.key});

  @override
  State<AboutView> createState() => _AboutViewState();
}

class _AboutViewState extends State<AboutView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              backgroundColor: const Color(0xFFFF4500),
              flexibleSpace: FlexibleSpaceBar(
                title: const Text('About Bus Buddy',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                background: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [Color(0xFFFF4500), Color(0xFFFF8C00)],
                    ),
                  ),
                  child: Center(
                    child: Icon(Icons.directions_bus,
                        size: 80, color: Colors.white.withOpacity(0.7)),
                  ),
                ),
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_rounded,
                    color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle('Our Mission'),
                    const SizedBox(height: 16),
                    _buildMissionCard(),
                    const SizedBox(height: 24),
                    _buildSectionTitle('What We Do'),
                    const SizedBox(height: 16),
                    _buildDescriptionCard(),
                    const SizedBox(height: 24),
                    _buildSectionTitle('Key Features'),
                    const SizedBox(height: 16),
                    _buildFeaturesList(),
                    const SizedBox(height: 24),
                    _buildSectionTitle('Terms of Use'),
                    const SizedBox(height: 16),
                    _buildTermsOfUseList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Color(0xFFFF4500),
      ),
    );
  }

  Widget _buildMissionCard() {
    return Card(
      elevation: 4,
      color: const Color(0xFFFFF0E6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(Icons.lightbulb_outline, size: 48, color: Color(0xFFFF4500)),
            SizedBox(height: 16),
            Text(
              'To revolutionize public transportation by providing real-time, accurate information to commuters, enhancing their travel experience and improving overall efficiency.',
              style: TextStyle(fontSize: 16, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDescriptionCard() {
    return Card(
      elevation: 4,
      color: const Color(0xFFFFF0E6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          'The Bus Buddy Application is a comprehensive solution for users to easily track the location of their buses, receive estimated arrival times (ETAs), and get reports on bus delays or cancellations. Designed to improve public transportation efficiency and user experience, this app provides real-time updates and detailed information about bus schedules.',
          style: TextStyle(fontSize: 16, color: Colors.black87),
        ),
      ),
    );
  }

  Widget _buildFeaturesList() {
    final features = [
      {
        'icon': Icons.info_outline,
        'title': 'Real-time Tracking',
        'description': 'Know exactly where your bus is'
      },
      {
        'icon': Icons.access_time,
        'title': 'Accurate ETAs',
        'description': 'Get precise arrival time estimates'
      },
      {
        'icon': Icons.verified_user,
        'title': 'Delay Reports',
        'description': 'Stay informed about any service disruptions'
      },
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: features.length,
      itemBuilder: (context, index) {
        final feature = features[index];
        return Card(
          elevation: 2,
          color: const Color(0xFFFFF0E6),
          margin: const EdgeInsets.only(bottom: 16),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: const Color(0xFFFF4500),
              child: Icon(feature['icon'] as IconData, color: Colors.white),
            ),
            title: Text(
              feature['title'] as String,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(feature['description'] as String),
          ),
        );
      },
    );
  }

  Widget _buildTermsOfUseList() {
    final features = [
      {
        'icon': Icons.verified_user,
        'title': 'User Responsibility and Accuracy of Information',
        'description':
            'Users must provide accurate information. Misrepresentation may lead to account suspension.'
      },
      {
        'icon': Icons.payment,
        'title': 'Payments and Points',
        'description':
            'Payments are final, and points can only be used within the app as intended.'
      },
      {
        'icon': Icons.lock,
        'title': 'Data Privacy and Collection',
        'description':
            'We collect and use data per our Privacy Policy, ensuring it’s protected and not shared without permission.'
      },
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: features.length,
      itemBuilder: (context, index) {
        final feature = features[index];
        return Card(
          elevation: 2,
          color: const Color(0xFFFFF0E6),
          margin: const EdgeInsets.only(bottom: 16),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: const Color(0xFFFF4500),
              child: Icon(feature['icon'] as IconData, color: Colors.white),
            ),
            title: Text(
              feature['title'] as String,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(feature['description'] as String),
          ),
        );
      },
    );
  }
}

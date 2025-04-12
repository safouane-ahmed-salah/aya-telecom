import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final double accountBalance = 10459696.00; // رصيد افتراضي، يمكن تغييره لاحقًا

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('assets/logo.png', height: 40),
            SizedBox(width: 10),
            Text('AYA Telecom'),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'الرصيد المتاح:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '${accountBalance} د.ج',
              style: TextStyle(fontSize: 32, color: Colors.green[700]),
            ),
            SizedBox(height: 24),
            Text(
              'الخدمات',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                children: [
                  ServiceCard(
                    icon: Icons.phone_android,
                    label: 'تعبئة الرصيد',
                    onTap: () {
                      // هنا يمكن التنقل إلى صفحة تعبئة الرصيد
                    },
                  ),
                  ServiceCard(
                    icon: Icons.wifi,
                    label: 'دفع الإنترنت',
                    onTap: () {
                      // صفحة دفع الانترنت
                    },
                  ),
                  ServiceCard(
                    icon: Icons.add_home,
                    label: 'طلب تركيب إنترنت',
                    onTap: () {
                      // صفحة طلب تركيب
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const ServiceCard({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.circular(16),
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 36, color: Colors.blueAccent),
            SizedBox(height: 12),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

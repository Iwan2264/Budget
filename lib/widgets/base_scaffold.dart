import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/navigation_controller.dart';
import '../pages/home/homepage.dart';
import '../controllers/settings_controller.dart';
import '../pages/settings/widget/profile_widget.dart';

class BaseScaffold extends StatelessWidget {
  final String? titleText;
  final Widget? child;

  const BaseScaffold({super.key, this.titleText, this.child});

  @override
  Widget build(BuildContext context) {
    final navController = Get.find<NavigationController>();
    final settingsController = Get.find<SettingsController>();

    final pages = [
      // Search page - empty for now
      const Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.search, size: 100, color: Colors.grey),
              SizedBox(height: 20),
              Text('Search', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              Text('Coming soon...', style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ),
      
      // Home page
      const HomePage(),
      
      // Settings page
      Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: Obx(() => Column(
          children: [
            // Profile widget at the top
            ProfileInfoWidget(controller: settingsController),
            const SizedBox(height: 16),
            // Settings list
            Expanded(
              child: ListView.builder(
                itemCount: settingsController.settings.length,
                itemBuilder: (context, index) {
                  final setting = settingsController.settings[index];
                  return ListTile(
                    leading: _getSettingIcon(setting),
                    title: Text(setting),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => settingsController.navigateToSetting(setting),
                  );
                },
              ),
            ),
          ],
        )),
      ),
    ];

    return Obx(() {
      return Scaffold(
        appBar: titleText != null
            ? AppBar(
                title: Text(titleText!),
                centerTitle: true,
              )
            : null,
        body: child ?? IndexedStack(
          index: navController.selectedIndex.value,
          children: pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: navController.selectedIndex.value,
          onTap: (index) => navController.selectedIndex.value = index,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          ],
        ),
      );
    });
  }

  Icon _getSettingIcon(String setting) {
    switch (setting) {
      case 'Account':
        return const Icon(Icons.person);
      case 'Budget Settings':
        return const Icon(Icons.savings);
      case 'Notifications':
        return const Icon(Icons.notifications);
      case 'Export Data':
        return const Icon(Icons.file_download);
      case 'Language':
        return const Icon(Icons.language);
      case 'Appearance':
        return const Icon(Icons.palette);
      case 'Help & Support':
        return const Icon(Icons.help);
      case 'About':
        return const Icon(Icons.info);
      case 'Logout':
        return const Icon(Icons.logout, color: Colors.red);
      default:
        return const Icon(Icons.settings);
    }
  }
}

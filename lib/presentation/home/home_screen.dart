import 'package:flutter/material.dart';
import 'package:mcq/manager/image_manager.dart';
import 'package:mcq/presentation/home/pages/home_page.dart';
import 'package:mcq/presentation/profile/profile_screen.dart';
import '../QP_subject/QP_subject_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const[HomePage(),QPSubjectListScreen(),ProfileScreen()][selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index){
          setState(() {
            selectedIndex = index;
          });
        },
        currentIndex: selectedIndex,
        items: [
          BottomNavigationBarItem(

              label: "Home",
              icon: Image.asset(selectedIndex == 0 ?
              appImages.selectedHome :  appImages.unselectedHome,
              height: 24,width: 24,)),
          BottomNavigationBarItem(
              label: "QP",
              icon: Image.asset(selectedIndex == 1 ?
                appImages.selectedQP :  appImages.unselectedQP,
                height: 24,width: 24,)),
          BottomNavigationBarItem(
              label: "Profile",
              icon: Image.asset(selectedIndex == 2 ?
              appImages.selectedProfile :  appImages.unselectedProfile,
                height: 24,width: 24,)),
        ],),
    );
  }
}

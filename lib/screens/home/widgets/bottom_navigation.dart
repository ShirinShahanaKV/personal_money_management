import 'package:flutter/material.dart';
import 'package:personal_money_management_app/screens/home/screen_home.dart';


class BottomNavigation extends StatelessWidget {
 const  BottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable:ScreenHome.selectedIndexNotifier,
        builder:(BuildContext context, int updatedIndex, _){
          return BottomNavigationBar(
              selectedItemColor:Colors.deepOrange,
              unselectedItemColor:Colors.grey,
              currentIndex: updatedIndex,
              onTap: (newIndex){
                ScreenHome.selectedIndexNotifier.value=newIndex;
              },
              items:const [
                BottomNavigationBarItem(icon: Icon(Icons.home),
                    label :"home"),
                BottomNavigationBarItem(icon: Icon(Icons.category),
                    label :"category"),] );
        }

    );
  }
}

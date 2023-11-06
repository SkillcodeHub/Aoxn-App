import 'package:axonweb/view/News/news_screen.dart';
import 'package:axonweb/view/report/report_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Book/book_appointment_screen.dart';
import '../event/event_screen.dart';

import 'package:sizer/sizer.dart';
class MyNavigationBar extends StatelessWidget {
  final int indexNumber;

  const MyNavigationBar({Key? key, required this.indexNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ValueNotifier<int>>(
      create: (_) => ValueNotifier<int>(indexNumber),
      child: Consumer<ValueNotifier<int>>(
        builder: (context, selectedIndexProvider, _) {
          final selectedIndex = selectedIndexProvider.value;

          final List<Widget> user = [
            NewsScreen(),
            BookApointmentScreen(),
            EventScreen(),
            ReportScreen(),
          ];

          void _onItemTapped(int index) {
            selectedIndexProvider.value = index;
          }

          return Scaffold(
            body: user[selectedIndex],
            bottomNavigationBar:  SizerUtil.deviceType == DeviceType.mobile ? BottomNavigationBar(
              items:  <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.newspaper,
                    size: 30,
                  ),
                  label: 'News',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.book_outlined,
                    size: 30,
                  ),
                  label: 'Book',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.event_note_sharp,
                    size: 30,
                  ),
                  label: 'Events',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.image_search_rounded,
                    size: 30,
                  ),
                  label: 'Reports',
                ),
              ],
              currentIndex: selectedIndex,
              onTap: _onItemTapped,
              type: BottomNavigationBarType.fixed,
              elevation: 5,
              selectedItemColor: const Color(0xFFFD5722),
              unselectedItemColor: Colors.grey.shade600,
            ) : BottomNavigationBar(
              items:  <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.newspaper,
                    size: 4.h,
                  ),
                  label: 'News',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.book_outlined,
                    size:4.h,
                  ),
                  label: 'Book',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.event_note_sharp,
                    size: 4.h,
                  ),
                  label: 'Events',
                  
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.image_search_rounded,
                    size: 4.h,
                  ),
                  label: 'Reports',
                ),
              ],
              selectedLabelStyle: TextStyle(fontSize: 20), // Adjust the font size
  unselectedLabelStyle: TextStyle(fontSize: 20), 
              currentIndex: selectedIndex,
              onTap: _onItemTapped,
              type: BottomNavigationBarType.fixed,
              elevation: 5,
              selectedItemColor: const Color(0xFFFD5722),
              unselectedItemColor: Colors.grey.shade600,
            ),
          );
        },
      ),
    );
  }
}



















// class MyNavigationBar extends StatefulWidget {
//   final int indexNumber;

//   // const MyNavigationBar({super.key});
//   const MyNavigationBar({Key? key, required this.indexNumber})
//       : super(key: key);
//   @override
//   State<MyNavigationBar> createState() => _MyNavigationBarState();
// }

// class _MyNavigationBarState extends State<MyNavigationBar> {
//   // int _selectedIndex = 0;
//   int selectedIndex = 0;
//   int? selectedIndex1;

//   // _MyNavigationBarState(this.selectedIndex);
//   final List<Widget> user = [
//     NewsScreen(),
//     BookApointmentScreen(),
//     EventScreen(),
//     ReportScreen(),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       selectedIndex = index;
//       print(selectedIndex);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     selectedIndex = widget.indexNumber.toInt();

//     print('MynavigationBarMynavigationBarMynavigationBarMynavigationBar');
//     return Scaffold(
//       body: user[selectedIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(
//               Icons.newspaper,
//               size: 30,
//             ),
//             label: 'News',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(
//               Icons.book_outlined,
//               size: 30,
//             ),
//             label: 'Book',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(
//               Icons.event_note_sharp,
//               size: 30,
//             ),
//             label: 'Events',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(
//               Icons.image_search_rounded,
//               size: 30,
//             ),
//             label: 'Reports',
//           ),
//         ],
//         currentIndex: selectedIndex,
//         onTap: _onItemTapped,
//         type: BottomNavigationBarType.fixed,
//         elevation: 5,
//         selectedItemColor: const Color(0xFFFD5722),
//         unselectedItemColor: Colors.grey.shade600,
//       ),
//     );
//   }
// }

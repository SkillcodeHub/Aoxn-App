import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class MyProvider1 extends ChangeNotifier {
  String textValue1 = 'Text 1';
  String textValue2 = 'Text 2';

  void updateTextValues(String newValue1, String newValue2) {
    textValue1 = newValue1;
    textValue2 = newValue2;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('aaaaaaa');
    final myProvider = Provider.of<MyProvider1>(context, listen: false);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Text Values'),
        ),
        body: Center(
          child: Column(
            children: [
              Consumer<MyProvider1>(
                builder: (context, myProvider, _) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        myProvider.textValue1,
                        style: TextStyle(fontSize: 24),
                      ),
                      SizedBox(height: 20),
                      Text(
                        myProvider.textValue2,
                        style: TextStyle(fontSize: 24),
                      ),
                      SizedBox(height: 20),
                    ],
                  );
                },
              ),
              Consumer<MyProvider1>(
                builder: (context, myProvider, _) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        myProvider.textValue1,
                        style: TextStyle(fontSize: 24),
                      ),
                      SizedBox(height: 20),
                      Text(
                        myProvider.textValue2,
                        style: TextStyle(fontSize: 24),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          print('object');
                          Future.delayed(Duration.zero, () {
                            myProvider.updateTextValues(
                              'New Value 1 ${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}',
                              'New Value 2',
                            );
                          });
                        },
                        child: Text('Update Values'),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

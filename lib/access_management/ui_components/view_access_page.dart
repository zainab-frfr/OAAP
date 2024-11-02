import 'package:flutter/material.dart';
import 'package:oaap/access_management/model/client_cat_acc_model.dart';
import 'package:oaap/access_management/provider/access_notifier.dart';
import 'package:oaap/global/global%20widgets/my_chips.dart';
import 'package:provider/provider.dart';

class ViewAccessPage extends StatefulWidget {
  const ViewAccessPage({super.key});

  @override
  State<ViewAccessPage> createState() => _ViewAccessPageState();
}

class _ViewAccessPageState extends State<ViewAccessPage> {
  List<bool> _isExpanded = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      //executes after widget is built
      await context.read<AccessNotifier>().getAccess();
      setState(() {
        _isExpanded = List<bool>.filled(
          context.read<AccessNotifier>().accessList.length, 
          false,
        );
      });
    });
    super.initState();
  }

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    setState(() {
      _isExpanded = List<bool>.filled(
          context.read<AccessNotifier>().accessList.length, 
          false,
        );
    });
  }

  @override
  Widget build(BuildContext context) {
    // each object contains string of client name, and map with key category and value access list.
    List<ClientCategoryAccess> accessList = context.watch<AccessNotifier>().accessList;

    bool fetchedAccess = context.watch<AccessNotifier>().fetchedAccess;

    return 
    (fetchedAccess)
    ? ListView(
      children: [
        ExpansionPanelList(
            animationDuration: const Duration(milliseconds: 500),
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                _isExpanded[index] = isExpanded;
              });
            },
            children: accessList.asMap().entries.map((entry) {
              int index = entry.key;
              ClientCategoryAccess modelInstance = entry.value; // a singular instance of the model 

              return ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    title: Text(
                      modelInstance.client,
                      style: TextStyle(
                          fontWeight: (_isExpanded[2])
                              ? FontWeight.bold
                              : FontWeight.normal),
                    ),
                  );
                },
                body: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: modelInstance.categoryAccess.entries.map((entryTwo) {
                            String category = entryTwo.key;
                            List<String> accessEmails = entryTwo.value;

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(category),
                                MyChips(items: accessEmails),
                                const SizedBox(height: 10),
                              ],
                            );
                          }).toList())),
                ),
                isExpanded: _isExpanded[index],
              );
            }).toList()),
        const SizedBox(
          height: 20,
        )
      ],
    )
    : const Center(child: CircularProgressIndicator(),);

    // ListView(
    //       children: [
    //         ExpansionPanelList(
    //           animationDuration: const Duration(milliseconds: 500),
    //           expansionCallback: (int index, bool isExpanded) {
    //             setState(() {
    //               _isExpanded[index] = isExpanded;
    //             });
    //           },
    //           children: [
    //             ExpansionPanel(
    //               headerBuilder: (BuildContext context, bool isExpanded) {
    //                 return ListTile(
    //                   title: Text(
    //                     'Client 1',
    //                     style: TextStyle(
    //                         fontWeight: (_isExpanded[0])
    //                             ? FontWeight.bold
    //                             : FontWeight.normal),
    //                   ),
    //                 );
    //               },
    //               body: const Padding(
    //                 padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
    //                 child: Align(
    //                     alignment: Alignment.topLeft,
    //                     child: Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         Text('category 1'),
    //                         MyChips(
    //                           items: [
    //                             'ambar@gmail.com',
    //                             'aun@gmail.com',
    //                             'zainab@gmail.com'
    //                           ],
    //                         ),
    //                         SizedBox(
    //                           height: 10,
    //                         ),
    //                         Text('category 2'),
    //                         MyChips(
    //                           items: [
    //                             'ambar@gmail.com',
    //                             'aun@gmail.com',
    //                             'ambar@gmail.com',
    //                             'aun@gmail.com'
    //                           ],
    //                         ),
    //                         SizedBox(
    //                           height: 10,
    //                         ),
    //                         Text('category 3'),
    //                         MyChips(
    //                           items: [
    //                             'ambar@gmail.com',
    //                             'aun@gmail.com',
    //                             'ambar@gmail.com',
    //                             'aun@gmail.com',
    //                             'ambar@gmail.com',
    //                             'aun@gmail.com'
    //                           ],
    //                         ),
    //                       ],
    //                     )),
    //               ),
    //               isExpanded: _isExpanded[0],
    //             ),
    //             ExpansionPanel(
    //               headerBuilder: (BuildContext context, bool isExpanded) {
    //                 return ListTile(
    //                   title: Text(
    //                     'Client 2',
    //                     style: TextStyle(
    //                         fontWeight: (_isExpanded[1])
    //                             ? FontWeight.bold
    //                             : FontWeight.normal),
    //                   ),
    //                 );
    //               },
    //               body: const Padding(
    //                 padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
    //                 child: Align(
    //                     alignment: Alignment.topLeft,
    //                     child: Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         Text('category 1'),
    //                         MyChips(
    //                           items: [
    //                             'ambar@gmail.com',
    //                             'aun@gmail.com',
    //                             'zainab@gmail.com'
    //                           ],
    //                         ),
    //                         SizedBox(
    //                           height: 10,
    //                         ),
    //                         Text('category 2'),
    //                         MyChips(
    //                           items: ['ambar@gmail.com', 'aun@gmail.com'],
    //                         ),
    //                       ],
    //                     )),
    //               ),
    //               isExpanded: _isExpanded[1],
    //             ),
    //             ExpansionPanel(
    //               headerBuilder: (BuildContext context, bool isExpanded) {
    //                 return ListTile(
    //                   title: Text(
    //                     'Client 3',
    //                     style: TextStyle(
    //                         fontWeight: (_isExpanded[2])
    //                             ? FontWeight.bold
    //                             : FontWeight.normal),
    //                   ),
    //                 );
    //               },
    //               body: const Padding(
    //                 padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
    //                 child: Align(
    //                     alignment: Alignment.topLeft,
    //                     child: Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         Text('category 1'),
    //                         MyChips(
    //                           items: [
    //                             'ambar@gmail.com',
    //                             'aun@gmail.com',
    //                             'ambar@gmail.com',
    //                             'aun@gmail.com',
    //                             'ambar@gmail.com',
    //                             'aun@gmail.com'
    //                           ],
    //                         ),
    //                         SizedBox(
    //                           height: 10,
    //                         ),
    //                         Text('category 2'),
    //                         MyChips(
    //                           items: [
    //                             'ambar@gmail.com',
    //                             'aun@gmail.com',
    //                             'ambar@gmail.com',
    //                             'aun@gmail.com'
    //                           ],
    //                         ),
    //                       ],
    //                     )),
    //               ),
    //               isExpanded: _isExpanded[2],
    //             ),
    //           ],
    //         ),
    //       ],
    //     );
  }
}

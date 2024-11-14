import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oaap/access_management/bloc/access_bloc.dart';
import 'package:oaap/access_management/data/client_cat_acc_model.dart';
import 'package:oaap/global/global%20widgets/my_chips.dart';

class ViewAccessPage extends StatefulWidget {
  const ViewAccessPage({super.key});

  @override
  State<ViewAccessPage> createState() => _ViewAccessPageState();
}

class _ViewAccessPageState extends State<ViewAccessPage> {
  List<bool> _isExpanded = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      //executes after widget is built
      //await context.read<AccessNotifier>().getAccess();
      context.read<AccessBloc>().add(const FetchAccessInformation());
      //AccessState state = context.read<AccessBloc>().state;
      // while(state is LoadingState){debugPrint('in loop');}
      // state = context.read<AccessBloc>().state;
      // if(state is FetchedAccessInformation){
      //   _isExpanded = List<bool>.filled(state.accessList.length, false);
      // }
      
      // _isExpanded = List<bool>.filled(
      //   // ignore: use_build_context_synchronously
      //   context.read<AccessNotifier>().accessList.length,
      //   false,
      // );
    });
    super.initState();
  }

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    final state = context.read<AccessBloc>().state;
    if (state is FetchedAccessInformation && _isExpanded.isEmpty) {
      setState(() {
        _isExpanded = List<bool>.filled(state.accessList.length, false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // each object contains string of client name, and map with key category and value access list.
    // List<ClientCategoryAccess> accessList = context.watch<AccessNotifier>().accessList;

    // bool fetchedAccess = context.watch<AccessNotifier>().fetchedAccess;

    return BlocListener<AccessBloc, AccessState>(
      listener: (context, state) {
        if (state is AccessPopUpMessage) {
          // Show success snackbar when the data is fetched
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text(state.message),
          ));
        }
      },
      child: BlocBuilder<AccessBloc, AccessState>(
        builder: (context, state) {
          switch (state) {
            case LoadingState():
              return const Center(
                child: CircularProgressIndicator(),
              );
            case FetchedAccessInformation():
              // Ensure _isExpanded is initialized on the first build
              if (_isExpanded.length != state.accessList.length) {
                _isExpanded = List<bool>.filled(state.accessList.length, false);
              }
              return ListView(
                children: [
                  ExpansionPanelList(
                      animationDuration: const Duration(milliseconds: 500),
                      expansionCallback: (int index, bool isExpanded) {
                        setState(() {
                          _isExpanded[index] = !_isExpanded[index];
                        });
                      },
                      children: state.accessList.asMap().entries.map((entry) {
                        int index = entry.key;
                        ClientCategoryAccess modelInstance = entry.value; // a singular instance of the model

                        return ExpansionPanel(
                          headerBuilder:
                              (BuildContext context, bool isExpanded) {
                            return ListTile(
                              title: Text(
                                modelInstance.client,
                                style: TextStyle(
                                    fontWeight: (_isExpanded[index])
                                        ? FontWeight.bold
                                        : FontWeight.normal),
                              ),
                            );
                          },
                          body: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            child: Align(
                                alignment: Alignment.topLeft,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: modelInstance
                                        .categoryAccess.entries
                                        .map((entryTwo) {
                                      String category = entryTwo.key;
                                      List<String> accessEmails =
                                          entryTwo.value;

                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
              );
            case AccessError():
              return Center(
                child: Text(state.error),
              );
            default:
              return Container();
          }
        },
      ),
    );
  }
}

/*
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
                          fontWeight: (_isExpanded[index])
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
    : const Center(child: CircularProgressIndicator(),);*/

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

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oaap/performance_reports/bloc/performance%20bloc/performance_bloc.dart';
import 'package:oaap/performance_reports/ui/widgets/kpi_row.dart';
import 'package:oaap/performance_reports/ui/widgets/percentage_indicator.dart';

class EmployeePerformanceReport extends StatefulWidget {
  final String userEmail;
  final String userName;
  const EmployeePerformanceReport({super.key, required this.userEmail, required this.userName});

  @override
  State<EmployeePerformanceReport> createState() => _EmployeePerformanceReportState();
}

class _EmployeePerformanceReportState extends State<EmployeePerformanceReport> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      context.read<PerformanceBloc>().add( FetchPerformanceInformation(email: widget.userEmail));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Performance Report',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Text(
                widget.userName ,
                style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
              ),

            ],
          ),
        ),
        
      ),
      persistentFooterAlignment: AlignmentDirectional.center,
      persistentFooterButtons: [
        InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(20),
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Text('Share as PDF!'),
          ),
        )
      ],
      body: BlocBuilder<PerformanceBloc, PerformanceState>(
        builder: (context, state) {
          switch(state){
            case PerformanceLoadingState():
              return const Center(child: CircularProgressIndicator(),);
            case PerformanceErrorState():
              return Center(child: Text('Error Loading Report: ${state.error}'),);
            case FetchedPerformance():
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    MyPercentageIndicator(
                      percentage: state.performance.onTimeRate,
                      label: 'On-time Task Completion Rate',
                      late: false,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MyPercentageIndicator(
                      percentage: state.performance.lateTaskRate,
                      label: 'Late Task Completion Rate',
                      late: true,
                    ),
                    const SizedBox(height: 40,),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: DottedLine(
                        dashLength: 4,
                        dashColor: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: MyKPIRow(
                          colorOne: Colors.purple,
                          colorTwo: Colors.green,
                          kpiOne: 'Overdue Tasks',
                          kpiTwo: 'Pending Tasks',
                          countOne: '${state.performance.overdueTasks}',
                          countTwo: '${state.performance.pendingTasks}'),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: DottedLine(
                        dashLength: 4,
                        dashColor: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: MyKPIRow(
                          colorOne: Colors.red,
                          colorTwo: Colors.orange,
                          kpiOne: 'Completed Tasks',
                          kpiTwo: 'Total Tasks     ',
                          countOne: '${state.performance.completedTasks}',
                          countTwo: '${state.performance.totalTasks}'),
                    ),
                  ],
                ),
              );
          }
        },
      )
    );
  }
}

/*
const Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            MyPercentageIndicator(
              percentage: 0.756,
              label: 'On-time Task Completion Rate',
              late: false,
            ),
            SizedBox(
              height: 20,
            ),
            MyPercentageIndicator(
              percentage: 0.43,
              label: 'Late Task Completion Rate',
              late: true,
            ),
            SizedBox(height: 40,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: DottedLine(
                dashLength: 4,
                dashColor: Colors.grey,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: MyKPIRow(
                  colorOne: Colors.purple,
                  colorTwo: Colors.green,
                  kpiOne: 'Overdue Tasks',
                  kpiTwo: 'Pending Tasks',
                  countOne: '1',
                  countTwo: '2'),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: DottedLine(
                dashLength: 4,
                dashColor: Colors.grey,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: MyKPIRow(
                  colorOne: Colors.red,
                  colorTwo: Colors.orange,
                  kpiOne: 'Completed Tasks',
                  kpiTwo: 'Total Tasks     ',
                  countOne: '4',
                  countTwo: '7'),
            ),
          ],
        ),
      ),
*/

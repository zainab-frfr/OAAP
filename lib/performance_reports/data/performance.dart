class Performance{
  final double onTimeRate;
  final double lateTaskRate;
  final int overdueTasks;
  final int pendingTasks; 
  final int completedTasks; 
  final int totalTasks;

  const Performance({
    required this.onTimeRate,
    required this.lateTaskRate,
    required this.overdueTasks,
    required this.pendingTasks, 
    required this.completedTasks, 
    required this.totalTasks
  });

  factory Performance.fromJson(Map<String, dynamic> fetchedTask){
    return Performance(
      onTimeRate: fetchedTask['onTimeRate'],
      lateTaskRate: fetchedTask['lateTaskRate'],
      overdueTasks: fetchedTask['overdueTasks'], 
      pendingTasks: fetchedTask['pendingTasks'], 
      completedTasks: fetchedTask['completedTasks'],
      totalTasks: fetchedTask['totalTasks']
    );
  }
}
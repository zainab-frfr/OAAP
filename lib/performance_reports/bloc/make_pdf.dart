import 'dart:typed_data';

import 'package:oaap/performance_reports/data/performance.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

Future<Uint8List> makePdf(Performance performance, String userName) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          children: [
            pw.SizedBox(height: 20),
            pw.Text(
              'Performance Report',
              style: pw.TextStyle(
                fontSize: 24, 
                fontWeight: pw.FontWeight.bold, 
              ),
            ),
            pw.Text(
              userName,
              style: pw.TextStyle(
                fontSize: 15, 
                fontWeight: pw.FontWeight.normal, 
              ),
            ),
            pw.SizedBox(height: 50),
            _buildPercentageIndicator(
              performance.onTimeRate,
              'On-time Task Completion Rate',
              late: false,
            ),
            pw.SizedBox(height: 20),
            _buildPercentageIndicator(
              performance.lateTaskRate,
              'Late Task Completion Rate',
              late: true,
            ),
            pw.SizedBox(height: 40),
            _buildDottedLine(),
            pw.Padding(
              padding: const pw.EdgeInsets.all(20.0),
              child: _buildKPIRow(
                colorOne: const PdfColor.fromInt(0xFF9C27B0), // Purple
                colorTwo: const PdfColor.fromInt(0xFF4CAF50), // Green
                kpiOne: 'Overdue Tasks',
                kpiTwo: 'Pending Tasks',
                countOne: '${performance.overdueTasks}',
                countTwo: '${performance.pendingTasks}',
              ),
            ),
            _buildDottedLine(),
            pw.Padding(
              padding: const pw.EdgeInsets.all(20.0),
              child: _buildKPIRow(
                colorOne: const PdfColor.fromInt(0xFFF44336), // Red
                colorTwo: const PdfColor.fromInt(0xFFFF9800), // Orange
                kpiOne: 'Completed Tasks',
                kpiTwo: 'Total Tasks',
                countOne: '${performance.completedTasks}',
                countTwo: '${performance.totalTasks}',
              ),
            ),
          ],
        );
      },
    ),
  );

  return pdf.save();
}

pw.Widget _buildPercentageIndicator(double percentage, String label, {required bool late}) {
  return pw.Column(
    children: [
      pw.Text(
        label,
        style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
      ),
      pw.SizedBox(height: 5),
      pw.Container(
        width: 100,
        height: 100,
        child: pw.Center(
          child: pw.Text(
            '${(percentage * 100).toStringAsFixed(1)}%',
            style: pw.TextStyle(
              fontSize: 20,
              color: late ? const PdfColor.fromInt(0xFFF44336) : const PdfColor.fromInt(0xFF4CAF50),
            ),
          ),
        ),
        decoration: pw.BoxDecoration(
          shape: pw.BoxShape.circle,
          border: pw.Border.all(
            color: late ? const PdfColor.fromInt(0xFFF44336) : const PdfColor.fromInt(0xFF4CAF50),
            width: 3,
          ),
        ),
      ),
    ],
  );
}

pw.Widget _buildDottedLine() {
  return pw.Container(
    height: 1,
    decoration: const pw.BoxDecoration(
      border: pw.Border(
        bottom: pw.BorderSide(color:  PdfColor.fromInt(0xFFFFFFFF), width: 1, style: pw.BorderStyle.dashed),
      ),
    ),
  );
}

pw.Widget _buildKPIRow({
  required PdfColor colorOne,
  required PdfColor colorTwo,
  required String kpiOne,
  required String kpiTwo,
  required String countOne,
  required String countTwo,
}) {
  return pw.Row(
    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
    children: [
      _buildKPIBox(color: colorOne, label: kpiOne, count: countOne),
      _buildKPIBox(color: colorTwo, label: kpiTwo, count: countTwo),
    ],
  );
}

pw.Widget _buildKPIBox({
  required PdfColor color,
  required String label,
  required String count,
}) {
  return pw.Container(
    padding: const pw.EdgeInsets.all(8),
    width: 120,
    decoration: pw.BoxDecoration(
      color: color,
      borderRadius: pw.BorderRadius.circular(8),
    ),
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      children: [
        pw.Text(
          label,
          style: const pw.TextStyle(color:  PdfColor.fromInt(0xFFFFFFFF), fontSize: 12),
          textAlign: pw.TextAlign.center,
        ),
        pw.SizedBox(height: 5),
        pw.Text(
          count,
          style: pw.TextStyle(
            color: const PdfColor.fromInt(0xFFFFFFFF),
            fontSize: 18,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

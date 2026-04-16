import 'package:easy_localization/easy_localization.dart';
import 'package:edu_center_manager/core/utils/app_style.dart';
import 'package:edu_center_manager/core/utils/app_themes.dart';
import 'package:edu_center_manager/core/widgets/custom_empty_state.dart';
import 'package:edu_center_manager/features/students/data/models/student_model.dart';
import 'package:edu_center_manager/features/students/presentation/view_model/grade_helper.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomDesktopStudentTable extends StatelessWidget {
  final List<StudentModel> students;
  final Function(StudentModel) onEdit;
  final Function(StudentModel) onDelete;
  final bool isLoading;

  const CustomDesktopStudentTable({
    super.key,
    required this.students,
    required this.onEdit,
    required this.onDelete,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return _buildSkeleton(context);
    }

    if (students.isEmpty) {
      return CustomEmptyState(text: 'studentsViewEmptyNone'.tr(), icon: Icons.groups_3_rounded);
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Expanded(
        child: Theme(
          data: Theme.of(
            context,
          ).copyWith(dividerColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.5)),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: BoxConstraints(minWidth: constraints.maxWidth),
                  child: DataTable(
                    sortAscending: true,
                    sortColumnIndex: 0,
                    headingRowColor: MaterialStateProperty.all(
                      Theme.of(context).colorScheme.surfaceContainer,
                    ),
                    dataRowMaxHeight: 64,
                    dataRowMinHeight: 64,
                    headingTextStyle: AppStyles.styleBold16(
                      context,
                    ).copyWith(color: Theme.of(context).colorScheme.onSurface),
                    columns: [
                      DataColumn(label: Text('studentName'.tr())),
                      DataColumn(label: Text('grade'.tr())),
                      DataColumn(label: Text('address'.tr())),
                      DataColumn(label: Text('parentPhone'.tr())),
                      DataColumn(label: Text('actions'.tr())),
                    ],
                    rows: students.map((student) => _buildRow(student, context)).toList(),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  DataRow _buildRow(StudentModel student, BuildContext context) {
    return DataRow(
      cells: [
        DataCell(
          Text(
            student.name,
            style: const TextStyle(
              fontFamily: 'cairo',
              color: AppColors.nightAbyss,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        DataCell(
          Text(
            GradeHelper.translateGrade(student.grade),
            style: const TextStyle(fontFamily: 'cairo'),
          ),
        ),
        DataCell(Text(student.address ?? '-', style: const TextStyle(fontFamily: 'cairo'))),
        DataCell(
          Text(
            student.parentPhone ?? '-',
            style: const TextStyle(fontFamily: 'cairo'),
            // textDirection: TextDirection.ltr,
          ),
        ),
        DataCell(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.edit_outlined, color: AppColors.skyBright, size: 20),
                onPressed: () => onEdit(student),
                tooltip: 'edit'.tr(),
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.redAccent, size: 20),
                onPressed: () => onDelete(student),
                tooltip: 'delete'.tr(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSkeleton(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: List.generate(
          5,
          (index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Row(
                children: [
                  Expanded(flex: 2, child: Container(height: 16, color: Colors.white)),
                  const SizedBox(width: 16),
                  Expanded(flex: 1, child: Container(height: 16, color: Colors.white)),
                  const SizedBox(width: 16),
                  Expanded(flex: 2, child: Container(height: 16, color: Colors.white)),
                  const SizedBox(width: 16),
                  Expanded(flex: 1, child: Container(height: 16, color: Colors.white)),
                  const SizedBox(width: 16),
                  Expanded(flex: 1, child: Container(height: 16, color: Colors.white)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

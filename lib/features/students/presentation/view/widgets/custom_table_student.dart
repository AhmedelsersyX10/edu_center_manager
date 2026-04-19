import 'package:easy_localization/easy_localization.dart';
import 'package:edu_center_manager/core/utils/app_style.dart';
import 'package:edu_center_manager/core/utils/app_themes.dart';
import 'package:edu_center_manager/features/students/data/models/student_model.dart';
import 'package:edu_center_manager/features/students/presentation/view_model/grade_helper.dart';
import 'package:flutter/material.dart';

class CustomTableStudent extends StatelessWidget {
  const CustomTableStudent({
    super.key,
    required this.students,
    required this.onEdit,
    required this.onDelete,
    required this.isLoading,
  });
  final List<StudentModel> students;
  final Function(StudentModel) onEdit;
  final Function(StudentModel) onDelete;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
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
        DataCell(Text(student.address, style: const TextStyle(fontFamily: 'cairo'))),
        DataCell(
          Text(
            student.parentPhone,
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
}

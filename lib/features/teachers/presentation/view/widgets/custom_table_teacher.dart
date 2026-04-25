import 'package:easy_localization/easy_localization.dart';
import 'package:edu_center_manager/core/utils/app_style.dart';
import 'package:edu_center_manager/core/utils/app_themes.dart';
import 'package:edu_center_manager/features/teachers/data/models/teacher_model.dart';
import 'package:edu_center_manager/features/teachers/presentation/view_model/subject_helper.dart';
import 'package:flutter/material.dart';

class CustomTableTeacher extends StatelessWidget {
  final List<TeacherModel> teachers;
  final void Function(TeacherModel) onEdit;
  final void Function(TeacherModel) onDelete;
  final bool isLoading;

  const CustomTableTeacher({
    super.key,
    required this.teachers,
    required this.onEdit,
    required this.onDelete,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: context.colors.cardBackground,
      ),
      clipBehavior: Clip.antiAlias,
      child: Theme(
        data: Theme.of(context),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: constraints.maxWidth),
                child: DataTable(
                  dataRowMaxHeight: 64,
                  dataRowMinHeight: 64,
                  headingTextStyle: const TextStyle(
                    fontFamily: 'cairo',
                    fontWeight: FontWeight.bold,
                  ),
                  columns: [
                    DataColumn(label: Text('teacherName'.tr())),
                    DataColumn(label: Text('subject'.tr())),
                    DataColumn(label: Text('phone'.tr())),
                    DataColumn(label: Text('actions'.tr())),
                  ],
                  rows: teachers.map((teacher) => _buildRow(teacher, context)).toList(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  DataRow _buildRow(TeacherModel teacher, BuildContext context) {
    return DataRow(
      cells: [
        DataCell(Text(teacher.name, style: AppStyles.styleBold16(context))),
        DataCell(
          Text(
            SubjectHelper.translateSubject(teacher.subject),
            style: AppStyles.styleRegular16(context),
          ),
        ),
        DataCell(
          Text(
            teacher.phone?.isNotEmpty == true ? teacher.phone! : '—',
            style: AppStyles.styleRegular16(context),
          ),
        ),
        DataCell(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.edit_outlined, size: 20),
                onPressed: () => onEdit(teacher),
                tooltip: 'edit'.tr(),
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.redAccent, size: 20),
                onPressed: () => onDelete(teacher),
                tooltip: 'delete'.tr(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:edu_center_manager/core/utils/app_style.dart';
import 'package:edu_center_manager/core/utils/app_themes.dart';
import 'package:edu_center_manager/features/students/data/models/student_model.dart';
import 'package:edu_center_manager/features/students/presentation/view_model/grade_helper.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class StudentForm extends StatefulWidget {
  final Future<void> Function(StudentModel) onSubmit;
  final StudentModel? student;

  const StudentForm({super.key, required this.onSubmit, this.student, required bool isMobile});

  @override
  State<StudentForm> createState() => _StudentFormState();
}

class _StudentFormState extends State<StudentForm> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  String? selectedGrade;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.student != null) {
      nameController.text = widget.student!.name;
      addressController.text = widget.student!.address ?? '';
      phoneController.text = widget.student!.parentPhone ?? '';

      final currentGrade = GradeHelper.gradeKeys(widget.student!.grade);
      if (currentGrade != '--' && GradeHelper.selectGradeKeys.contains(currentGrade)) {
        selectedGrade = currentGrade;
      }
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      final newStudent = StudentModel(
        id: widget.student?.id ?? const Uuid().v4(),
        name: nameController.text.trim(),
        address: addressController.text.trim(),
        parentPhone: phoneController.text.trim(),
        grade: selectedGrade ?? '',
      );

      await widget.onSubmit(newStudent);

      if (mounted) {
        setState(() => _isLoading = false);
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isEdit = widget.student != null;
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 60,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              Text(
                isEdit ? 'editStudent'.tr() : 'addNewStudent'.tr(),
                style: AppStyles.styleBold20(context),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              _buildTextField(
                controller: nameController,
                label: 'studentName'.tr(),
                icon: Icons.person_outline,
                validator: (val) {
                  if (val == null || val.trim().isEmpty) return 'studentNameRequired'.tr();
                  return null;
                },
              ),
              const SizedBox(height: 16),
              buildDropdownGrade(context),
              const SizedBox(height: 16),
              _buildTextField(
                controller: addressController,
                label: 'address'.tr(),
                icon: Icons.location_on_outlined,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: phoneController,
                label: 'parentPhone'.tr(),
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value != null && value.isNotEmpty && value.length < 11) {
                    return 'invalidPhone'.tr();
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              buildElevatedButton(context),
            ],
          ),
        ),
      ),
    );
  }

  ElevatedButton buildElevatedButton(BuildContext context) {
    bool isEdit = widget.student != null;
    return ElevatedButton(
      onPressed: _isLoading ? null : _submit,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 0,
        disabledBackgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.5),
      ),
      child: _isLoading
          ? SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            )
          : Text(
              isEdit ? 'editStudent'.tr() : 'addNewStudent'.tr(),
              style: AppStyles.styleBold18(
                context,
              ).copyWith(color: Theme.of(context).colorScheme.onPrimary),
            ),
    );
  }

  DropdownButtonFormField<String> buildDropdownGrade(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedGrade,
      decoration: _inputDecoration('grade'.tr(), Icons.class_outlined, context),
      items: GradeHelper.selectGradeKeys
          .map(
            (grade) => DropdownMenuItem(
              value: grade,
              child: Text(grade.tr(), style: AppStyles.styleRegular14(context)),
            ),
          )
          .toList(),
      onChanged: (val) => setState(() => selectedGrade = val),
      icon: Icon(Icons.arrow_drop_down, color: Theme.of(context).colorScheme.primary),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      maxLength: keyboardType == TextInputType.phone ? 11 : null,
      style: const TextStyle(fontFamily: 'cairo'),
      decoration: _inputDecoration(label, icon, context),
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon, BuildContext context) {
    return InputDecoration(
      labelText: label,
      labelStyle: AppStyles.styleRegular14(context),
      prefixIcon: Icon(icon, color: AppColors.silverBlue),
      filled: true,
      fillColor: Theme.of(context).cardColor,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.mistBlue),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.skyBright),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.redAccent),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.redAccent, width: 2),
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:edu_center_manager/core/utils/app_style.dart';
import 'package:edu_center_manager/core/utils/app_themes.dart';
import 'package:edu_center_manager/features/teachers/data/models/teacher_model.dart';
import 'package:edu_center_manager/features/teachers/presentation/view_model/subject_helper.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class TeacherForm extends StatefulWidget {
  final Future<void> Function(TeacherModel) onSubmit;
  final TeacherModel? teacher;

  const TeacherForm({super.key, required this.onSubmit, this.teacher, required bool isMobile});

  @override
  State<TeacherForm> createState() => _TeacherFormState();
}

class _TeacherFormState extends State<TeacherForm> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  String? selectedSubject;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.teacher != null) {
      nameController.text = widget.teacher!.name;
      phoneController.text = widget.teacher!.phone!;

      final currentSubject = SubjectHelper.subjectKeys(widget.teacher!.subject!);
      if (currentSubject != '--' && SubjectHelper.selectSubject.contains(currentSubject)) {
        selectedSubject = currentSubject;
      }
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      final newTeacher = TeacherModel(
        id: widget.teacher?.id ?? const Uuid().v4(),
        name: nameController.text.trim(),
        subject: selectedSubject ?? '',
        phone: phoneController.text.trim(),
        userId: widget.teacher?.userId,
      );

      await widget.onSubmit(newTeacher);

      if (mounted) {
        setState(() => _isLoading = false);
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isEdit = widget.teacher != null;
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
                isEdit ? 'editTeacher'.tr() : 'addNewTeacher'.tr(),
                style: AppStyles.styleBold20(context),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              _buildTextField(
                controller: nameController,
                label: 'teacherName'.tr(),
                icon: Icons.person_outline,
                validator: (val) {
                  if (val == null || val.trim().isEmpty) return 'teacherNameRequired'.tr();
                  return null;
                },
              ),
              const SizedBox(height: 16),
              buildDropdownSubject(context),
              const SizedBox(height: 16),
              _buildTextField(
                controller: phoneController,
                label: 'teacherPhone'.tr(),
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
    bool isEdit = widget.teacher != null;
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
              isEdit ? 'editTeacher'.tr() : 'addNewTeacher'.tr(),
              style: AppStyles.styleBold18(
                context,
              ).copyWith(color: Theme.of(context).colorScheme.onPrimary),
            ),
    );
  }

  DropdownButtonFormField<String> buildDropdownSubject(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedSubject,
      decoration: _inputDecoration('subject'.tr(), Icons.class_outlined, context),
      items: SubjectHelper.selectSubject
          .map(
            (subject) => DropdownMenuItem(
              value: subject,
              child: Text(subject.tr(), style: AppStyles.styleRegular14(context)),
            ),
          )
          .toList(),
      onChanged: (val) => setState(() => selectedSubject = val),
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

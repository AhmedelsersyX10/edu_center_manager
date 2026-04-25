import 'package:easy_localization/easy_localization.dart';
import 'package:edu_center_manager/core/utils/app_style.dart';
import 'package:edu_center_manager/core/utils/app_themes.dart';
import 'package:edu_center_manager/features/groups/data/models/group_model.dart';
import 'package:edu_center_manager/features/groups/data/models/group_schedule_model.dart';
import 'package:edu_center_manager/features/teachers/data/models/teacher_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';

class AddGroupForm extends StatefulWidget {
  final Future<void> Function(GroupModel model, List<GroupScheduleModel> schedules) onSubmit;
  final GroupModel? group;
  final List<TeacherModel> teachers;
  final List<GroupScheduleModel> initialSchedules;

  const AddGroupForm({
    super.key,
    required this.onSubmit,
    required this.teachers,
    this.group,
    this.initialSchedules = const [],
    required bool isMobile,
  });

  @override
  State<AddGroupForm> createState() => _AddGroupFormState();
}

class _AddGroupFormState extends State<AddGroupForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _studentsController = TextEditingController();
  final _subscriptionController = TextEditingController();

  String? _teacherId;
  final List<_ScheduleFormEntry> _schedules = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final group = widget.group;
    if (group != null) {
      _nameController.text = group.name;
      _studentsController.text = '${group.maxStudents}';
      _descriptionController.text = group.description ?? '';
      _subscriptionController.text = '${group.monthlyFee}';
      _teacherId = group.teacherId;
    }
    if (widget.initialSchedules.isNotEmpty) {
      for (final s in widget.initialSchedules) {
        final e = _ScheduleFormEntry()
          ..day = s.day
          ..from = _parseScheduleTime(s.fromTime)
          ..to = _parseScheduleTime(s.toTime);
        _schedules.add(e);
      }
    } else {
      _schedules.add(_ScheduleFormEntry());
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _studentsController.dispose();
    _subscriptionController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      final maxStudents = int.tryParse(_studentsController.text.trim()) ?? 30;
      final monthlyFee = int.tryParse(_subscriptionController.text.trim()) ?? 0;
      final tid = _teacherId;
      final desc = _descriptionController.text.trim();
      final model = GroupModel(
        id: widget.group?.id ?? const Uuid().v4(),
        name: _nameController.text.trim(),
        teacherId: tid,
        maxStudents: maxStudents,
        monthlyFee: monthlyFee,
        description: desc.isEmpty ? null : desc,
      );

      final scheduleRows = <GroupScheduleModel>[];
      for (final e in _schedules) {
        if (e.from != null && e.to != null) {
          scheduleRows.add(
            GroupScheduleModel(
              id: '',
              groupId: '',
              day: e.day,
              fromTime: _formatScheduleTimeForDb(e.from!),
              toTime: _formatScheduleTimeForDb(e.to!),
            ),
          );
        }
      }

      await widget.onSubmit(model, scheduleRows);

      if (mounted) {
        setState(() => _isLoading = false);
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final titleText = widget.group != null
        ? 'groups_view.form.edit_title'.tr()
        : 'groups_view.form.add_title'.tr();
    return Container(
      constraints: const BoxConstraints(maxHeight: 650),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 32,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      padding: const EdgeInsets.only(left: 24, right: 24, top: 32, bottom: 32),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(titleText, style: AppStyles.styleBold24(context), textAlign: TextAlign.center),
              const SizedBox(height: 32),
              _buildSectionHeader(Icons.info_outline, 'groups_view.form.basic_info'.tr()),
              const SizedBox(height: 16),
              _textField(
                controller: _nameController,
                label: 'groups_view.form.group_name'.tr(),
                icon: Icons.group_outlined,
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'groups_view.form.group_name_required'.tr();
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _textField(
                controller: _descriptionController,
                label: 'groups_view.form.description'.tr(),
                icon: Icons.description_outlined,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _teacherId,
                decoration: _inputDecoration(
                  'groups_view.form.teacher'.tr(),
                  Icons.person_outline,
                  context,
                ),
                items: _teacherItems(),
                onChanged: (val) => setState(() => _teacherId = val),
                icon: const Icon(Icons.arrow_drop_down_rounded, size: 28),
                validator: (v) =>
                    v == null || v.isEmpty ? 'groups_view.form.teacher_required'.tr() : null,
              ),
              const SizedBox(height: 32),
              _buildSectionHeader(
                Icons.payments_outlined,
                'groups_view.form.pricing_capacity'.tr(),
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _textField(
                      controller: _subscriptionController,
                      label: 'groups_view.form.monthly_fee'.tr(),
                      icon: Icons.attach_money_rounded,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (v) => v == null || v.isEmpty
                          ? 'groups_view.form.monthly_fee_required'.tr()
                          : null,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _textField(
                      controller: _studentsController,
                      label: 'groups_view.form.max_students'.tr(),
                      icon: Icons.people_outline_rounded,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (val) {
                        if (val == null || val.trim().isEmpty) {
                          return 'groups_view.form.required'.tr();
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildSectionHeader(
                    Icons.calendar_month_outlined,
                    'groups_view.form.schedule'.tr(),
                  ),
                  TextButton.icon(
                    onPressed: _addScheduleRow,
                    icon: const Icon(Icons.add_circle_outline, size: 18),
                    label: Text(
                      'groups_view.form.add_schedule'.tr(),
                      style: AppStyles.styleRegular16(context),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ..._schedules.asMap().entries.map((entry) {
                final index = entry.key;
                final schedule = entry.value;
                return _buildSchedulesContainer(schedule, context, index);
              }),
              const SizedBox(height: 16),
              _buildSaveButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildSchedulesContainer(_ScheduleFormEntry schedule, BuildContext context, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(width: 1, color: context.colors.border),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<WeekDay>(
                  value: schedule.day,
                  decoration: _inputDecoration(
                    'groups_view.form.day'.tr(),
                    Icons.today_outlined,
                    context,
                    isDense: true,
                  ),
                  isExpanded: true,
                  icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 20),
                  items: WeekDay.values.map((d) {
                    return DropdownMenuItem<WeekDay>(
                      value: d,
                      child: Text(
                        GroupScheduleModel(
                          id: '',
                          groupId: '',
                          day: d,
                          fromTime: '',
                          toTime: '',
                        ).dayLocalized,
                        style: const TextStyle(
                          fontFamily: 'cairo',
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (val) {
                    if (val != null) setState(() => schedule.day = val);
                  },
                  validator: (v) => v == null ? 'groups_view.form.day_required'.tr() : null,
                ),
              ),
              const SizedBox(width: 8),
              if (_schedules.length > 1)
                IconButton(
                  onPressed: () => _removeScheduleRow(index),
                  icon: const Icon(Icons.remove_circle_outline, color: Colors.redAccent, size: 24),
                  tooltip: 'delete'.tr(),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _timePickerField(
                  label: 'groups_view.form.to'.tr(),
                  time: schedule.to,
                  validator: (time) {
                    if (time == null) {
                      return 'groups_view.form.to_required'.tr();
                    }

                    if (schedule.from != null) {
                      final fromMinutes = schedule.from!.hour * 60 + schedule.from!.minute;
                      final toMinutes = time.hour * 60 + time.minute;

                      if (toMinutes <= fromMinutes) {
                        return 'groups_view.form.invalid_time_range'.tr();
                      }
                    }

                    return null;
                  },
                  onTap: () async {
                    final time = await _pickTime(schedule.to);
                    if (time != null && mounted) {
                      setState(() => schedule.to = time);
                    }
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _timePickerField(
                  label: 'groups_view.form.from'.tr(),
                  time: schedule.from,
                  validator: (time) {
                    if (time == null) {
                      return 'groups_view.form.from_required'.tr();
                    }

                    if (schedule.to != null) {
                      final fromMinutes = time.hour * 60 + time.minute;
                      final toMinutes = schedule.to!.hour * 60 + schedule.to!.minute;

                      if (fromMinutes >= toMinutes) {
                        return 'groups_view.form.invalid_time_range'.tr();
                      }
                    }

                    return null;
                  },
                  onTap: () async {
                    final time = await _pickTime(schedule.from);
                    if (time != null && mounted) setState(() => schedule.from = time);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  ElevatedButton _buildSaveButton(BuildContext context) {
    return ElevatedButton(
      onPressed: _isLoading ? null : _submit,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 18),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
      ),
      child: _isLoading
          ? const SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white),
            )
          : Text('groups_view.form.save'.tr(), style: AppStyles.styleBold16(context)),
    );
  }

  Widget _buildSectionHeader(IconData icon, String title) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
          child: Icon(icon, size: 22),
        ),
        const SizedBox(width: 12),
        Text(title, style: AppStyles.styleBold16(context)),
      ],
    );
  }

  TextFormField _timePickerField({
    required String label,
    required TimeOfDay? time,
    required VoidCallback onTap,
    required String? Function(TimeOfDay?) validator,
  }) {
    return TextFormField(
      controller: TextEditingController(text: time == null ? '' : time.format(context)),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: const Icon(Icons.access_time_rounded, size: 20),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: context.colors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: context.colors.primaryButton, width: 2),
        ),
      ),
      readOnly: true,
      onTap: onTap,
      validator: (_) => validator(time),
      style: AppStyles.styleRegular16(context),
    );
  }

  Widget _textField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      style: const TextStyle(fontFamily: 'cairo', fontWeight: FontWeight.w500),
      decoration: _inputDecoration(label, icon, context),
    );
  }

  InputDecoration _inputDecoration(
    String label,
    IconData icon,
    BuildContext context, {
    bool isDense = false,
  }) {
    return InputDecoration(
      isDense: isDense,
      labelText: label,
      labelStyle: AppStyles.styleRegular14(context).copyWith(color: context.colors.hintText),
      prefixIcon: Icon(icon, size: 20),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: isDense ? 12 : 18),
    );
  }

  List<DropdownMenuItem<String>> _teacherItems() {
    final items = widget.teachers
        .map((t) => DropdownMenuItem<String>(value: t.id, child: Text(t.name)))
        .toList();
    final g = widget.group;
    if (g != null &&
        g.teacherId != null &&
        g.teacherId!.isNotEmpty &&
        !widget.teachers.any((t) => t.id == g.teacherId)) {
      items.insert(0, DropdownMenuItem<String>(value: g.teacherId, child: Text(g.teacherId!)));
    }
    return items;
  }

  Future<TimeOfDay?> _pickTime(TimeOfDay? initial) async {
    return await showTimePicker(context: context, initialTime: initial ?? TimeOfDay.now());
  }

  void _addScheduleRow() {
    setState(() {
      _schedules.add(_ScheduleFormEntry());
    });
  }

  void _removeScheduleRow(int index) {
    setState(() {
      _schedules.removeAt(index);
    });
  }
}

class _ScheduleFormEntry {
  WeekDay day = WeekDay.sat;
  TimeOfDay? from;
  TimeOfDay? to;
}

TimeOfDay? _parseScheduleTime(String raw) {
  final parts = raw.trim().split(':');
  if (parts.length < 2) return null;
  final h = int.tryParse(parts[0]);
  final m = int.tryParse(parts[1]);
  if (h == null || m == null) return null;
  return TimeOfDay(hour: h, minute: m);
}

String _formatScheduleTimeForDb(TimeOfDay t) {
  final h = t.hour.toString().padLeft(2, '0');
  final m = t.minute.toString().padLeft(2, '0');
  return '$h:$m:00';
}

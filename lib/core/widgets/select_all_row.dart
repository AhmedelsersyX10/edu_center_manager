import 'package:flutter/material.dart';

class SelectAllRow extends StatelessWidget {
  const SelectAllRow({
    super.key,
    required this.totalVisible,
    required this.selectedInVisible,
    required this.isDisabled,
    required this.onToggle,
    required this.label,
    this.countBuilder,
  });

  final int totalVisible;
  final int selectedInVisible;
  final bool isDisabled;
  final VoidCallback onToggle;
  final Widget label;
  final Widget Function(int selectedCount)? countBuilder;

  @override
  Widget build(BuildContext context) {
    if (totalVisible == 0) return const SizedBox.shrink();
    final allSelected = selectedInVisible == totalVisible;
    final noneSelected = selectedInVisible == 0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: isDisabled ? null : onToggle,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          child: Row(
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: Checkbox(
                  tristate: true,
                  value: allSelected ? true : (noneSelected ? false : null),
                  onChanged: isDisabled ? null : (_) => onToggle(),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(child: label),
              if (!noneSelected)
                (countBuilder == null
                    ? Text('$selectedInVisible')
                    : countBuilder!(selectedInVisible)),
            ],
          ),
        ),
      ),
    );
  }
}

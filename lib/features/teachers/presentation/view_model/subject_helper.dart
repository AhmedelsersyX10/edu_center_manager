import 'package:easy_localization/easy_localization.dart';

class SubjectHelper {
  static const List<String> selectSubject = [
    'math',
    'arabic',
    'english',
    'science',
    'social',
    'computer',
    'physics',
    'chemistry',
    'biology',
    'history',
    'geography',
    'philosophy',
    'psychology',
    'programming',
    'economics',
    'statistics',
    'religion',
    'french',
    'german',
    'spanish',
  ];
  static String subjectKeys(String? subject) {
    if (subject == null) return '--';
    {
      switch (subject) {
        case 'الكل':
          return 'all';
        case 'الرياضيات':
          return 'math';
        case 'اللغة العربية':
          return 'arabic';
        case 'اللغة الإنجليزية':
          return 'english';
        case 'العلوم':
          return 'science';
        case 'الفيزياء':
          return 'physics';
        case 'الكيمياء':
          return 'chemistry';
        case 'الأحياء':
          return 'biology';
        case 'التاريخ':
          return 'history';
        case 'الجغرافيا':
          return 'geography';
        case 'الفلسفة':
          return 'philosophy';
        case 'علم النفس':
          return 'psychology';
        case 'الحاسب الآلي':
          return 'computer';
        case 'البرمجة':
          return 'programming';
        case 'الاقتصاد':
          return 'economics';
        case 'الإحصاء':
          return 'statistics';
        case 'التربية الدينية':
          return 'religion';
        case 'اللغة الفرنسية':
          return 'french';
        case 'اللغة الألمانية':
          return 'german';
        case 'اللغة الإسبانية':
          return 'spanish';
        default:
          return subject;
      }
    }
  }

  static String translateSubject(String? subject) {
    if (subject == null || subject == '--') return '--';
    return subjectKeys(subject).tr();
  }
}

import 'enums.dart';

extension StringExtension on String {
  // print Enum.element => Enum.element
  ConstantEnum toConstantEnum<ConstantEnum>(List<ConstantEnum> values) {
    ConstantEnum result;
    try {
      result = values.firstWhere((element) =>
          element.toString().toLowerCase().split(".").last == toLowerCase());
    } catch (e) {
      result = ConstantEnum.unknow;
    }
    // StateError
    return result;
  }
}

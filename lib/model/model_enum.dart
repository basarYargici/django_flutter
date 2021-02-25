enum Model {
  synonym,
  translate,
}

extension EnumTypeToString on Model {
  String convert(Model type) => type.toString().split('.')[1];
}

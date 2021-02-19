enum Model {
  synonym,
  translate,
}

extension enumTypeToString on Model {
  String convert(Model type) => type.toString().split(".")[1];
}

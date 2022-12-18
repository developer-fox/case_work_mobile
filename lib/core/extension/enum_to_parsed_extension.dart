
extension EnumToParsedExtension on Enum{
  String toParsed(){
    return toString().split(".")[1];
  }
}


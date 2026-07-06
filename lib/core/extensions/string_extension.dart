extension NameFormatter on String {
  String toFirstName() {
    List<String> nameParts = trim().split(RegExp(r'\s+'));
    return nameParts.isNotEmpty ? nameParts.first : "";
  }
  String toFirstAndLastName() {
    List<String> nameParts = trim().split(RegExp(r'\s+'));
    if (nameParts.isEmpty || nameParts[0].isEmpty) {
      return "";
    }
    if (nameParts.length == 1) {
      return nameParts.first;
    }
    return "${nameParts.first} ${nameParts.last}";
  }
}

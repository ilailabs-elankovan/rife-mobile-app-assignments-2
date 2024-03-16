import 'package:shared_preferences/shared_preferences.dart';

Future<String?> _getUserType() async {
  final SharedPreferences userData = await SharedPreferences.getInstance();
  return userData.getString('userType');
}

Future<String?> _getUserUID() async {
  final SharedPreferences userData = await SharedPreferences.getInstance();
  return userData.getString('userUID');
}

void addToIssuesList({required String issueTitle}) async {
  final SharedPreferences userData = await SharedPreferences.getInstance();
  var oldList = userData.getStringList("userIssues") ?? [];
  oldList.add(issueTitle);
  userData.setStringList("userIssues", oldList);
  print("***seqList: ${oldList}***");

}

 getIssuesList() async {
  final SharedPreferences userData = await SharedPreferences.getInstance();
  var oldList = userData.getStringList("userIssues") ?? [];
  return oldList;

}

void removeFromIssuesList({required String issueTitle}) async {
  final SharedPreferences userData = await SharedPreferences.getInstance();
  var oldList = userData.getStringList("userIssues") ?? [];
  oldList.remove(issueTitle);
  userData.setStringList("userIssues", oldList);
  print("***list: ${oldList}***");
}
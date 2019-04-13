import 'package:intl/intl.dart';



String getPlaceholderInitials(String userName){

  List nameList = userName.split(' ');

  String name = nameList[0];
  String surname = nameList[1];

  return name.substring(0, 1) + surname.substring(0, 1);
}


String formatTime(String timeInMillisecs) {
  String formattedTime = '';
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(timeInMillisecs));
  //print('time_tool.dart - fed in ${formatDate(dateTime: dateTime)}');

  Duration timeDifference = DateTime.now().difference(dateTime);

  if (timeDifference.inHours <= 23) {
    if (timeDifference.inHours < 1) {
      if (timeDifference.inMinutes < 1) {
        formattedTime = 'Just now';
      }
      else
      if (timeDifference.inMinutes >= 1) {
        formattedTime = '${timeDifference.inMinutes} min';
      }
    }
    else
    if (timeDifference.inHours >= 1 && timeDifference.inHours <= 5) {
      formattedTime = '${timeDifference.inHours} h';
    }
    else
    if (timeDifference.inHours > 5) {
      if (dateTime.hour >= 0 && dateTime.hour <= 11) {
        formattedTime = 'Today ${dateTime.hour} a.m.';
      }
      else
      if (dateTime.hour > 11 && dateTime.hour <= 23) {
        formattedTime = 'Today ${dateTime.hour} p.m.';
      }
    }
  }
  else
  if (timeDifference.inHours >= 24 && timeDifference.inHours <= 47) {
    formattedTime = 'Yesterday';
  }
  else
  if (timeDifference.inHours >= 48) {
    formattedTime = formatDate(dateTime: dateTime);
  }
  return formattedTime;
}

String formatDate(
    {DateTime dateTime, String messageDateString, bool isDateTime = true}) {
  String formattedTime = "";
  String formatPattern = 'dd/MM/yyyy';
  if (isDateTime) {
    if (dateTime == null)
      return "";

    formattedTime = DateFormat(formatPattern).format(dateTime);
  }
  else {
    if (messageDateString == null)
      return "";

    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(messageDateString));
    formattedTime = DateFormat(formatPattern).format(dateTime);
  }

  return formattedTime;
}

bool isTimeDifferenceAboveEightMinutes(
    {String previousTime, String currentTime}) {
  DateTime previousDateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(previousTime));

  DateTime currentDateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(currentTime));

  Duration timeDifference = currentDateTime.difference(previousDateTime);

  return timeDifference.inMinutes > 8;
}

import 'package:intl/intl.dart';

class DateUtil{
  static String formatDate(dynamic val, String oldFormat, String newFormat){
    assert(val != null && (val is String || val is DateTime));
    assert(oldFormat!=null);
    assert(newFormat!=null);
    DateTime oldDate;
    if(val is String){
      oldDate = DateTime.parse(val);
    }else if(val is DateTime){
      oldDate = val;
    }

    return DateFormat(newFormat).format(oldDate);
  }

  static String diff(dynamic val){
    assert(val != null && (val is String || val is DateTime));
    DateTime oldDate;
    var now = DateTime.now();
    if(val is String){
      oldDate = DateTime.parse(val);
    }else if(val is DateTime){
      oldDate = val;
    }

    var diff = now.difference(oldDate);
    if(diff.inDays > 0){
      return "${diff.inDays} days ago";
    }else if(diff.inHours > 0){
      return "${diff.inHours} hours ago";
    }else if(diff.inMinutes > 0){
      return "${diff.inMinutes} minutes ago";
    }
    return "${diff.inSeconds} seconds ago";
  }
}
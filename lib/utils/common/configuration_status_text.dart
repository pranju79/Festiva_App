
import 'dart:ui';
import 'package:event_orientation_app/utils/components/tt_colors.dart';

Color? getStatusTextColor (String status){
  if (status == 'Pending'){
    return TTColors.warning;
  }else if(status == 'Confirm'){
     return const Color.fromARGB(255, 52, 150, 3);
  }else if(status == 'Cancel'){
    return TTColors.danger;
  }
  return null;
}
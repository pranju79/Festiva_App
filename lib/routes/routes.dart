import 'package:event_orientation_app/modules/Admin/Add_event/presentation/views/add_data.dart';
import 'package:event_orientation_app/modules/Admin/Add_event/presentation/widgets/add_event_form.dart';
import 'package:event_orientation_app/modules/Admin/Add_event/presentation/widgets/add_theme_form.dart';
import 'package:event_orientation_app/modules/Admin/Admin_Login_Register/presentation/pages/admin_login.dart';
import 'package:event_orientation_app/modules/Admin/Admin_Login_Register/presentation/pages/admin_register.dart';
import 'package:event_orientation_app/modules/Admin/Admin_Profile/presentation/pages/admin_profile.dart';
import 'package:event_orientation_app/modules/Admin/View_Booking/All_event.dart';
import 'package:event_orientation_app/modules/Admin/View_Booking/view_booking_details.dart';
import 'package:event_orientation_app/modules/Admin/admin_home/admin_home_page.dart';
import 'package:event_orientation_app/modules/Admin/display_admin_data/admin_data.dart';
import 'package:event_orientation_app/modules/Admin/display_user_data/users_data.dart';
import 'package:event_orientation_app/modules/Admin/feedback_view/view.dart';
import 'package:event_orientation_app/modules/Screens/presentation/views/terms_and_policies.dart';
import 'package:event_orientation_app/modules/User/Booking_Details/presentation/views/view_booking.dart';
import 'package:event_orientation_app/modules/User/Contact_Details/presentation/views/Owner_details.dart';
import 'package:event_orientation_app/modules/User/Contact_Details/presentation/widgets/contact_page.dart';
import 'package:event_orientation_app/modules/User/Contact_Details/presentation/widgets/payment_details.dart';
import 'package:event_orientation_app/modules/User/EventList/presentation/views/event_list_mobile_view.dart';
import 'package:event_orientation_app/modules/User/Event_Screen/presentation/views/event_mobile_view.dart';
import 'package:event_orientation_app/modules/Screens/presentation/views/splash_screen.dart';
import 'package:event_orientation_app/modules/User/Home/presentation/views/home_mobile_view.dart';
import 'package:event_orientation_app/modules/User/UserRegister_Screen/presentation/pages/Loginpage.dart';
import 'package:event_orientation_app/modules/User/UserRegister_Screen/presentation/pages/User_Register.dart';
import 'package:event_orientation_app/modules/User/User_Profile/presentation/pages/user_profile.dart';
import 'package:event_orientation_app/modules/User/feedback/uiview/feedback_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class AppRoutes {
  static const String splashscreen = '/';

  //Admin
  static const String adminlogin = '/adminlogin';
  static const String adminregister = '/adminregister';
  static const String adminhome = '/adminhome';
  static const String admindata = '/admindata';
  static const String adminprofile = '/adminprofile';
  static const String addeventtheme = '/addeventtheme';
  static const String addeventform = '/addeventform';
  static const String addthemeform = '/addthemeform';
  static const String adminviewbooking = '/adminviewbooking';
  static const String admineventdetails = '/admineventdetails';
  static const String userdata = '/userdata';
  static const String feedbacks = '/feedbacks';

  //User
  static const String login = '/login';
  static const String register = '/register';
  static const String userhome = '/userhome';
  static const String userprofile = '/userprofile';
  static const String eventdetails = '/eventdetails';
  static const String ownerdetails = '/ownerdetails';
  static const String contactdetails = '/contactdetails';
  static const String paymentdetails = '/paymentdetails';
  static const String viewbookinguser = '/viewbookinguser';
  static const String termspolicies = '/termspolicies';
  static const String eventlist = '/eventlist';
  static const String feedbackform = '/feedbackform';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      splashscreen: (context) => const SplashScreen(),

      //Admin
      adminlogin: (context) => const AdminLogin(),
      adminregister: (context) => const AdminRegister(),
      adminhome: (context) => const AdminHomeScreen(),
      adminprofile: (context) => const AdminProfile(),
      addeventtheme: (context) => const AddData(),
      admindata:(context) => const AdminData(),
      addeventform: (context) => const AddEventForm(),
      addthemeform: (context) => const AddThemesForm(),
      adminviewbooking: (context) => const BookingDetailsPage(),
      admineventdetails: (context) => const EventDetailsPage(
            eventName: '',
            eventDetails: [],
          ),
      userdata: (context) => const UsersData(),
      feedbacks: (context) => const FeedbackListPage(),

      //User
      login: (context) => const LoginPage(),
      register: (context) => const UserRegisterPage(),
      userhome: (context) => const HomeScreen(),
      userprofile: (context) => const UserProfile(),
      eventdetails: (context) => EventMobileView(
            email: '',
            eventtype: '',
          ),
      ownerdetails: (context) => const OwnerDetails(),
      viewbookinguser: (context) => ViewBooking(
            email: '',
          ),
      contactdetails: (context) => const ContactPage(),
      paymentdetails: (context) => const PaymentDetails(),
      termspolicies: (context) => const TermsAndPolicies(),
      eventlist: (context) => EventListMobileView(email: ''),
      feedbackform: (context) => const FeedbackPage(email: '',),
    };
  }
}

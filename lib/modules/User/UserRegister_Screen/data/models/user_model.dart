class User{
  String name;
  String email;
  String mobile;
  String gender;
  String password;
  String conformPass;
  

  User({
    required this.name,
    required this.email,
    required this.mobile,
    required this.gender,
    required this.password,
    required this.conformPass,
    
  });
// Map<String, dynamic> toMap() {
//     return {
//       'name': name,
//       'email': email,
//       'mobile': mobile,
//       'gender':gender,
//       'password':password,
//       'conformPass':conformPass,
//     };
// }

}
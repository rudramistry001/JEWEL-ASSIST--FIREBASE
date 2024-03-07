// class ChatUser {

// ignore_for_file: non_constant_identifier_names

// }
class ChatUser {
  ChatUser({
    required this.Email,
    required this.Id,
    required this.Name,
    required this.CreatedAt,
    required this.VendorName,
    required this.Role,
    required this.ContactNumber,
  });

  late String Email;
  late String Id;
  late String Name;
  late String CreatedAt;
  late String VendorName;
  late String Role;
  late String ContactNumber;

  ChatUser.fromJson(Map<String, dynamic> json) {
    Email = json['Email'] ?? '';
    Id = json['Id'] ?? '';
    Name = json['Name'] ?? '';
    CreatedAt = json['Created_At'] ?? '';
    VendorName = json['Vendor_Name'] ?? '';
    Role = json['User_Role'] ?? '';
    ContactNumber = json['Contact_Number'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Email'] = Email;
    data['Id'] = Id;
    data['Name'] = Name;
    data['Created_At'] = CreatedAt;
    data['Vendor_Name'] = VendorName;
    data['User_Role'] = Role;
    data['Contact_Number'] = ContactNumber;
    return data;
  }
}

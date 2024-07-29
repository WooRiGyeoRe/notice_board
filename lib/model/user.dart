class UserModel {
  final bool ok;
  final Map<String, dynamic> data;

  UserModel({
    required this.ok,
    required this.data,
  });

  UserModel.fromJson(json)
      : ok = json['ok'],
        data = json['data'];
}

class UserDataModel {
  final int no;
  final String id, nick, token, role;

  UserDataModel({
    required this.no,
    required this.id,
    required this.nick,
    required this.token,
    required this.role,
  });

  UserDataModel.fromJson(json)
      : no = json['no'],
        id = json['id'],
        nick = json['nick'],
        role = json['role'],
        token = json['token'];
}

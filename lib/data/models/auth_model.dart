class LoginResponse {
  final String accessToken;
  final String message;
  final String refreshToken;
  final User user;

  LoginResponse({
    required this.accessToken,
    required this.message,
    required this.refreshToken,
    required this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      accessToken: json['access_token'],
      message: json['message'],
      refreshToken: json['refresh_token'],
      user: User.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'message': message,
      'refresh_token': refreshToken,
      'user': user.toJson(),
    };
  }
}

class User {
  final String email;
  final int id;
  final String role;
  final String username;

  User({
    required this.email,
    required this.id,
    required this.role,
    required this.username,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      id: json['id'],
      role: json['role'],
      username: json['username'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'id': id,
      'role': role,
      'username': username,
    };
  }
}



class LoginRequestModel {
  final String email;
  final String password;

  LoginRequestModel({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}



//fromjson login




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



class RegisterResponse {
  final String accessToken;
  final String message;
  final String refreshToken;
  final User user;

  RegisterResponse({
    required this.accessToken,
    required this.message,
    required this.refreshToken,
    required this.user,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      accessToken: json['access_token'],
      message: json['message'],
refreshToken: json['refresh_token'] ?? '',
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

class User2 {
  final String email;
  final int id;
  final String role;
  final String username;

  User2({
    required this.email,
    required this.id,
    required this.role,
    required this.username,
  });

  factory User2.fromJson(Map<String, dynamic> json) {
    return User2(
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






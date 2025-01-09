
enum UserRole {
  admin,
  user,
  guest
}

extension UserRoleExtension on UserRole{
    String get roleString{
      switch(this){
        case UserRole.admin:
          return "admin";
        case UserRole.user:
          return "user";
        case UserRole.guest:
          return "guest";
      }
    }
}

UserRole roleFromString(String role){
  switch(role){
    case "admin":
      return UserRole.admin;
    case "user":
      return UserRole.user;
    case "guest":
      return UserRole.guest;
    default:
      return UserRole.guest;
  }
}
enum Role {
  admin,
  manager,
  director,
}

extension RoleConverter on String {
  Role getRole() {
    switch (this) {
      case 'Admin':
        return Role.admin;
      case 'manager':
        return Role.manager;
      case 'director':
        return Role.director;
      default:
        return Role.manager;
    }
  }
}

extension RoleToString on Role {
  String getName() {
    switch (this) {
      case Role.admin:
        return 'Admin';
      case Role.manager:
        return 'manager';
      case Role.director:
        return 'director';
      default:
        return 'manager';
    }
  }
}

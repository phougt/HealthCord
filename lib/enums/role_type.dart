enum RoleType {
  owner,
  member,
  custom;

  String get value {
    switch (this) {
      case RoleType.owner:
        return 'owner';
      case RoleType.member:
        return 'member';
      case RoleType.custom:
        return 'custom';
    }
  }

  static RoleType fromValue(String value) {
    switch (value) {
      case 'owner':
        return RoleType.owner;
      case 'member':
        return RoleType.member;
      case 'custom':
        return RoleType.custom;
      default:
        throw ArgumentError('Invalid role type value: $value');
    }
  }
}

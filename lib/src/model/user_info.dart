
/*
    print('displayName: ' + snapshot.data.displayName.toString());
    print('email: ' + snapshot.data.email.toString());
    print('metadata: ' + snapshot.data.metadata.toString());
    print('photoURL: ' + snapshot.data.photoURL.toString());
    print('providerData: ' + snapshot.data.providerData.toString());
    print('providerData[0]: ' + snapshot.data.providerData[0].toString());
    print('refreshToken: ' + snapshot.data.refreshToken.toString());
    print('tenantId: ' + snapshot.data.tenantId.toString());
    print('uid: ' + snapshot.data.uid.toString());
*/
class UserInfo {
  String? displayName;
  String? email;
  String? photoURL;
  String? uid;

  UserInfo(this.displayName, this.email, this.photoURL, this.uid);
}


class UserType {
  String? userType;
  String? userLangType;

  UserType(this.userType, this.userLangType);
}



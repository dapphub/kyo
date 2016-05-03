import 'authority.sol';

contract KYOUser {
    KYOAuthority _kyo_auth;
    function KYOUser( KYOAuthority kyo_auth ) {
        _kyo_auth = kyo_auth;
    }
    modifier kyo() {
        if( !_kyo_authority.checkOrigin() ) {
            throw;
        }
        _
    }
    modifier try_kyo() {
        if( !_kyo_authority.checkOrigin() ) {
            return;
        }
        _
    }
}

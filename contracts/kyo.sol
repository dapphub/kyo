import 'authority.sol';

contract KYOUser {
    KYOAuthority _kyo_auth;
    function KYOUser( KYOAuthority kyo_auth ) {
        _kyo_auth = kyo_auth;
    }
    function tryKYOCheck() internal returns (bool) {
        return _kyo_authority.checkOrigin(this, msg.sig);
    }
    function KYOCheck() internal {
        if(!tryKYOCheck()) throw;
    }
    modifier try_kyo() {
        if( KYOCheck() )
            _
        }
    }
    modifier kyo() {
        KYOCheck();
        _
    }
}

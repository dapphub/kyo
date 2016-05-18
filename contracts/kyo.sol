import 'authority.sol';

contract KYOUser {
    KYOAuthorityType _kyo_auth;
    function KYOUser( KYOAuthorityType kyo_auth ) {
        _kyo_auth = kyo_auth;
    }
    function tryKYOCheck() internal returns (bool) {
        return _kyo_auth.signerCanRun(this, msg.sig);
    }
    function KYOCheck() internal {
        if(!tryKYOCheck()) throw;
    }
    modifier try_kyo() {
        if( tryKYOCheck() ) {
            _
        }
    }
    modifier kyo() {
        KYOCheck();
        _
    }
}

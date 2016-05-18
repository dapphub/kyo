import 'dappsys/controller.sol'; // for DSControlledAction TODO
import 'kyo.sol';

contract KYOAction is DSControlledAction {
    bytes32 _key;
    function KYOAction( bytes32 kyo_auth_key ) {
        _key = kyo_auth_key;
    }
    function() {
        KYOAuthorityType(get(_key)).KYOCheck();
    }
}

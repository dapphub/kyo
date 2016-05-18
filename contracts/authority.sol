import 'dappsys/auth.sol';

contract KYOAuthorityType {
    function signerCanRun(address code, bytes4 sig) returns (bool);
}
contract KYOAuthority is KYOAuthorityType, DSAuth {
    // Keyring 0 is a public keyring (everyone is in it by default /
    // moves back into it when they `revoke`).
    mapping(address=>uint)                                  _origin2keyring;
    mapping(uint=>mapping(address=>mapping(bytes4=>bool)))  _keyring_can_run;
    mapping(address=>mapping(address=>bool)) _approved;
    function signerCanRun(address code, bytes4 sig) returns (bool) {
        var keyring = _origin2keyring[tx.origin];
        return _keyring_can_run[keyring][code][sig];
    }
    function setKeyring(address key, uint keyring)
        auth
    {
        _origin2keyring[key] = keyring;
    }
    function link(address who) {
        if( msg.sender != tx.origin ) { // TODO discuss
            throw;
        }
        _approved[tx.origin][who] = true;
        if( _approved[who][tx.origin] ) {
            _origin2keyring[tx.origin] = _origin2keyring[who];
        }
    }
    function revoke() {
        _origin2keyring[tx.origin] = 0;
    }
}

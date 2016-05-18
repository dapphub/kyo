import 'dappsys/auth.sol';

contract KYOAuthorityType {
    function signerCanRun(address code, bytes4 sig) returns (bool);
}
contract KYOAuthority is KYOAuthorityType, DSAuth {
    // Keyring 0 is a public keyring (everyone is in it by default /
    // moves back into it when they `revoke`).
    mapping(address=>uint)                                  _origin2keyring;
    mapping(uint=>bytes32)                                  _keyring2groups;
    mapping(uint8=>mapping(address=>mapping(bytes4=>bool))) _group_can_run;
    mapping(address=>mapping(address=>bool)) _approved;
    function signerCanRun(address code, bytes4 sig) returns (bool) {
        var keyring = _origin2keyring[tx.origin];
        return _keyring_can_run[keyring][code][sig];
    }
    function setKeyring(address key, uint ring)
        auth
    {
        _origin2keyring[key] = ring;
    }
    function setKeyringGroups(uint ring, bytes32 groups)
        auth
    {
        _keyring2groups[ring] = groups;
    }
    function setKeyringCanRun(uint8 group, address code, bytes4 sig, bool can)
        auth
    {
        _group_can_run[group][code][sig] = can;
    }
    function link(address who)
        origin
    {
        _approved[tx.origin][who] = true;
        if( _approved[who][tx.origin] ) {
            _origin2keyring[tx.origin] = _origin2keyring[who];
        }
    }
    function revoke()
        origin
    {
        _origin2keyring[tx.origin] = 0;
    }
    modifier origin() {
        if( msg.sender != tx.origin ) {
            throw;
        }
        _
    }
}

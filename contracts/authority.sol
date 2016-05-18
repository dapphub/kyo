import 'dappsys/auth.sol';

contract KYOAuthorityType {
    function signerCanRun(address code, bytes4 sig) returns (bool);
}
contract KYOAuthority is KYOAuthorityType, DSAuth {
    // Keyring 0 is a public keyring (everyone is in it by default /
    // moves back into it when they `revoke`).
    mapping(address=>uint)                                  _origin2keyring;
    mapping(uint=>bytes32)                                  _keyring2groups;
    mapping(address=>mapping(bytes4=>bytes32))              _allowed_groups;
    mapping(address=>mapping(address=>bool))                _approved;
    mapping(address=>bool)                                  _revoked;
    function signerCanRun(address code, bytes4 sig) returns (bool) {
        var keyring = _origin2keyring[tx.origin];
        var has_groups = _keyring2groups[keyring];
        var allowed_groups = _allowed_groups[code][sig];
        return (bytes32(0x0) != (has_groups & allowed_groups));
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
    function setAllowedGroups(address code, bytes4 sig, bytes32 groups)
        auth
    {
        _allowed_groups[code][sig] = groups;
    }
    function link(address who)
        origin
    {
        if( _revoked[tx.origin] ) {
            throw;
        }
        _approved[tx.origin][who] = true;
        if( _approved[who][tx.origin] ) {
            _origin2keyring[tx.origin] = _origin2keyring[who];
        }
    }
    function revoke()
        origin
    {
        _origin2keyring[tx.origin] = 0;
        _revoked[tx.origin] = true;
    }
    modifier origin() {
        if( msg.sender != tx.origin ) {
            throw;
        }
        _
    }
}

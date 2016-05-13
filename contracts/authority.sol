contract KYOAuthority {
    function signerCanRun(address code, bytes4 sig) returns (bool);
}
contract KYOAuthority {
    mapping(address=>uint)                                  _origin2keyring;
    mapping(uint=>mapping(address=>mapping(bytes4=>bool)))  _can_run;
    function signerCanRun(address code, bytes4 sig) returns (bool) {
        var keyring = _origin2keyring[tx.origin];
        return _can_run[keyring][code][sig];
    }
}

know-your-origin
===

A base layer for KYC solutions that discriminates by `tx.origin` instead of `msg.sender`. Get out of the way and let the developers play!

This is not the right tool for system-level command/control. For that, see [`dappsys/auth`](https://github.com/nexusdev/dappsys).

How to use
---

Protect functions with the `kyo` modifier to do a `tx.origin` lookup.

```js
function highTrustAction()
    kyo
{
    // You know who is running this code, even if they it was called
    // through intermediate contracts they created independently
}
```

Contract that use `kyo` must be initialized with a `KYOAuthority` reference:

```js
contract MyContract is KYOUser {
    function MyContract( KYOAuthority kyo_auth )
        KYOUser( kyo_auth )
    {
    }
}
```

Implement your own `KYOAuthority`, or use the provided examples.

```js
contract KYOAuthority {
    function signerCanRun(address code, bytes4 sig) returns (bool);
}
```

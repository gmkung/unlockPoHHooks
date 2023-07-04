pragma solidity ^0.8.0;

import "./ILockValidKeyHook.sol";
import "./IProofOfHumanity.sol";

contract LockValidKeyHook is ILockValidKeyHook {
    IProofOfHumanity public proofOfHumanity;

    constructor(address _proofOfHumanity) {
        proofOfHumanity = IProofOfHumanity(_proofOfHumanity);
    }

    function hasValidKey(
        address lockAddress,
        address keyOwner,
        uint256 expirationTimestamp,
        bool isValidKey
    ) external view override returns (bool) {
        // Check if the key owner has a verified account on Proof of Humanity
        if (!proofOfHumanity.isRegistered(keyOwner)) {
            return false;
        }

        // Allow the key to be considered valid if it is valid in the lock contract
        return isValidKey;
    }
}
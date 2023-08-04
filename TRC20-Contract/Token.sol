pragma solidity ^0.5.0;

import "./TRC20.sol";
import "./TRC20Detailed.sol";

contract Token is TRC20, TRC20Detailed {

    constructor () public TRC20Detailed("YourTokenName", "YTN", 18) {
        _mint(msg.sender, 10000000000 * (10 ** uint256(decimals())));
    }

    function batchTransfer(address[] memory recipients, uint256[] memory amounts) public returns (bool) {
    require(recipients.length == amounts.length, "Invalid input: recipients and amounts array length mismatch");

        uint256 totalAmount = 0;
        for (uint256 i = 0; i < recipients.length; i++) {
            totalAmount = totalAmount.add(amounts[i]);
        }

        for (uint256 i = 0; i < recipients.length; i++) {
            _transfer(msg.sender, recipients[i], amounts[i]);
        }

        return true;
}
}

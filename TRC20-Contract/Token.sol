pragma solidity ^0.5.0;

import "./TRC20.sol";
import "./TRC20Detailed.sol";
import "./SafeMath.sol";

contract Token is TRC20, TRC20Detailed {
    using SafeMath for uint256;

    constructor () public TRC20Detailed("YourTokenName", "YTN", 18) {
        _mint(msg.sender, 10000000000 * (10 ** uint256(decimals())));
    }

    function batchTransfer(address[] memory recipients, uint256[] memory amounts) public returns (bool) {
        require(recipients.length == amounts.length, "Invalid input: recipients and amounts array length mismatch");
        require(recipients.length <= 100, "Too many recipients"); // Оптимальна кількість отримувачів у одній транзакції

        uint256 totalAmount = 0;
        for (uint256 i = 0; i < recipients.length; i++) {
            require(recipients[i] != address(0), "Invalid recipient address");
            totalAmount = totalAmount.add(amounts[i]);
            require(totalAmount >= amounts[i], "Overflow in totalAmount");
        }

        _transferBatch(msg.sender, recipients, amounts);
        return true;
    }

    function _transferBatch(address sender, address[] memory recipients, uint256[] memory amounts) internal {
        for (uint256 i = 0; i < recipients.length; i++) {
            _transfer(sender, recipients[i], amounts[i]);
        }
    }
}

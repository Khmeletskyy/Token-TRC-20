//перша версія ,  за 1 адресу 28к енергії 

// pragma solidity ^0.5.0;

// import "./TRC20.sol";
// import "./TRC20Detailed.sol";

// contract Token is TRC20, TRC20Detailed {

//     constructor () public TRC20Detailed("YourTokenName", "YTN", 18) {
//         _mint(msg.sender, 10000000000 * (10 ** uint256(decimals())));
//     }

//     function batchTransfer(address[] memory recipients, uint256[] memory amounts) public returns (bool) {
//     require(recipients.length == amounts.length, "Длина массивов не совпадает");

//         uint256 totalAmount = 0;
//         for (uint256 i = 0; i < recipients.length; i++) {
//             totalAmount = totalAmount.add(amounts[i]);
//         }

//         for (uint256 i = 0; i < recipients.length; i++) {
//             _transfer(msg.sender, recipients[i], amounts[i]);
//         }

//         return true;
//     }
// } 

//друга версія ,  за 1 адресу 7к енергії, відправляє івенти без фактичного переводу токенів, є транзакція про прихід токенів, але в гаманці не відображаються 
pragma solidity ^0.5.0;

import "./TRC20.sol";
import "./TRC20Detailed.sol";

contract Token is TRC20, TRC20Detailed {

constructor () public TRC20Detailed("YourTokenName", "YTN", 18) {
    _mint(msg.sender, 10000000000 * (10 ** uint256(decimals())));
}

function batchTransfer(address[] memory recipients, uint256[] memory amounts) public returns (bool) {
    require(recipients.length == amounts.length, "Длина массивов не совпадает");

    uint256 totalAmount = 0;
    for (uint256 i = 0; i < amounts.length; i++) {
        totalAmount = totalAmount.add(amounts[i]);
    }

    require(totalAmount <= balanceOf(msg.sender), "Недостаточно токенов на балансе отправителя");

    for (uint256 i = 0; i < recipients.length; i++) {
        address recipient = recipients[i];
        uint256 amount = amounts[i];
        emit Transfer(msg.sender, recipient, amount);
        balances[recipient] += amount;
    }

    return true;
}

mapping(address => uint256) public balances;

function getBalance(address recipient) public view returns (uint256) {
    return balances[recipient];
}
}


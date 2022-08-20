pragma solidity ^0.8.0;

 import "./allowance.sol";

contract Wallet is Allowance {

    function withdraw(address payable Add, uint amount) public onlyOwnernAllowed(amount) {

        require(amount <= address(this).balance , "Smart COntract doeesn't have this much fund");
        
        if (owner() != msg.sender){

            reduceAllowance(msg.sender, amount);
        }

        Add.transfer(amount);
        emit moneySent (Add, amount);

    }

    fallback () external payable{
        emit moneyReceived(msg.sender, msg.value);

    }

    receive () external payable{
        emit moneyReceived ( msg.sender , msg.value);
        
    }
}
pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";


contract Allowance is Ownable{
    mapping (address => uint ) public allowance;

    event AllowedEvent(address indexed _forWho, address indexed caller, uint oldAmount , uint newAmount);
    event moneySent(address indexed _to, uint amount);
    event moneyReceived (address indexed from, uint amount);

    function allowed(address _add, uint _amount) public onlyOwner {
        emit AllowedEvent(_add,msg.sender, allowance[_add], _amount);
     
     allowance[_add] = _amount;
    }

    modifier onlyOwnernAllowed(uint amount){
        require (owner() == msg.sender || allowance[msg.sender] >= amount,"require statement failed");
        _;
    }


    function balance () public view returns (uint){
        return address(this).balance;
    }
    function reduceAllowance (address _who , uint amount) internal {

        allowance[_who] -= amount;
        emit AllowedEvent(_who,msg.sender, allowance[_who], allowance[_who] - amount);

    }

}

pragma solidity ^0.8.0;
contract owned {
   address owner;
   
   constructor(){
       owner = msg.sender;
   }

     modifier own () {
          require(msg.sender == owner , "ONLY OWNER CAN CREATE NEW TOKEN");
          _;
     }
}

contract TokenGeneration is owned{
     
     mapping(address => uint) public tokenBalance;
     
     
  
     uint tokenPrice = 1 ether;  

     constructor (){
           
           tokenBalance[msg.sender]= 100;

     }


     function createToken() public own {
        
         tokenBalance[owner]++;
     }

     function burnToken() public own {
          
          tokenBalance[owner]--;
     }

     function buyToken() public payable {
         require((tokenBalance[owner] * tokenPrice)/msg.value > 0,"NOT ENOUGH TOKEN");

         uint amountInEth = msg.value/1 ether;

         tokenBalance[owner] -= amountInEth;

         tokenBalance[msg.sender] += amountInEth;
     }

     function sendToken(address _to, uint amount) public {
         require(tokenBalance[msg.sender] >= amount , "NOT ENOUGH BALANCE");

        tokenBalance[msg.sender] -= amount; 
        tokenBalance[_to] += amount;
     }
}


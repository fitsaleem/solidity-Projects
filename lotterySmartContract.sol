// SPDX-License-Identifier: MIT
pragma solidity ^0.8;


contract Lottey {

 
 address public manager;

 address payable [] public  participants;

 address payable public  winnerAddress;

 constructor(){
     manager=msg.sender;
 }

   receive() external payable {

      require(msg.value==0.3 ether , "value must be 0.5 ether");
      participants.push(payable (msg.sender));
   }

   function getBalance() public view returns (uint){
    
    require(msg.sender==manager ,"sender must be a manager");

    return address (this).balance;
    

   }

// now selecting the winner

    function getRandom() public view returns (uint){

     return  uint( keccak256( abi.encodePacked(block.difficulty,block.timestamp,participants.length)));
    }

    function pickWinner() public {

        require(msg.sender==manager ,"must be manager");
        require(participants.length>=2, "require more the 2 users");
        uint r= getRandom();
        uint index= r%participants.length;   //  0 to indext.lenght -1
        winnerAddress=participants[index];

        winnerAddress.transfer(getBalance());
        delete participants;



    }




    
}
pragma solidity ^0.4.4;



contract Splitter {

	address public person1;
	address public person2;
	address public owner;

	mapping(address => uint) public balance;


	function Splitter(address _person1, address _person2){
		owner = msg.sender;
		person1 = _person1;
		person2 = _person2;
		balance[person1] = 0;
		balance[person2] = 0;
	}

	function public payable split(){
		//getting the ammount to be split
		uint ammount = msg.value;

		//if there is no ammount, then throw
		if(ammount <= 0) throw;

		uint half;



	}


}

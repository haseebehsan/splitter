pragma solidity ^0.4.4;



contract Splitter {

// 	address public person1;
// 	address public person2;
	address owner;

	mapping(address => uint) public balance;
	//mapping(address => uint) public withdrawn;

	bool pauser = false;


	function Splitter(){
		owner = msg.sender;
		// person1 = _person1;
		// person2 = _person2;
		// balance[person1] = 0;
		// balance[person2] = 0;
		// withdrawn[person1] = 0;
		// withdrawn[person2] = 0;
	}

	function split(address person1, address person2) public payable {
		
		//if contract has been killed
		if(pauser) throw;
		//if there is no ammount, then throw
		if(msg.value == 0) throw; //changed from <= to == after Rob's suggestion
		//if persons themselves are sending
		// if(msg.sender == person1 || msg.sender == person2) throw; //no more need for that

		uint half;
		uint remain;

		
		half = msg.value /uint(2) ; 		// even odd check not required, because for odd it returns {(msg.sender -1) /2} by default
		remain = msg.value - half - half; 	// changing it, avoiding pultiplication by 2

		balance[person1] += half;
		balance[person2] += half;
		balance[msg.sender] += remain;

		//transfering
		// person1.transfer(balance[person1] - withdrawn[person1]);
		// withdrawn[person1] = balance[person1]; // will be same after tarnfer

		// person2.transfer(balance[person2] - withdrawn[person2]);
		// withdrawn[person2]  = balance[person2]; // will be same after the transfer

		//remaining balance trasfer if necessary
		// if(remain != 0){
		// 	msg.sender.transfer(remain);
		// }

	}

	function withdraw() public returns (bool success){
// 		uint money;
		uint money = balance[msg.sender];
		if(money == 0) throw;

		msg.sender.transfer(money);
		balance[msg.sender] = 0;

		return true;

	}

	function pause() public{
		if(msg.sender != owner) throw;
		pauser = true;
	}

	function unpause() public{
		if(msg.sender != owner) throw;
		pauser = false;
	}


}

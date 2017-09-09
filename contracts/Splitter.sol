pragma solidity ^0.4.4;



contract Splitter {

	address public person1;
	address public person2;
	address owner;

	mapping(address => uint) public balance;
	mapping(address => uint) public withdrawn;

	bool killer = false;


	function Splitter(address _person1, address _person2){
		owner = msg.sender;
		person1 = _person1;
		person2 = _person2;
		balance[person1] = 0;
		balance[person2] = 0;
		withdrawn[person1] = 0;
		withdrawn[person2] = 0;
	}

	function split() public payable {
		

		if(killer) throw;
		//if there is no ammount, then throw
		if(msg.value <= 0) throw;

		uint half;
		uint remain = 0;

		
		half = msg.value /2 ; // even odd check not required, because for odd it returns {(msg.sender -1) /2} by default
		remain = msg.value - (half*2);

		balance[person1] += half;
		balance[person2] += half;

		//transfering
		person1.transfer(balance[person1] - withdrawn[person1]);
		withdrawn[person1] = balance[person1]; // will be same after tarnfer

		person2.transfer(balance[person2] - withdrawn[person2]);
		withdrawn[person2]  = balance[person2]; // will be same after the transfer

		//remaining balance trasfer if necessary
		if(remain != 0){
			msg.sender.transfer(remain);
		}

	}

	function kill() public{
		if(msg.sender != owner) throw;
		kill = true;
	}


}

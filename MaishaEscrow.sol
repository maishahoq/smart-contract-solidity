// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;



contract Escrow
{

    //the state variables
    address  public arbiter;
    address payable public sender;  //Alice, Maisha's account will be Alice over here for test, who will send money to this amrt contract working as an escrow
    address payable public receiver;   //Bob
    address public MaishaToken;
    uint256 deadline;
    uint256 public balance;
    

    mapping (address=>uint256) public depositAll;
    
    // Defining function modifier 'onlyReceiver'
    modifier onlyReceiver(){
        require(msg.sender == receiver, "Only Bob can send funds to himself");
        _;
    }

    // Defining function modifier 'onlyArbiter'
    modifier onlyArbiter(){
        require(msg.sender == arbiter, "Only Arbiter can deploy the contract");
        _;
    }
    // Defining function modifier 'onlyArbiter'
    modifier onlySender(){
        require(msg.sender == arbiter, "Only Sender can deposit funds to the contract");
        _;
    }

    constructor(address payable Alice, address payable Bob){
        // Assigning the values of the 
        // state variables
        arbiter=msg.sender; //whoever deploys the contract is the arbiter
        sender=Alice;
        receiver=Bob;
        //MaishaToken=_MaishaToken;
    }

    function setUser(address payable Alice, address payable Bob) public onlyArbiter{
        sender=Alice;
        receiver=Bob;

    }
    //arbiter is just the deployer of the code, and assigner as in who Alice and Bob are using setusers
    //alice deposits in the code
    //bob withdraws from the code, so bob can withdraw exactly as much as alice has deposited. So, clearout the balance for the array of Alice when Bob withdraws


    function depositMoney() public payable
    {
        require(msg.sender ==sender, "Only Alice can deposit money in the contract");
        uint256 deposit = msg.value;
        //receiver.transfer(amount); how to take money from Alice and store it to the contract
        //depositAll[receiver]=depositAll[receiver]+deposit;
        balance+=deposit;
        //deadline=block.timestamp*1 days;

    }

    function withdrawMoney(uint256 amount) public onlyReceiver payable{
        require(msg.sender ==receiver, "Only Bob can transfer money from the contract to himself");
        require(amount<=balance, "Insufficient Funds");
        //require(block.timestamp >=deadline, "Withdrawal dealine not reached");
        //bool sent = receiver.transferFrom(sender, receiver, amount);
        //require(sent, "Token transfer failed");
        //receiver.transfer(amount);
        //payable(msg.sender).send(address(this).balance);
        payable(receiver).transfer(address(this).balance);
        //depositAll[receiver]=depositAll[receiver]-amount;
        balance=address(this).balance;

    }


    
}

    

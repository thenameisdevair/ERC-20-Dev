// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//Name of the token
//this is optional, and interfaces, and toher contracts must not expect the valuse to be present

event Transfer(address indexed from, address indexed to, uint256 amount);
event Approval(address indexed owner, address indexed spender, uint256 amount);

contract ERC_20  {

    uint256 public totalSupply = 100000000;
    mapping (address => uint) public balanceOf;
    mapping (address => mapping (address => uint)) public allowance;
    string public name = "Devair";
    string public symbol = "DEV";
    uint8 public decimals = 18;


    // function name() public view returns (string memory ) {
    //     return "Devair";
        
    // }

    // function symbol() public view returns (string memory) {
    //     return "dev";
    // }

    // function decimals() public view returns (uint8) {
    //     return 16;
    // }


    // function totalSupply() external view returns(uint256) {
    //     return 1000000;
    // }
    

    // function balanceOf(address _owner) external view returns (uint256);
        // return _owner = balance(msg.sig);


    function transfer(address recipient, uint256 amount) external returns(bool) {
        balanceOf[msg.sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;

    }

    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool){
        allowance[sender][msg.sender] -= amount;
        balanceOf[sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(sender, recipient, amount);
        return true;

    }

    function approve(address spender, uint256 amount) public returns(bool) {
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;

    }

    // function allowance(address _owner, address _spender) public view returns(uint256 remaining) {

    // }


    // function mint(uint256 amount) public {
    //     balanceOf[msg.sender] += amount;
    //     totalSupply += amount;
    //     emit Transfer(address(0), msg.sender, amount);
    // }

    // function burn(uint256 amount) public {
    //     balanceOf[msg.sender] -= amount;
    //     totalSupply -= amount;
    //     emit Transfer(msg.sender, address(0), amount);
    // }
}




// totalsupply = returns the total amount of tokens. 
// balanceOf = the amount of token that an address holds ( sing mapping)
// transfer = token holder, uses transfer to give away some of his tokens to another person( hes gets deducted, the other gets added
// allowance. approve, and transfer from, allows others to transfer token on-behalf of the token holder

// allowance = returns the amount of token that a sender can spend from a token holder. 
// approval = toekn holder uses this to set the amount, that spender can spend.
// transferFrom = called by sender to send token from the token holder to anyone, as long as the amount, doesn't exceed the approved amount
 
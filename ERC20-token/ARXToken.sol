pragma solidity ^0.4.20;

import './SafeMath.sol';
import './ERC20.sol';

/*
 * ARXToken inherits from the ERC20 interface
**/
contract ARXToken is ERC20 {
    /*
     * using [Library] for B; is used to attach library functions (from the library) to any type (B). 
     * These functions will receive the object they are called on as their first parameter (like the self variable in Python).
    **/
    using SafeMath for uint;
     
    string internal _name;
    string internal _symbol;
    uint8 internal _decimals;
    uint256 internal _totalSupply;


    mapping (address => uint256) internal balances;
    mapping (address => mapping (address => uint256)) internal allowed;

    /*
     * Constructor
    **/
    function ARXToken(string name, string symbol, uint8 decimals, uint256 totalSupply) public {
        _symbol = symbol;
        _name = name;
        _decimals = decimals;
        _totalSupply = totalSupply;
        balances[msg.sender] = totalSupply; // The balance of the person deploying the contract will be credited with the total supply of the tokens
    }

    /*
     * Getters
    **/
    function name() public view returns (string) {
        return _name;
    }

    function symbol() public view returns (string) {
        return _symbol;
    }

    function decimals() public view returns (uint8) {
        return _decimals;
    }

    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    /*
     * Transfer _value tokens from the msg.sender account's to the recipient's address (_to)
    **/
    function transfer(address _to, uint256 _value) public returns (bool) {
        require(_to != address(0));
        require(_value <= balances[msg.sender]);
        balances[msg.sender] = SafeMath.sub(balances[msg.sender], _value);
        balances[_to] = SafeMath.add(balances[_to], _value);
        Transfer(msg.sender, _to, _value);
        return true;
    }

    /*
     * Check the balance of the address _owner
    **/
    function balanceOf(address _owner) public view returns (uint256 balance) {
        return balances[_owner];
    }

    /*
     * Do a transfer of _value tokens, from the address _from if the msg.sender is allowed by that address to spend this amount of tokens
    **/
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool) {
        require(_to != address(0));
        require(_value <= balances[_from]);
        require(_value <= allowed[_from][msg.sender]);

        balances[_from] = SafeMath.sub(balances[_from], _value);
        balances[_to] = SafeMath.add(balances[_to], _value);
        allowed[_from][msg.sender] = SafeMath.sub(allowed[_from][msg.sender], _value);
        Transfer(_from, _to, _value);
        return true;
   }

    /*
     * Sets an amount of tokens a specified address (_spender) is allowed to spend on behalf of the msg.sender
    **/
    function approve(address _spender, uint256 _value) public returns (bool) {
        allowed[msg.sender][_spender] = _value;
        Approval(msg.sender, _spender, _value);
        return true;
    }

    /*
    * Checks the amount of tokens that an _owner allowed a _spender to spend on his behalf
    **/
    function allowance(address _owner, address _spender) public view returns (uint256) {
        return allowed[_owner][_spender];
    }

    /*
    * Increases the amount of tokens that an _owner allows a _spender to spend on his behalf
    **/
    function increaseApproval(address _spender, uint _addedValue) public returns (bool) {
        allowed[msg.sender][_spender] = SafeMath.add(allowed[msg.sender][_spender], _addedValue);
        Approval(msg.sender, _spender, allowed[msg.sender][_spender]);
        return true;
    }
    
    /*
    * Decreases the amount of tokens that an _owner allows a _spender to spend on his behalf
    **/
    function decreaseApproval(address _spender, uint _subtractedValue) public returns (bool) {
        uint oldValue = allowed[msg.sender][_spender];
        if (_subtractedValue > oldValue) {
            allowed[msg.sender][_spender] = 0;
        } else {
            allowed[msg.sender][_spender] = SafeMath.sub(oldValue, _subtractedValue);
        }
        Approval(msg.sender, _spender, allowed[msg.sender][_spender]);
        return true;
    }

    /*
     * Refuse and sends back any ETH
    **/
    function () public payable {
        revert();
    }
}

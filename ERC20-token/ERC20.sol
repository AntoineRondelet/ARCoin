pragma solidity ^0.4.20;

/*
 * Interfaces are similar to abstract contracts, but they cannot have any functions implemented.
 * See: https://solidity.readthedocs.io/en/develop/contracts.html?highlight=interface#interfaces
**/
interface ERC20 {
  function balanceOf(address who) public view returns (uint256);
  function transfer(address to, uint256 value) public returns (bool);
  function allowance(address owner, address spender) public view returns (uint256);
  function transferFrom(address from, address to, uint256 value) public returns (bool);
  function approve(address spender, uint256 value) public returns (bool);
  event Transfer(address indexed from, address indexed to, uint256 value);
  event Approval(address indexed owner, address indexed spender, uint256 value);
}

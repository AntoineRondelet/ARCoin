pragma solidity ^0.4.20; 
/*
 * "pragma" indicates the version of solidity used, in order to reject compilations 
 *  with compilers that might introduce incompatible changes.
 * See: https://solidity.readthedocs.io/en/develop/layout-of-source-files.html 
 * for more details about the layout of solidity source files
**/

library SafeMath {
  function mul(uint256 a, uint256 b) internal pure returns (uint256) {
    if (a == 0) {
      return 0;
    }
    uint256 c = a * b;
    /*
     * assert() "is like require(), but it uses all of the remaining gas if it fails.
     * See: https://medium.com/blockchannel/the-use-of-revert-assert-and-require-in-solidity-and-the-new-revert-opcode-in-the-evm-1a3a7990e06e
     * for more details
    **/
    assert(c / a == b);
    return c;
  }

  function div(uint256 a, uint256 b) internal pure returns (uint256) {
    assert(b > 0); // Although, solidity automatically throws when dividing by 0
    uint256 c = a / b;
    return c;
  }

  function sub(uint256 a, uint256 b) internal pure returns (uint256) {
    assert(b <= a);
    return a - b;
  }

  function add(uint256 a, uint256 b) internal pure returns (uint256) {
    uint256 c = a + b;
    assert(c >= a);
    return c;
  }
}

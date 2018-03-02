# AR Coin (ARX)

Project done to play around with solidity, and ERC-20/ERC-223 tokens

## Deploy the Token to the testnet (using Geth)

1. Compile the contracts
```bash
echo "var tokenCompilationOutput=`solc --optimize --combined-json abi,bin,interface ERC20-token/StandardToken.sol`" > standardToken.js
```
_Note:_ We can get generate the ABIs of the contracts in separate files, using:
```bash
solcjs --abi ERC20-token/SafeMath.sol ERC20-token/ERC20.sol ERC20-token/StandardToken.sol
```
2. Start the geth testnet (Follow the instructions in eth-private-net)
3. In geth, run:
```
loadScript('standardToken.js')
var tokenABI = tokenCompilationOutput.contracts['ERC20-token/StandardToken.sol:StandardToken'].abi
var tokenBin = "0x" + tokenCompilationOutput.contracts['ERC20-token/StandardToken.sol:StandardToken'].bin
var deployTransationObject = { from: eth.accounts[0], data: tokenBin, gas: 1000000 };
var tokenContract = eth.contract(JSON.parse(tokenABI));

personal.unlockAccount(eth.accounts[0]);

var tokenName = "AR Coin";
var tokenSymbol = "ARX";
var tokenDecimals = 7;
var tokenTotalSupply = 1000000000;
var tokenInstance=tokenContract.new(tokenName,tokenSymbol,tokenDecimals,tokenTotalSupply,deployTransationObject,function(n,o){n?console.log(n):o.address?(console.log("Contract mined! Address: "+o.address),console.log(o)):console.log("Contract transaction send: TransactionHash: "+o.transactionHash+" waiting to be mined...")});

var token = tokenContract.at(tokenInstance.address);
```

The token is created at this stage ! The account `eth.accounts[0]` should been credited of 100 ARX.
Verify it by running:
```bash
token.balanceOf(eth.accounts[0]);
```

## Resources

- https://github.com/OpenZeppelin/zeppelin-solidity
- https://solidity.readthedocs.io/en/develop/
- https://github.com/ConsenSys/smart-contract-best-practices/tree/master/docs
- https://medium.com/blockchannel/the-use-of-revert-assert-and-require-in-solidity-and-the-new-revert-opcode-in-the-evm-1a3a7990e06e
- https://medium.com/@Alt_Street/create-your-own-ethereum-token-bfa6302084da
- https://medium.com/@Alt_Street/create-your-own-ethereum-token-part-2-erc223-3076f764cf62
- https://steemit.com/ethereum/@maxnachamkin/how-to-create-your-own-ethereum-token-in-an-hour-erc20-verified
- http://nuclearcryptobuddha.blog/2017/06/how-to-send-receive-and-check-balance-of-erc20-tokens-using-geth/
- https://medium.com/mercuryprotocol/dev-highlights-of-this-week-cb33e58c745f
- https://github.com/ethereum/go-ethereum/wiki/Contract-Tutorial#compile-and-deploy

# Start your ethereum custom node

Run:
```bash
mkdir ~/ethdev

geth --datadir ~/ethdev init genesis.json
geth --datadir ~/ethdev account new --password password 
geth --datadir ~/ethdev --identity=NODE_ONE --networkid=15 --verbosity=1 --mine --minerthreads=1 --rpc --rpcport=8545 --nodiscover --maxpeers=1 console
```

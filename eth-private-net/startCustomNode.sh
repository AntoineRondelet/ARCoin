#!/bin/bash

if [ ! -f "./geth" ]; then 
    echo "==> Fetching GETH 1.8.1 (Last stable version) <=="
    wget https://gethstore.blob.core.windows.net/builds/geth-linux-amd64-1.8.1-1e67410e.tar.gz
    echo "Unpacking GETH 1.8.1"
    tar -xvf geth-linux-amd64-1.8.1-1e67410e.tar.gz
fi

echo "==> Creating ~/ethdev folder <=="
mkdir ~/ethdev

echo "==> Initializing the private blockchain with custom genesis file <=="
./geth --datadir ~/ethdev init genesis.json

echo "==> Starting miner node: Listening rpc on 8545 <=="
./geth --datadir ~/ethdev --identity=NODE_ONE --networkid=15 --verbosity=1 --mine --minerthreads=1 --rpc --rpcport=8545 --nodiscover --maxpeers=1 console

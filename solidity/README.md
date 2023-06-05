Install require packages: 
```
npm install
```

Launch ganache blockchain with 10 accounts on port 8545:
```
ganache -a 10 -p 8545
```
You should see a blockchain server listening on ``127.0.0.1:8545``.

Next, open another terminal, run all tests (requries blockchain running on port 8545):
```
truffle test
```
You should see the gas cost for each transaction, and all 21 tests passing.


<!-- curl -H 'Content-Type: application/json' --data '{"jsonrpc":"2.0", "id": 1, "method": "debug_traceTransaction", "params": [ "0xc602b44685ac627d3df76a7f68e8b0157d65d0f898b68a89b2c91e24c4e3bb60" ] }' http://127.0.0.1:8545 -->


## run test against geth
docker is needed
```
GETH=true ./scripts/geth.sh 
truffle test
curl -H 'Content-Type: application/json' --data '{"jsonrpc":"2.0", "id": 1, "method": "debug_traceTransaction", "params": [ "{result.tx/transaction hash}" ] }' http://127.0.0.1:8545


```

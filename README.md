IRR Calculator in Node and Solidity

*** Solidity Smart Contract not fully working ***


Installation:
```
npm install
```
Solidity Operation: (in seperate terminals)
```
npx hardhat node
```
```
npx hardhat test --network localhost
```

Notes on Solidity Implementation:
- running test deploys smart contract on local chain
- due to not supporting floating points, users are expected to enter  'guess' rate as a scaled decimal by 5 palces. (.20 => 20000)
- restricted access to 'financial anylists'
- spent ~18 hours total on implementation

Biggest Challenge:
- Floating point arichmitic, I have never needed to utilize this type of math which was the biggest hurdle.
- I couldnt figure out how to handle fixed points when performing exponent math (x^y) which is the major reason my math is incorrect.


Node Operation:
```
node index.js
```

Notes on Node Implementation: (IRR methods inside core.js)
- configure n inside constants file
- use index.js to use core methods
- returns actual IRR after executing n guesses
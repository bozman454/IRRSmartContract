const { irr, guessIRR } = require('./core')

const input = [
    -100.00,
    14.00,
    25.00,
    16.00,
    12.00,
    79.00,
    36.00,
    42.00
];

const rate = .2

console.log( irr(input, rate) ) 




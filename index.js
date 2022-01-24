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


console.log( guessIRR(input, 20) ) 

//console.log(irr(input, .2))
//console.log(irr(input, .19883))
//console.log(irr(input, .18))

// const values = [
//     -100.00,
//     14.00,
//     25.00,
//     16.00,
//     12.00,
//     79.00,
//     36.00,
//     42.00
// ];

// const irrrate = .2

// const scale = 100000

// var scaledValues =[]

// values.map(v => scaledValues.push( v * scale))

// console.log(scaledValues)



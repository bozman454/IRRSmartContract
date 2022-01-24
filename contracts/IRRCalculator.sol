pragma solidity ^0.5.0;

import "hardhat/console.sol";
import "@hq20/fixidity/contracts/FixidityLib.sol";
import "@hq20/fixidity/contracts/ExponentLib.sol";

contract IRRCalculator  {
    using FixidityLib for int;
    int IRR = 0;
    constructor(uint _rate, int[] memory _values) public{
        
        for(uint i = 0; i < _values.length; i++){

            uint denom =  (_rate + 1) **  i;
            console.logUint(denom);
            int npv = FixidityLib.divide(_values[i].toFixed(), int(denom).toFixed());
            console.logInt(npv);
            //npv = FixidityLib.multiply(npv, FixidityLib.digits() ** 10);
            //uint npv = (values[i] / denom) / (10 ** FixidityLib.digits()); 
            IRR = IRR + npv;
        }
           

    }
    function getIRR() public view returns (int){
        return IRR;
    }

    // function setIRR() public {
    //     for(uint i = 0; i < values.length; i++){
    //         int denom = ExponentLib.powerAny((a.toFixed() + rate), int(i));

    //         int npv = values[i] / denom;
    //         console.logInt(npv);
    //         IRR = IRR + npv;
    //     }
        
    // }

    
    
}
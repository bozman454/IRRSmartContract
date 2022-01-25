pragma solidity ^0.5.0;

import "hardhat/console.sol";
import "@hq20/fixidity/contracts/FixidityLib.sol";
import "@hq20/fixidity/contracts/ExponentLib.sol";


 library IRRGen {
    using FixidityLib for int;

        function guessIRR(uint _rate, int[] memory _values) internal pure returns (int){
            int irr = 0;
            for(uint i = 0; i < _values.length; i++){
            uint denom =  (_rate + 1) **  i;
            int npv = FixidityLib.divide(_values[i].toFixed(), int(denom).toFixed());
            irr = irr + npv;
            }
            return irr;
        }
    }



contract IRRCalculator  {
    int IRR = 0;
    uint n = 100;
    uint rate = 0;
    constructor(uint _rate, int[] memory _values) public{
        IRR = IRRGen.guessIRR(_rate, _values);
        console.logInt(FixidityLib.fromFixed(IRR, 24));
        // if (IRR < 0){
        //     for(uint i = 0; i < n; i++){
        //     _rate = _rate - 2;
        //     IRR = IRRGen.guessIRR(_rate, _values);
        //     console.logInt(IRR);
        //     console.log("rate: ", _rate);
        //     }
        // }
        
    }
    function getIRR() public view returns (int){
        return IRR;
    }

    
}
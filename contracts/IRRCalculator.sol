pragma solidity ^0.5.0;

import "hardhat/console.sol";
import "@hq20/fixidity/contracts/FixidityLib.sol";
import "@hq20/fixidity/contracts/ExponentLib.sol";

contract IRRCalculator  {
    int IRR = 0;
    uint constant p = 10 ** 5;

    struct Analyist {
        address origin;
    }
    address public emp;
    mapping(address => Analyist) public employees;

    constructor(uint _rate, int[] memory _values) public {
        require(_rate > 0, "Guess rate cannot be negative");
        //take sender's info
        emp = msg.sender;
        employees[emp].origin = emp;

        _rate = _rate * uint(p);
        for(uint i = 0; i < _values.length; i++){
            _values[i] = _values[i] * int(p);
        }


        IRR = guessIRR(_rate, _values);
        
       
        
    }

    function guessIRR(uint _rate, int[] memory _values) internal returns (int){


            require(msg.sender == emp, "Only financial analyists can access this interface");
            require(_rate > 0, "Guess rate cannot be negative");
            require(_values.length > 0, "Values entered cannot be empty");

            int irr = 0;
            uint p = 10 ** 5;
            for(uint i = 0; i < _values.length; i++){
            uint denom = (_rate ) ** i;
            //int x = FixidityLib.divide(int(denom), int(i) * 10);
            //console.logInt(x);
            int npv = FixidityLib.multiply((_values[i]), FixidityLib.reciprocal(int(denom)) );

            irr = irr + npv;
            }
            return irr;
        }

    function getIRR() public view returns (int){
        return IRR;
    }

    
}
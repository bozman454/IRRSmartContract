pragma solidity ^0.5.0;

//used for testing (very helpful)
import "hardhat/console.sol";
//used for math w/ over + under flow protection
import "@hq20/fixidity/contracts/FixidityLib.sol";
//used to calculate exponents w/ over + under flow protection
import "@hq20/fixidity/contracts/ExponentLib.sol";

contract IRRCalculator {
    //employee struct for handlng roles / sender origin
    struct Employees {
        string role;
        address origin;
    }
    //map for easy access
    mapping(address => Employees) public employees;
    address public emp;
    //stores irr
    int256 IRR = 0;
    // scale constant
    uint256 constant p = 10**5;

    //takes a scaled rate, array of integers, role from sender
    constructor(
        uint256 _rate,
        int256[] memory _values,
        string memory _role
    ) public {
        //take sender's info
        emp = msg.sender;
        //assign origin as sender's address
        employees[emp].origin = emp;
        //assign sender's role
        employees[emp].role = _role;

        //scale rate
        //_rate = _rate * uint256(p);
        for (uint256 i = 0; i < _values.length; i++) {
            //scale each entry in _values
            _values[i] = _values[i] * int256(p);
        }

        //calculate IRR given inputs
        IRR = guessIRR(_rate, _values);
    }

    //TODO: figure out how to scale fixed point after exponents
    function guessIRR(uint256 _rate, int256[] memory _values)
        internal
        returns (int256)
    {
        

        //ensure values is not empty
        require(_values.length > 0, "Values entered cannot be empty");

        //temporary variable to hold calculation
        int256 irr = 0;

        for (uint256 i = 0; i < _values.length; i++) {

            uint256 denom = (_rate)**i;
            //use FixidityLib to do math with over / under flow protection
            int256 npv = FixidityLib.multiply(
                (_values[i]),
                FixidityLib.reciprocal(int256(denom))
            );
            irr = irr + npv;
        }
        return irr;
    }

    function irr() public view returns (int256) {
        //check sender's role
        //use keccak256 to turn into bytes for comparison
        require(
            keccak256(bytes(employees[msg.sender].role)) ==
                keccak256(bytes("financial analyst")),
            "Only financial analyists can access this interface"
        );
        return IRR;
    }
}

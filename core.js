const {CONSTANTS} = require('./constants')

/*
* @brief : calculates internal rate of return from inputs
* @param values : array of integers 
* @param guess : percentage as decimal
* @returns resultRate : calculated rate of return using guess
*/
function irr(values, guess) {
    //set up configuration on number of guess and rate of change on each guess
    let n = CONSTANTS.NUMBER_OF_GUESSES
    let rateofchange = CONSTANTS.RATE_CHANGE
    let rate = guess
    let resultarr = []
    // if the result is negative, the rate is too small
    if (guessIRR(values, guess) > 0) {
        for (let i = 0; i < n; i++) {
            //calculate irr for each potential change in rate n times
            resultarr.push({ result: guessIRR(values, rate), rate: rate })
            rate = rate + rateofchange
        }
    } else if (guessIRR(values, guess) < 0) {
        for (let i = 0; i < n; i ++){
            resultarr.push({result : guessIRR(values, rate) , rate: rate})
            rate = rate - rateofchange
        }
    }
    //sort the array to access the smallest value first in array everytime
    //smallest result is the closest to 0, i.e. correct rate 
    resultarr = resultarr.filter(item => item.result < .05 && item.result > 0).sort((a, b) => {return a.result - b.result})
    //return percantage rounded to 5 decimal place
    return (resultarr[0].rate).toFixed(5)

}

/*
* @brief : calculates internal rate of return from rate provided
* @param values : array of integers 
* @param rate : percentage as decimal
* @returns resultRate : calculated rate of return using guess
*/
function guessIRR(values, rate) {
    let result = 0
    values.forEach((cashFlow, index) => {
        npv = (cashFlow / Math.pow((1 + rate), index))
        result += npv
    });
    return result
}

module.exports = {
    irr,
    guessIRR
}

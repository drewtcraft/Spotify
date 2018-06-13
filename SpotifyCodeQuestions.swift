        func sortByString(inputString: String, sortString: String) -> String {
            //create new string variable to accumulate rearranged characters
            var str = ""

            //iterate through the sort string characters
            for sortChar in sortString.characters{
                //iterate through all input string characters for each sort string character
                for inputChar in inputString.characters {
                    //for every match, append to accumulator
                    if inputChar == sortChar {
                        str.append(inputChar)
                    }
                }
            }

            return str
        }

        print(sortByString(inputString: "weather", sortString: "therapyw"))
        print(sortByString(inputString: "good", sortString: "odg"))


        func explodeDeepestBracket(encodedStr: String) -> String {
            //set a string index
            let indexType = encodedStr.index(encodedStr.startIndex, offsetBy: 0)
            //create variables for the bracket to be exploded
            var indexOfDeepestOpenBracket = indexType
            var indexOfCorrespondingClosingBracket = indexType

            //create variables for multiplier, the index of the first char inside the bracket,
            // and the substrings before and after the bracket
            var multiplier = 0
            var firstIndexInsideBracket = indexType
            var prefixToExplodingBracket = ""
            var suffixToExplodingBracket = ""

            //find last open bracket
            var i = 0
            while i < encodedStr.characters.count-1 {
                let index = encodedStr.index(encodedStr.startIndex, offsetBy: i)
                if encodedStr[index] == "[" {
                    //set last open bracket
                    indexOfDeepestOpenBracket = index
                    //set multiplier to bracket index - 1
                    multiplier = Int(String(encodedStr[encodedStr.index(encodedStr.startIndex, offsetBy: i-1)]))!
                    //set prefix to entire string before multiplier index
                    prefixToExplodingBracket = String(encodedStr[encodedStr.startIndex..<encodedStr.index(encodedStr.startIndex, offsetBy: i-1)])
                    //set index of first char inside bracket
                    firstIndexInsideBracket = encodedStr.index(encodedStr.startIndex, offsetBy: i+1)
                }
                i += 1
            }

            //set an Int variable for the length of the string we traversed to get to the first open bracket
            var x = encodedStr.distance(from: encodedStr.startIndex, to: indexOfDeepestOpenBracket)
            //find first closing bracket after the open bracket we already found
            while x < encodedStr.characters.count-1 {
                let index = encodedStr.index(encodedStr.startIndex, offsetBy: x)
                if encodedStr[index] == "]" {
                    //set index of closing bracket
                    indexOfCorrespondingClosingBracket = index
                    //set suffix to entire string after closing bracket
                    suffixToExplodingBracket = String(encodedStr[encodedStr.index(encodedStr.startIndex, offsetBy: x+1)..<encodedStr.endIndex])
                    //break once we find the bracket and set our variables
                    break
                }
                x += 1
            }

            //create variable for string between brackets
            var stringToBeMultiplied = ""

            //substring the string inside of the bracket
            if firstIndexInsideBracket < indexOfCorrespondingClosingBracket {
                 stringToBeMultiplied = String(encodedStr[firstIndexInsideBracket..<indexOfCorrespondingClosingBracket])
            } else {
                stringToBeMultiplied = String(encodedStr[encodedStr.index(encodedStr.startIndex, offsetBy: 2)..<encodedStr.index(encodedStr.endIndex, offsetBy: -1)])
            }

            //create variable for the result of the stringToBeMultiplied post-multiplication
            var explodedBracket = ""

            //add the stringToBeMultiplied to the explodedBracket variable times the multiplier
            for _ in 0..<multiplier {
                explodedBracket.append(stringToBeMultiplied)
            }

            //add in the prefix and suffix strings on either side of the exploded bracket
            let fullStringWithBracketExploded = prefixToExplodingBracket + explodedBracket + suffixToExplodingBracket

            //return the new string
            return fullStringWithBracketExploded
        }


        //master function for decoding string
         func decodeString(inputStr: String) -> String {

            if inputStr.range(of:"[") != nil {
                let explodeOne = explodeDeepestBracket(encodedStr: inputStr)
                return decodeString(inputStr: explodeOne)
           }
           else {
             return inputStr
           }

         }

        print(decodeString(inputStr: "1[7[i love you ]night man ]"))

        func changePossibilities(denominations: [Int], target: Int)->Int {
            //track combinations
            var combinations = 0

            //internal helper function
            func findPossibilities(d: [Int], t: Int, i: Int){

                //set new starting index so repeat combinations are not counted
                var x = i

                //loop through remaining denominations
                while x < d.count {
                    if t == 0 {
                        print("got one")
                        combinations += 1
                        break
                    } else if t < 0 {
                        print("target is low")
                        break
                    }

                    //recurse to find all solutions
                    findPossibilities(d: d, t: t - d[x], i: x)

                    x += 1

                }
            }

            findPossibilities(d: denominations, t: target, i: 0)

            return combinations
        }


        print(changePossibilities(denominations: [3, 2, 1, 6, 7], target: 10))

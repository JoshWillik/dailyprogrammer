findSadCycle :: Int -> Int -> [Int]
findSadCycle

addDigitPowers :: Int -> Int -> Int
addDigitPowers num power = sum $ [round $ (read [digit]) ** (fromIntegral power) | digit <- show num]

main :: IO ()
main = do
  rawPower <- getLine
  rawNumber <- getLine

  let power = read rawPower :: Int
  let number = read rawNumber :: Int

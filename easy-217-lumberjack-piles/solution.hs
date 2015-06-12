-- Solution for https://www.reddit.com/r/dailyprogrammer/comments/3840rp/20150601_challenge_217_easy_lumberjack_pile/

distributeLogs :: Int -> Int -> [Int] -> [Int]
distributeLogs 0 match stacks = stacks
distributeLogs logs counter stacks =
  distributeLogs (logs - toDeposit) ( counter + 1) alteredStacks
  where availableDeposit = length $ filter (==counter) stacks
        toDeposit = min logs availableDeposit
        alteredStacks = deposit toDeposit (==counter) stacks

deposit :: Int -> (Int -> Bool) -> [Int] -> [Int]
deposit remaining match [] = []
deposit 0 match stacks = stacks
deposit remaining match (el:rest) =
  (transform el (+1)) : (deposit (transform remaining (subtract 1)) (match) rest)
  where transform = (\ n op -> if (match el) then op n else n)

showLogs :: [Int] -> Int -> IO()
showLogs [] lineSize = return ()
showLogs piles lineSize = do
  putStrLn $ unwords [ show x | x <- take lineSize piles ]
  showLogs (drop lineSize piles) lineSize


main :: IO ()
main = do
  input <- getContents
  let (lineSize:logs:rawStacks) = lines input
  let stacks = [ read y :: Int | y <- concat [ words x | x <- rawStacks ] ]
  print $ show stacks
  let filledStacks = distributeLogs (read logs :: Int) 1 stacks
  showLogs filledStacks (read lineSize :: Int)

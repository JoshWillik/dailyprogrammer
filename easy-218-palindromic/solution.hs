-- Solution for https://www.reddit.com/r/dailyprogrammer/comments/38yy9s/20150608_challenge_218_easy_making_numbers/

palindrome :: Integer -> String
palindrome x = show x ++ " becomes " ++ show num ++
               " in " ++ show steps ++ " steps"
               where (num, steps) = findPalindrome x 0


rev :: Integer -> Integer
rev x = read (reverse $ show x) :: Integer

isPalindrome :: Integer -> Bool
isPalindrome x = x == rev x

findPalindrome :: Integer -> Integer -> (Integer,Integer)
findPalindrome x steps = if isPalindrome x
                         then (x, steps)
                         else findPalindrome (x + (rev x)) (steps + 1)

main = do
  putStrLn "Which number would you like to find a palindrome for?"
  p <- getLine
  print $ palindrome $ read p

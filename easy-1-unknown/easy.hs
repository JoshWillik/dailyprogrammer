main = do
  putStrLn "What is your name?"
  name <- getLine
  putStrLn "What is your age?"
  age <- getLine
  putStrLn "What is your reddit username?"
  username <- getLine
  putStrLn ("Hello there, " ++ name ++ ", you are " ++ age ++ " years old and go by " ++ username )

incrementHeap :: Int -> Int -> [Int] -> [Int]
incrementHeap left match pile =

main = do
  input <- getContents
  let lines' = lines input
  let blockLength = length $ words $ lines' !! 1
  let toAdd = read (head lines') :: Int
  let block = concat [ words x | x <- tail lines' ]

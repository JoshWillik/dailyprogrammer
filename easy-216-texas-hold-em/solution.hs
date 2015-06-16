import System.Random (getStdGen,)
import System.Random.Shuffle (shuffle',)

data Suit = Hearts
  | Clubs
  | Spades
  | Diamonds
  deriving (Enum,Show)

data Rank =
  Ace
  | Two
  | Three
  | Four
  | Five
  | Six
  | Seven
  | Eight
  | Nine
  | Ten
  | Jack
  | Queen
  | King
  deriving (Enum,Show)

data Card = Card Suit Rank deriving Show

type Hand = [Card]
type Deck = [Card]

fullDeck :: Deck
fullDeck = [ Card s r | s <- [Hearts .. Diamonds], r <- [Ace .. King] ]

shuffleDeck :: Deck -> IO (Deck)
shuffleDeck deck = do
  gen <- getStdGen
  return $ shuffle' deck (length deck) gen

pullCards :: Int -> Deck -> ([Card], Deck)
pullCards num deck = (cards, newDeck)
                     where cards = take num deck
                           newDeck = drop num deck

getHands :: Int -> Int -> Deck -> ([Hand], Deck)
getHands 0 _ remainingDeck = ([], remainingDeck)
getHands hands handSize deck = ((newHand:nextHands), nextDeck)
                               where (newHand, deckTail) = pullCards handSize deck
                                     (nextHands, nextDeck) = getHands (hands - 1) handSize deckTail

burnAndRetrieve :: Int -> Deck -> ([Card], Deck)
burnAndRetrieve num deck = (drop 1 cards, newDeck)
                           where (cards, newDeck) = pullCards (num + 1) deck
main :: IO()
main = do
  putStrLn "How many players? (2-8)"
  playerCount <- getLine
  startingDeck <- shuffleDeck fullDeck
  let (playerHand, deck) = getHands 1 3 startingDeck
  let (hands, deck') = getHands (read playerCount) 3 deck
  let (flop, deck'') = burnAndRetrieve 3 deck'
  let (turn, deck''') = burnAndRetrieve 1 deck''
  let (river, _) = burnAndRetrieve 1 deck'''
  putStrLn $ "Your hand: " ++ show (playerHand !! 0)
  mapM putStrLn $ map (\hand -> "Computer hand: " ++ show hand ) hands
  putStrLn $ "Flop: " ++ show flop
  putStrLn $ "Turn: " ++ show (turn !! 0)
  putStrLn $ "River: " ++ show (river !! 0)

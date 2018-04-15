module LearnParsers where
import           Control.Applicative
import           Text.Parser.Combinators
import           Text.Trifecta

stop :: Parser a
stop = unexpected "stop"

one :: Parser Char
one = char '1'

two :: Parser Char
two = char '2'

one' = one >> stop

-- oneTwo :: Parser Char
-- oneTwo = one . two

oneTwo :: Parser Char
oneTwo = one >> two

oneTwo' :: Parser Char
oneTwo' = oneTwo >> stop

oneTwoThree :: Parser String
oneTwoThree = (string "123") <|> (string "12") <|> (string "1")

pNL :: String -> IO ()
pNL s =
    putStrLn ('\n' : s)

charSeq :: Char -> Parser Char -> Parser Char
charSeq a b =
    (char a) >> b

listOfCharsParsers :: [Char] -> Parser Char
listOfCharsParsers xs = foldr (charSeq) stop xs

addEOF :: Parser a -> Parser ()
addEOF p = p >> eof

testParse :: Parser Char -> IO ()
testParse p =
    print $ parseString p mempty "123"

testParse' :: Parser String -> IO()
testParse' p =
    print $ parseString p mempty "123"

testParse'' :: Parser String -> IO ()
testParse'' p =
    print $ parseString p mempty "12"

testParse''' :: Parser String -> IO ()
testParse''' p =
    print $ parseString p mempty "1"

testParseForList :: Parser Char -> [Char] -> IO ()
testParseForList p cc =
    print $ parseString p mempty cc

testEOF :: Parser () -> [Char] -> IO ()
testEOF p cc =
    print $ parseString p mempty cc

charParser :: [Char] -> Parser ()
charParser xs = foldr (\a b -> (char a) >> b) eof xs

-- testParse'''' :: Parser Char -> IO ()
-- testParse'''' p =
--     print $ parseString p mempty

main :: IO ()
main = do
  pNL "stop:"
  testParse stop
  pNL "one:"
  testParse one
  pNL "one'"
  testParse one'
  pNL "oneTwo"
  testParse oneTwo
  pNL "oneTwo':"
  testParse oneTwo'
  pNL "oneTwoThree:"
  testParse' oneTwoThree
  pNL "oneTwo:"
  testParse'' oneTwoThree
  pNL "one:"
  testParse''' oneTwoThree
  pNL "string type text with Parser Char"
  testParseForList (listOfCharsParsers "arul") "arul"
  pNL "String with EOF"
  testEOF (charParser "arulselvan") "arulselvan"

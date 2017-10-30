import           Control.Monad (forever)

type Name = String
type Age = Integer

data Person = Person Name Age deriving (Eq, Show)

data PersonInvalid =
    NameEmpty
    | AgeTooLow
    | PersonInvalidUnknown String
    deriving (Eq, Show)

mkPerson :: Name -> Age -> Either PersonInvalid Person
mkPerson name age
    | name /= "" && age > 0 = Right $ Person name age
    | name == "" = Left NameEmpty
    | not (age > 0) = Left AgeTooLow
    | otherwise =
          Left $ PersonInvalidUnknown $
          "Name was: " ++ show name ++ "age was: " ++ show age

gimmePerson :: IO()
gimmePerson = forever $ do
    putStrLn "Enter the name:"
    name <- getLine
    putStrLn "Enter age:"
    age <- getLine
    case reads age of
      [(val, "")] -> do
          putStrLn $ show (mkPerson name val)
          return ()
      _ -> do
          putStrLn $ show (mkPerson name 0)

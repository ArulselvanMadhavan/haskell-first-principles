module Ex1 where
import           Control.Applicative
import           Text.Trifecta

data NumberOrString
  = NOSS String
  | NOSI Integer
  deriving (Ord, Eq, Show)

type Major = Integer
type Minor = Integer
type Patch = Integer
type Release = [NumberOrString]
type Metadata = [NumberOrString]

data SemVer =
  SemVer Major
         Minor
         Patch
         Release
         Metadata
  deriving (Ord, Eq, Show)

parseDotOrDash :: Parser Char
parseDotOrDash = char '.' <|> char '-'

parseDotOrPlus :: Parser Char
parseDotOrPlus = char '+' <|> char '.'

parseNOS :: Parser NumberOrString
parseNOS = do
  (NOSS <$> some letter) <|> (NOSI <$> integer)

parseNOS' :: Parser NumberOrString
parseNOS' = do
  _ <- parseDotOrDash
  parseNOS

parseNOS'' :: Parser NumberOrString
parseNOS'' = do
  _ <- parseDotOrPlus
  parseNOS

parseEOF :: Parser [NumberOrString]
parseEOF = do
  eof
  return ([] :: [NumberOrString])

parseRelease :: Parser [NumberOrString]
parseRelease = do
  parseEOF <|> some parseNOS'

parseMetaData :: Parser [NumberOrString]
parseMetaData = do
  parseEOF <|> some parseNOS''

parseSemVer :: Parser SemVer
parseSemVer = do
  mjr <- integer
  char '.'
  mnr <- integer
  char '.'
  p <- integer
  rs <- parseRelease
  md <- parseMetaData
  return $ SemVer mjr mnr p rs md

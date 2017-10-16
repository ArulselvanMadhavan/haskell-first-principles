import           Data.Time

data DatabaseItem = DbString String
                  | DbNumber Integer
                  | DbDate UTCTime
                  deriving (Eq, Ord, Show)


theDatabase :: [DatabaseItem]
theDatabase =
    [DbDate (UTCTime
            (fromGregorian 1911 5 1)
            (secondsToDiffTime 34123))
    , DbNumber 9001
    , DbString "Hello, world!"
    , DbDate (UTCTime
             (fromGregorian 1921 5 1)
             (secondsToDiffTime 34123))
    ]

selectUTCTime:: DatabaseItem -> Bool
selectUTCTime (DbDate _) = True
selectUTCTime _          = False

selectDbNumber :: DatabaseItem -> Bool
selectDbNumber (DbNumber _) = True
selectDbNumber _            = False

-- getUTCTime :: DatabaseItem -> UTCTime
-- getUTCTime (DbDate x) = x

filterDbDate :: [DatabaseItem] -> [UTCTime]
filterDbDate =
    map (\(DbDate x) -> x) . filter selectUTCTime

filterDbNumber :: [DatabaseItem] -> [Integer]
filterDbNumber =
    map (\(DbNumber x) -> x) . filter selectDbNumber


mostRecent :: [DatabaseItem] -> UTCTime
mostRecent =
    maximum . map (\(DbDate x) -> x) . filter selectUTCTime

sumDb :: [DatabaseItem] -> Integer
sumDb =
    sum . map (\(DbNumber x) -> x) . filter selectDbNumber

avg :: [Integer] -> Double
avg xs =
    (/) (fromIntegral . sum $ xs)  (fromIntegral . length $ xs)

avgDb :: [DatabaseItem] -> Double
avgDb =
    avg . map (\(DbNumber x) -> x) . filter selectDbNumber

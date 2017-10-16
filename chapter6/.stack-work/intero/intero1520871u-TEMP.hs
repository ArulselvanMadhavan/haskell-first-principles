data DayOfWeek = Mon | Tue | Wed | Thu | Fri | Sat | Sun deriving (Eq, Show)

data Date = Date DayOfWeek Int

-- instance Eq DayOfWeek where
--   (==) Mon Mon = True
--   (==) Tue Tue = True
--   (==) Wed Wed = True
--   (==) Thu Thu = True
--   (==) Fri Fri = True
--   (==) Sat Sat = True
--   (==) Sun Sun = True
--   (==) _ _     = False

instance Ord DayOfWeek where
    compare Fri Fri = EQ
    compare Fri _   = GT
    compare _ Fri   = LT
    compare _ _     = EQ

instance Eq Date where
  (==) (Date weekday dayOfMonth) (Date weekday' dayOfMonth') =
      weekday == weekday' && dayOfMonth == dayOfMonth'

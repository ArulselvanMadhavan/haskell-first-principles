module Cipher where
import           Data.Char

charToAlphabetIndex :: Int -> Int
charToAlphabetIndex =
    flip (-) $ ord 'a'

alphabetIndexToChar :: Int -> Int
alphabetIndexToChar =
    (+) $ ord 'a'

cipher :: Int -> Char -> Char
cipher shift =
    chr . alphabetIndexToChar . (flip mod $ 26) . (+ shift) . charToAlphabetIndex . ord

uncipher :: Int -> Char -> Char
uncipher unshift =
    chr . alphabetIndexToChar . (flip mod $ 26) . flip (-) unshift . charToAlphabetIndex . ord

caesar :: Int -> String -> String
caesar shift =
    map $ cipher shift . toLower


uncaesar :: Int -> String -> String
uncaesar unshift =
    map $ uncipher unshift . toLower

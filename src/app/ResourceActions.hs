{-# LANGUAGE OverloadedStrings #-}

module ResourceActions
  ( userMenu
  ) where

import Database.PostgreSQL.Simple
import Queries
import Models
import System.IO (hFlush, stdout)

prompt :: String -> IO String
prompt text = do
    putStr text
    putStr " "
    hFlush stdout
    getLine

userMenu :: Connection -> User -> IO ()
userMenu conn user = do
    putStrLn $ "\nWelcome, " ++ username user ++ "!"
    putStrLn "1 - View resources"
    putStrLn "2 - Add a resource"
    putStrLn "3 - View authors"
    putStrLn "4 - Use a resource"
    putStrLn "5 - Exit"

    choice <- prompt "Enter your choice:"
    case choice of
        "1" -> do
            resources <- getAllResources conn
            mapM_ print resources
            userMenu conn user
        "2" -> do
            title <- prompt "Title:"
            annotation <- prompt "Annotation:"
            typeStr <- prompt "Type ID:"
            purpose <- prompt "Purpose:"
            address <- prompt "Address:"
            let typeId = read typeStr :: Int
            resId <- insertResource conn title annotation typeId purpose address
            
            authors <- getAllAuthors conn
            putStrLn "\nAvailable authors:"
            mapM_ (\a -> putStrLn $ show (authorId a) ++ " - " ++ name a ++ surname a) authors
            authorIdsStr <- prompt "Enter author IDs (comma-separated):"
            let authorIds = map read (splitBy ',' authorIdsStr) :: [Int]
            mapM_ (\aid -> linkResourceAuthor conn resId aid) authorIds

            userMenu conn user
        
        "3" -> do
            authors <- getAllAuthors conn
            mapM_ (\a -> putStrLn $ show (authorId a) ++ " - " ++ name a ++ " " ++ surname a) authors

            userMenu conn user

        "4" -> do
            resources <- getAllResources conn
            putStrLn "\nAvailable resources:"
            mapM_ print resources
            resIdStr <- prompt "Enter resource ID to use:"
            let resId = read resIdStr :: Int
            putStrLn $ "You are now using resource ID: " ++ show resId
            userMenu conn user

        "5" -> putStrLn "Goodbye!"

        _   -> putStrLn "Invalid choice." >> userMenu conn user

trim :: String -> String
trim = f . f
  where f = reverse . dropWhile (== ' ')

splitBy :: Char -> String -> [String]
splitBy _ "" = []
splitBy c s =
  let (x, rest) = break (== c) s
  in trim x : case rest of
      [] -> []
      (_:xs) -> splitBy c xs

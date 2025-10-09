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

    -- choice <- prompt "Enter your choice:"
    -- case choice of
    --     "1" -> do
    --         resources <- getAllResources conn
    --         mapM_ print resources
    --         userMenu conn user
    --     "2" -> do
    --         title <- prompt "Title:"
    --         annotation <- prompt "Annotation:"
    --         typeStr <- prompt "Type ID:"
    --         purpose <- prompt "Purpose:"
    --         let typeId = read typeStr :: Int
    --         _ <- insertResource conn title annotation typeId purpose
    --         userMenu conn user
    --     "3" -> putStrLn "Logging out..."
    --     _   -> putStrLn "Invalid choice." >> userMenu conn user

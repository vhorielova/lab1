{-# LANGUAGE OverloadedStrings #-}

module Login
  ( login
  ) where

import Database.PostgreSQL.Simple
import UserActions (doLogin, doCreateAccount)
import System.IO (hFlush, stdout)

prompt :: String -> IO String
prompt text = do
    putStr text
    putStr " "
    hFlush stdout
    getLine

login :: Connection -> IO ()
login conn = do
    putStrLn "\nDo you want to log in or create an account?"
    putStrLn "1 - Log in"
    putStrLn "2 - Create account"
    putStrLn "3 - Exit"
    choice <- prompt "Enter your choice:"

    case choice of
        "1" -> doLogin conn
        "2" -> doCreateAccount conn
        "3" -> putStrLn "Goodbye!"
        _   -> putStrLn "Invalid option." >> login conn

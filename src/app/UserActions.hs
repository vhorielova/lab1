{-# LANGUAGE OverloadedStrings #-}

module UserActions
  ( doLogin
  , doCreateAccount
  ) where

import Database.PostgreSQL.Simple
import Queries
import Models
import ResourceActions (userMenu)
import System.IO (hFlush, stdout)

prompt :: String -> IO String
prompt text = do
    putStr text
    putStr " "
    hFlush stdout
    getLine

doLogin :: Connection -> IO ()
doLogin conn = do
    username <- prompt "Enter username:"
    users <- getAllUsers conn
    let maybeUser = findUser username users
    case maybeUser of
        Just user -> do
            putStrLn $ "Logged in as " ++ username
            userMenu conn user
        Nothing -> do
            putStrLn "User not found."

doCreateAccount :: Connection -> IO ()
doCreateAccount conn = do
    username <- prompt "Choose a username:"
    newUser <- insertUser conn username
    putStrLn $ "Account created for " ++ username
    userMenu conn newUser

findUser :: String -> [User] -> Maybe User
findUser name = foldr (\u acc -> if username u == name then Just u else acc) Nothing

{-# LANGUAGE OverloadedStrings #-}

module Main where

import Connection (connectDB, closeDB)
import Login (login)

main :: IO ()
main = do
    conn <- connectDB
    putStrLn "Welcome to the Resource Manager!"
    login conn
    closeDB conn

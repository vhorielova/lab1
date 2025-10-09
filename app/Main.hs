{-# LANGUAGE OverloadedStrings #-}

module Main where

import Database.PostgreSQL.Simple
import Connection (connectDB, closeDB)

main :: IO ()
main = do
    conn <- connectDB

    closeDB conn
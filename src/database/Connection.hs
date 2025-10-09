{-# LANGUAGE OverloadedStrings #-}

module Connection
    ( connectDB
    , closeDB
    ) where

import Database.PostgreSQL.Simple

connectDB :: IO Connection
connectDB = do
    conn <- connect defaultConnectInfo
        { connectHost = "localhost"
        , connectDatabase = "inform_resources"
        , connectUser = "postgres"
        , connectPassword = ""
        }
    putStrLn "Connected to PostgreSQL!"
    return conn

closeDB :: Connection -> IO ()
closeDB conn = do
    close conn
    putStrLn "Connection closed."

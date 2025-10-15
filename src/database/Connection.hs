{-# LANGUAGE OverloadedStrings #-}

module Connection
    ( connectDB
    , closeDB
    ) where

import Database.PostgreSQL.Simple
import System.Environment (lookupEnv)
import Configuration.Dotenv (loadFile, defaultConfig)

connectDB :: IO Connection
connectDB = do
    _ <- loadFile defaultConfig

    host <- lookupEnvOrDefault "DB_HOST" "localhost"
    db   <- lookupEnvOrDefault "DB_NAME" "inform_resources"
    user <- lookupEnvOrDefault "DB_USER" "postgres"
    pass <- lookupEnvOrDefault "DB_PASSWORD" ""

    conn <- connect defaultConnectInfo
        { connectHost = host
        , connectDatabase = db
        , connectUser = user
        , connectPassword = pass
        }
    putStrLn "Connected to PostgreSQL!"
    return conn

closeDB :: Connection -> IO ()
closeDB conn = do
    close conn
    putStrLn "Connection closed."

lookupEnvOrDefault :: String -> String -> IO String
lookupEnvOrDefault var def = do
    value <- lookupEnv var
    return $ maybe def id value
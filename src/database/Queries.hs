{-# LANGUAGE OverloadedStrings #-}

module Queries where

import Models 
import Connection
import Database.PostgreSQL.Simple

getAllResources :: Connection -> IO [Resource]
getAllResources conn = query_ conn "SELECT * FROM resources"

insertResource :: Connection -> Resource -> IO ()
insertResource conn resource = do
  _ <- execute conn
         "INSERT INTO resources (title, annotation, typeId, purpose, openedAt, timeOfUsing, address) VALUES (?,?,?,?,?,?,?)"
         resource
  putStrLn "resource inserted"

getAllUsers :: Connection -> IO [User]
getAllUsers conn = query_ conn "SELECT * FROM users"

insertUser :: Connection -> String -> IO User
insertUser conn username = do
    [Only userId] <- query conn
        "INSERT INTO users (username) VALUES (?) RETURNING id"
        (Only username)
    putStrLn "user inserted"
    return (User userId username)

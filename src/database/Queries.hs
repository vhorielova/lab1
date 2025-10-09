module Queries where

import Models

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

insertUser :: Connection -> User -> IO ()
insertUser conn user = do
  _ <- execute conn
         "INSERT INTO users (username) VALUES (?)"
         user
  putStrLn "user inserted"

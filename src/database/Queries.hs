{-# LANGUAGE OverloadedStrings #-}

module Queries where

import Models 
import Connection
import Database.PostgreSQL.Simple
import Data.Time (getCurrentTime)


getAllResources :: Connection -> IO [Resource]
getAllResources conn = query_ conn "SELECT * FROM resources"

insertResource :: Connection -> String -> String -> Int -> String -> String -> IO Int
insertResource conn title annotation typeId purpose address = do
  [Only resId] <- query conn
         "INSERT INTO resources (title, annotation, type_id, purpose, address) VALUES (?,?,?,?,?) RETURNING id"
         (title, annotation, typeId, purpose, address)
  putStrLn "resource inserted"
  return (resId)

getAllUsers :: Connection -> IO [User]
getAllUsers conn = query_ conn "SELECT * FROM users"

insertUser :: Connection -> String -> IO User
insertUser conn username = do
    [Only userId] <- query conn
        "INSERT INTO users (username) VALUES (?) RETURNING id"
        (Only username)
    putStrLn "user inserted"
    return (User userId username)

linkResourceAuthor :: Connection -> Int -> Int -> IO ()
linkResourceAuthor conn resId authId = do
  _ <- execute conn
    "INSERT INTO resource_author (resource_id, author_id) VALUES (?,?)"
    (resId, authId)
  putStrLn "linked resource and author"

getAllAuthors :: Connection -> IO [Author]
getAllAuthors conn = do
  query_ conn "SELECT id, name, surname FROM authors"

updateResourceUsage :: Connection -> Int -> Int -> IO ()
updateResourceUsage conn resId minutes = do
  currentTime <- getCurrentTime
  _ <- execute conn
    "UPDATE resources \
    \SET last_used = ?, time_of_using = time_of_using + ? \
    \WHERE id = ?"
    (currentTime, minutes, resId)
  putStrLn "resource updated"

linkResourceUser :: Connection -> Int -> Int -> Int -> IO ()
linkResourceUser conn resId userId duration = do
  currentTime <- getCurrentTime
  _ <- execute conn
    "INSERT INTO resource_user (resource_id, user_id, used_at, duration) VALUES (?,?,?,?)"
    (resId, userId, currentTime, duration)
  putStrLn "linked resource and user"

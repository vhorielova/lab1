{-# LANGUAGE OverloadedStrings #-}

module Database.Connection (connectDB) where

import Database.PostgreSQL.Simple

connectDB :: IO Connection
connectDB = connect defaultConnectInfo
  { connectHost     = "localhost"
  , connectPort     = 5432
  , connectUser     = "postgres"
  , connectPassword = ""
  , connectDatabase = "inform_resourses"
  }

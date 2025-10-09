{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

module Models where

import GHC.Generics (Generic)
import Data.Time (UTCTime)
import Database.PostgreSQL.Simple.FromRow
import Database.PostgreSQL.Simple.ToRow
import Database.PostgreSQL.Simple.ToField (ToField(..))

data Resource = Resource {   
    resourceId :: Int,
    title :: String,
    annotation :: String,
    typeId :: Int,
    purpose :: String,
    openedAt :: UTCTime,
    timeOfUsing :: Int,
    address :: String
} deriving (Show, Generic)

instance FromRow Resource where
    fromRow = Resource <$> field <*> field <*> field <*> field <*> field <*> field <*> field <*> field

instance ToRow Resource where
    toRow r = [
        toField (resourceId r),
        toField (title r),
        toField (annotation r),
        toField (typeId r),
        toField (purpose r),
        toField (openedAt r),
        toField (timeOfUsing r),
        toField (address r),
    ]

data User = User {   
    userId :: Int,
    username :: String,
} deriving (Show, Generic)

instance FromRow User where
    fromRow = User <$> field <*> field

instance ToRow User where
    toRow u = [
        toField (userId u),
        toField (username u)
    ]

data Author = Author {
    authorId :: Int,
    name :: String,
    surname:: String
} deriving (Show, Generic)

data Type = Type {
    typeid :: Int,
    type :: String
} deriving (Show, Generic)
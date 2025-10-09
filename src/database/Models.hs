{-# LANGUAGE DeriveGeneric #-}

module Models where

import GHC.Generics (Generic)
import Data.Time (UTCTime)

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

data User = User {   
    userId :: Int,
    username :: String,
} deriving (Show, Generic)

data Author = Author {
    authorId :: Int,
    name :: String,
    surname:: String
} deriving (Show, Generic)

data Type = Type {
    typeid :: Int,
    type :: String
} deriving (Show, Generic)
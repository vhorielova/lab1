module Queries where

import Models

getAllResources :: Connection -> IO [Resource]
getAllResources conn = query_ conn "SELECT * FROM resources"

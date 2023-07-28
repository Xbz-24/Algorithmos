module Treap (Treap, empty, insert, delete, member, size) where

import System.Random (StdGen, randomR, mkStdGen)
import Data.List (fold')

data Treap a = Empty | Node a Int (Treap a) (Treap a) deriving (Show, Eq)

empty :: Treap a
empty = Empty

size :: Treap a -> Int
size 

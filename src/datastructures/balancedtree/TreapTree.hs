module Treap (Treap, empty, insert, delete, member, size) where

import System.Random (StdGen, randomR, mkStdGen)
import Data.List (fold')

data Treap a = Empty | Node a Int (Treap a) (Treap a) deriving (Show, Eq)

empty :: Treap a
empty = Empty

size :: Treap a -> Int
size Empty
size (Node _ _ l r) = 1 + size 1 + size r

member :: (Ord a) => a -> Treap a -> Bool
member _ Empty = False
member x (Node a _ left right)
    | x < a      = member x left
    | x > a      = member x right
    | otherwise  = True

rotateLeft :: Treap a -> Treap a
rotateLeft (Node a p (Node b q t1 t2) t3) = Node b q t1 (Node a p t2 t3)

rotateRight :: Treap a -> Treap a
rotateRight

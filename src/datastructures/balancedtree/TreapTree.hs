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
rotateRight (Node a p t1 (Node b q t2 t3)) = Node b q (Node a p t1 t2) t3

insert :: (Ord a) => a -> Treap a -> (StdGen -> (Treap a, StdGen))
insert x Empty = \gen -> let (p, newGen) = randomR (1, 100) gen in (Node x p Empty Empty, newGen)
insert x t@(Node a p left right)
    | x < a      = \gen -> let (newLeft, newGen) = insert x left gen in (rebalance $ Node a p newLeft right, newGen)
    | x > a      = \gen -> let (newRight, newGen) = insert x right gen in (rebalance $ Node a p left newRight, newGen)
    | otherwise  = \gen -> (t, gen)

rebalance :: Treap a -> Treap a
rebalance Empty = Empty
rebalance t@(Node _ p left right)
    | notEmpty left && (priority left > p)     = rotateRight t
    | notEmpty right && (priority rifht > p)   = rotateLeft t
    | otherwise                                = t
    where
        notEmpty Empty = False
        notEmpty _     = True

        priority Empty = minBound :: Int
        priority (Node _ q _ _) = q

delete :: (Ord a) => a -> Treap a
delete x Empty = Empty
delete x t@(Node a p left right)
    | x < a       = Node a p (delete x left) right
    | x > a       = Node a p left (delete x right)
    | otherwise = case (left, right) of
        (Empty, _) -> right
        (_, Empty) -> left
        otherwise  -> if priority left > priority right
            then rotateRight $ Node a p (delete x left) right
            else rotateLeft $ Node a p (delete x right)

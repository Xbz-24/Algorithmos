module DataStructures.BalancedTree.TreapTree (Treap, empty, insert, delete, member, size) where

import Data.List (foldl', nub)
import System.Random (StdGen, randomR, mkStdGen)

data Treap a = Empty | Node a Int (Treap a) (Treap a) deriving (Show, Eq)

empty :: Treap a
empty = Empty

size :: Treap a -> Int
size Empty = 0
size (Node _ _ l r) = 1 + size l + size r

member :: (Ord a) => a -> Treap a -> StdGen -> (Bool, StdGen)
member x Empty gen = (False, gen)
member x (Node a _ left right) gen
    | x < a      = member x left gen
    | x > a      = member x right gen
    | otherwise  = (True, gen)

rotateLeft :: Treap a -> Treap a
rotateLeft Empty = Empty
rotateLeft (Node _ _ Empty _) = Empty
rotateLeft (Node a p (Node b q t1 t2) t3) = Node b q t1 (Node a p t2 t3)

rotateRight :: Treap a -> Treap a
rotateRight Empty = Empty
rotateRight (Node _ _ _ Empty) = Empty
rotateRight (Node a p t1 (Node b q t2 t3)) = Node b q (Node a p t1 t2) t3

insert :: (Ord a) => a -> Treap a -> (StdGen -> (Treap a, StdGen))
insert x Empty gen = let (p, newGen) = randomR (1, 100) gen in (Node x p Empty Empty, newGen)
insert x (Node a p left right) gen
    | x < a      = let (newLeft, newGen) = insert x left gen in (rebalance $ Node a p newLeft right, newGen)
    | x > a      = let (newRight, newGen) = insert x right gen in (rebalance $ Node a p left newRight, newGen)
    | otherwise  = let (p', newGen) = randomR (1,100) gen in (rebalance $ Node a p' left right, newGen)

rebalance :: Treap a -> Treap a
rebalance Empty = Empty
rebalance t@(Node _ p left right)
    | notEmpty left && (priority left > p)     = rotateRight t
    | notEmpty right && (priority right > p)   = rotateLeft t
    | otherwise                                = t

priority :: Treap a -> Int
priority Empty = minBound :: Int
priority (Node _ q _ _) = q

notEmpty :: Treap a -> Bool
notEmpty Empty = False
notEmpty _     = True

delete :: (Ord a) => a -> Treap a -> Treap a
delete x Empty = Empty
delete x t@(Node a p left right)
    | x < a       = Node a p (delete x left) right
    | x > a       = Node a p left (delete x right)
    | otherwise = 
        if notEmpty left && notEmpty right then
            if priority left > priority right || priority left == priority right
                then rotateRight $ Node a p (delete x left) right
                else rotateLeft $ Node a p left (delete x right)
        else if notEmpty left
            then left
        else
            right

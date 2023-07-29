module TreapTreeTest where

import Test.QuickCheck
import DataStructures.BalancedTree.TreapTree
import Data.List (nub)
import System.Random (StdGen, mkStdGen)

test :: IO ()
test = do
    putStrLn "Treap"
    quickCheck prop_inserted_element_found
    quickCheck prop_deleted_element_not_found
    quickCheck prop_no_duplicate_elements

insertWithGen :: Int -> Treap Int -> StdGen -> Treap Int
insertWithGen x treap gen = fst $ insert x treap gen

prop_inserted_element_found :: [Int] -> Property
prop_inserted_element_found xs = forAll (listOf arbitrary) $ \gens ->
    let unique_xs = nub xs
        treap = foldl (\t (x, g) -> insertWithGen x t g) empty (zip unique_xs gens)
    in all (\(x, g) -> fst $ member x treap g) (zip unique_xs gens)

prop_deleted_element_not_found :: [Int] -> Property
prop_deleted_element_not_found xs = not (null xs) ==> forAll (listOf arbitrary) $ \gens ->
    let unique_xs = nub xs
        treap = foldl (\t (x, g) -> insertWithGen x t g) empty (zip unique_xs gens)
        x = head unique_xs
    in not $ fst $ member x (delete x treap) (snd $ head gens)

prop_no_duplicate_elements :: [Int] -> Property
prop_no_duplicate_elements xs = forAll (listOf arbitrary) $ \gens ->
    let unique_xs = nub xs
        treap = foldl (\t (x, g) -> insertWithGen x t g) empty (zip unique_xs gens)
    in size treap == length unique_xs

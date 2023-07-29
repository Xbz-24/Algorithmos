import Test.Hspec
import Test.QuickCheck
import System.Random (mkStdGen)

import Treap

main :: IO ()
main = hspec $ do
    describe "Treap" $ do
        it "should always find an inserted element" $
            property $ \x ->
                let gen = mkStdGen 42
                    (treap, _) = insert x empty gen
                in member x treap

        it "should never find a deleted element" $
            property $ \x ->
                let gen = mkStdGen 42
                    (treap, _) = insert x empty gen
                in not . member x $ delete x treap
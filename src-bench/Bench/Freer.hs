{-# LANGUAGE DataKinds #-}

module Bench.Freer where

import           Bench.Free.GADT.DataSource hiding (listWombats, countAardvarks)
import           Control.Monad
import           Control.Monad.Freer
import           Data.Foldable

listWombats :: Id -> Eff '[ExampleReq] [Id]
listWombats = send . ListWombats

countAardvarks :: String -> Eff '[ExampleReq] Int
countAardvarks = send . CountAardvarks

runExampleReq :: Eff '[ExampleReq] a -> a
runExampleReq a = run $ handleRelay pure (\x f -> f $ fetchExampleReq x) a

-- parallel, identical queries
par1 :: Int -> ()
par1 n = runExampleReq $ sequenceA_ (replicate n (listWombats 3))

-- parallel, distinct queries
par2 :: Int -> ()
par2 n = runExampleReq $ sequenceA_ (map listWombats [1 .. fromIntegral n])

-- sequential, identical queries
seqr :: Int -> ()
seqr n = runExampleReq $ sequence_ (replicate n (listWombats 3))

-- sequential, left-associated, distinct queries
seql :: Int -> ()
seql n =
  runExampleReq
    $ void
    $ foldl (>>) (return []) (map listWombats [1 .. fromIntegral n])

-- tree
tree :: Int -> ()
tree n = runExampleReq $ void $ tree' n
 where
  tree' :: Int -> Eff '[ExampleReq] [Id]
  tree' 0 = listWombats 0
  tree' x =
    concat
      <$> sequenceA [tree' (x - 1), listWombats (fromIntegral x), tree' (x - 1)]


module Bench.Free.Church where

import           Bench.Free.DataSource
import           Control.Monad
import           Control.Monad.Free.Church
import           Data.Foldable

runExampleReq :: F ExampleReq a -> a
runExampleReq = iter fetchExampleReq

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
  tree' :: Int -> F ExampleReq [Id]
  tree' 0 = listWombats 0
  tree' x =
    concat
      <$> sequenceA [tree' (x - 1), listWombats (fromIntegral x), tree' (x - 1)]


module Bench.FreeT.Church where

import           Bench.Free.DataSource
import           Control.Monad
import           Control.Monad.Trans.Free.Church
import           Data.Foldable

runExampleReq :: Monad m => FT ExampleReq m a -> m a
runExampleReq = iterT fetchExampleReq

-- parallel, identical queries
par1 :: Int -> IO ()
par1 n = runExampleReq $ sequenceA_ (replicate n (listWombats 3))

-- parallel, distinct queries
par2 :: Int -> IO ()
par2 n = runExampleReq $ sequenceA_ (map listWombats [1 .. fromIntegral n])

-- sequential, identical queries
seqr :: Int -> IO ()
seqr n = runExampleReq $ sequence_ (replicate n (listWombats 3))

-- sequential, left-associated, distinct queries
seql :: Int -> IO ()
seql n =
  runExampleReq
    $ void
    $ foldl (>>) (return []) (map listWombats [1 .. fromIntegral n])

-- tree
tree :: Int -> IO ()
tree n = runExampleReq $ void $ tree' n
 where
  tree' :: Int -> FT ExampleReq IO [Id]
  tree' 0 = listWombats 0
  tree' x =
    concat
      <$> sequenceA [tree' (x - 1), listWombats (fromIntegral x), tree' (x - 1)]


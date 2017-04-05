module Bench.FreeT.Church.Ap where

import           Bench.Free.GADT.DataSource
import           Control.Applicative.Free.Dave
import           Control.Monad
import           Control.Monad.Trans.Free.Ap
import           Data.Foldable
import           Data.Functor.Identity

runExampleReq :: Monad m => FT (Ap ExampleReq) m a -> m a
runExampleReq = iterT $ runIdentity . runAp (Identity . fetchExampleReq)

-- parallel, identical queries
par1 :: Int -> IO ()
par1 n = runExampleReq $ sequenceA_ (replicate n (listWombats liftAp 3))

-- parallel, distinct queries
par2 :: Int -> IO ()
par2 n =
  runExampleReq $ sequenceA_ (map (listWombats liftAp) [1 .. fromIntegral n])

-- sequential, identical queries
seqr :: Int -> IO ()
seqr n = runExampleReq $ sequence_ (replicate n (listWombats liftAp 3))

-- sequential, left-associated, distinct queries
seql :: Int -> IO ()
seql n =
  runExampleReq
    $ void
    $ foldl (>>) (return []) (map (listWombats liftAp) [1 .. fromIntegral n])

-- tree
tree :: Int -> IO ()
tree n = runExampleReq $ void $ tree' n
 where
  tree' :: Int -> FT (Ap ExampleReq) IO [Id]
  tree' 0 = listWombats liftAp 0
  tree' x =
    concat
      <$> sequenceA
            [tree' (x - 1), listWombats liftAp (fromIntegral x), tree' (x - 1)]


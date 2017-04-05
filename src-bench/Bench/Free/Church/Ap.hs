{-# LANGUAGE GADTs #-}

module Bench.Free.Church.Ap where

import           Bench.Free.GADT.DataSource
import           Control.Applicative.Free.Dave
import           Control.Monad
import           Control.Monad.Free.Ap
import           Data.Foldable
import           Data.Functor.Identity

runExampleReq :: F (Ap ExampleReq) a -> a
runExampleReq = iter $ runIdentity . runAp (Identity . fetchExampleReq)

-- parallel, identical queries
par1 :: Int -> ()
par1 n = runExampleReq $ sequenceA_ (replicate n (listWombats liftAp 3))

-- parallel, distinct queries
par2 :: Int -> ()
par2 n = runExampleReq $ sequenceA_ (map (listWombats liftAp) [1 .. n])

-- sequential, identical queries
seqr :: Int -> ()
seqr n = runExampleReq $ sequence_ (replicate n (listWombats liftAp 3))

-- sequential, left-associated, distinct queries
seql :: Int -> ()
seql n =
  runExampleReq
    $ void
    $ foldl (>>) (return []) (map (listWombats liftAp) [1 .. fromIntegral n])

-- tree
tree :: Int -> ()
tree n = runExampleReq $ void $ tree' n
 where
  tree' :: Int -> F (Ap ExampleReq) [Id]
  tree' 0 = listWombats liftAp 0
  tree' x =
    concat
      <$> sequenceA
            [tree' (x - 1), listWombats liftAp (fromIntegral x), tree' (x - 1)]


{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE GADTs #-}

module Bench.Free.GADT.DataSource where

import Control.Monad.Free.Class

type Id = Int

data ExampleReq a where
  CountAardvarks :: String -> ExampleReq Int
  ListWombats :: Id -> ExampleReq [Id]

countAardvarks :: (MonadFree f m, Functor f) => (forall a. ExampleReq a -> f a) -> String -> m Int
countAardvarks liftAp s = liftF $ liftAp $ CountAardvarks s
{-# INLINE countAardvarks #-}

listWombats :: (MonadFree f m, Functor f) => (forall a. ExampleReq a -> f a) -> Id -> m [Id]
listWombats liftAp i = liftF $ liftAp $ ListWombats i
{-# INLINE listWombats #-}

fetchExampleReq :: ExampleReq a -> a
fetchExampleReq (CountAardvarks "BANG" ) = error "BANG"
fetchExampleReq (CountAardvarks "BANG2") = error "BANG2"
fetchExampleReq (CountAardvarks "BANG3") = error "BANG3"
fetchExampleReq (CountAardvarks str    ) = length (filter (=='a') str)
fetchExampleReq (ListWombats a) =
  if a > 999999 then error "too large" else take (fromIntegral a) [1 ..]

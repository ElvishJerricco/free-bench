{-# LANGUAGE DeriveFunctor    #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE TemplateHaskell  #-}

module Bench.Free.DataSource where

import           Control.Monad.Free.Class (MonadFree, liftF)
import           Control.Monad.Free.TH    (makeFree)

type Id = Int

data ExampleReq a
  = CountAardvarks String (Int -> a)
  | ListWombats Id ([Id] -> a)
  deriving Functor

makeFree ''ExampleReq

fetchExampleReq :: ExampleReq a -> a
fetchExampleReq (CountAardvarks "BANG"  _) = error "BANG"
fetchExampleReq (CountAardvarks "BANG2" _) = error "BANG2"
fetchExampleReq (CountAardvarks "BANG3" _) = error "BANG3"
fetchExampleReq (CountAardvarks str     f) = f (length (filter (=='a') str))
fetchExampleReq (ListWombats a f) =
  if a > 999999 then error "too large" else f (take (fromIntegral a) [1 ..])


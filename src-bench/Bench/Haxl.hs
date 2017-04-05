module Bench.Haxl where

import           Bench.Haxl.DataSource as DataSource
import           Control.Monad
import           Data.List             as List
import           Haxl.Core             hiding (env)
import           Haxl.Prelude          as Haxl
import           Prelude               ()

testEnv :: IO (Env ())
testEnv = do
  exstate <- DataSource.initGlobalState
  let st = stateSet exstate stateEmpty
  initEnv st ()

-- parallel, identical queries
par1 :: Int -> IO ()
par1 n = do
  env <- testEnv
  runHaxl env $ Haxl.sequence_ (replicate n (listWombats 3))

-- parallel, distinct queries
par2 :: Int -> IO ()
par2 n = do
  env <- testEnv
  runHaxl env $ Haxl.sequence_ (map listWombats [1 .. fromIntegral n])

-- sequential, identical queries
seqr :: Int -> IO ()
seqr n = do
  env <- testEnv
  runHaxl env $ foldr andThen (return ()) (replicate n (listWombats 3))

-- sequential, left-associated, distinct queries
seql :: Int -> IO ()
seql n = do
  env <- testEnv
  runHaxl env $ do
    _ <- foldl andThen (return []) (map listWombats [1 .. fromIntegral n])
    return ()

-- tree
tree :: Int -> IO ()
tree n = do
  env <- testEnv
  runHaxl env $ void $ tree' n
 where
  tree' :: Int -> GenHaxl () [Id]
  tree' 0 = listWombats 0
  tree' n =
    concat
      <$> Haxl.sequence
            [tree' (n - 1), listWombats (fromIntegral n), tree' (n - 1)]


-- can't use >>, it is aliased to *> and we want the real bind here
andThen :: Monad m => m a -> m b -> m b
andThen x y = x >>= const y

unionWombats :: GenHaxl () [Id]
unionWombats = foldl List.union [] <$> Haxl.mapM listWombats [1 .. 1000]

unionWombatsTo :: Id -> GenHaxl () [Id]
unionWombatsTo x = foldl List.union [] <$> Haxl.mapM listWombats [1 .. x]

unionWombatsFromTo :: Id -> Id -> GenHaxl () [Id]
unionWombatsFromTo x y = foldl List.union [] <$> Haxl.mapM listWombats [x .. y]

{-# LANGUAGE DeriveFunctor         #-}
{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE RankNTypes            #-}

module Control.Monad.Free.Ap where

import           Control.Monad.Free.Class

newtype F f a = F { runF :: forall r. (a -> r) -> (f r -> r) -> r }
  deriving Functor

instance Applicative f => Applicative (F f) where
  pure a = F $ \pure' _ -> pure' a
  {-# INLINE pure #-}
  f <*> a = ap' (freeHead f) (freeHead a)
    where
      ap'
        :: Applicative f
        => Either (a -> b) (f (F f (a -> b)))
        -> Either a (f (F f a))
        -> F f b
      ap' (Left  f') (Left  a') = pure (f' a')
      ap' (Left  f') (Right a') = f' <$> wrap a'
      ap' (Right f') (Right a') = wrap $ (<*>) <$> f' <*> a'
      ap' (Right f') (Left  a') = wrap $ fmap (fmap ($a')) f'
  {-# INLINE (<*>) #-}

instance Applicative f => Monad (F f) where
  F f >>= k = F $ \pure' bind' -> f (\a -> runF (k a) pure' bind') bind'
  {-# INLINE (>>=) #-}

instance Applicative f => MonadFree f (F f) where
  wrap a = F $ \pure' bind' -> bind' $ fmap (\(F m) -> m pure' bind') a
  {-# INLINE wrap #-}

freeHead :: Functor f => F f a -> Either a (f (F f a))
freeHead (F f) = f Left $ Right . fmap
  ( either (\a -> F $ \pure' _ -> pure' a)
  $ \a -> F $ \pure' bind' -> bind' $ fmap (\(F m) -> m pure' bind') a
  )
{-# INLINE freeHead #-}

iter :: (f a -> a) -> F f a -> a
iter f (F g) = g id f
{-# INLINE iter #-}

{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE RankNTypes            #-}

module Control.Monad.Trans.Free.Ap where

import           Control.Monad
import           Control.Monad.Free.Class
import           Control.Monad.Trans.Class

newtype FT f m a = FT { runFT :: forall r. (a -> m r) -> (forall x. (x -> m r) -> f x -> m r) -> m r }

instance Functor (FT f m) where
  fmap f (FT g) = FT $ \pure' bind' -> g (pure' . f) bind'
  {-# INLINE fmap #-}

instance (Applicative f, Monad m) => Applicative (FT f m) where
  pure a = FT $ \pure' _ -> pure' a
  {-# INLINE pure #-}
  f <*> a = join $ lift $ ap' <$> freeHead f <*> freeHead a
    where
      ap'
        :: (Applicative f, Monad m)
        => Either (a -> b) (f (FT f m (a -> b)))
        -> Either a (f (FT f m a))
        -> FT f m b
      ap' (Left  f') (Left  a') = pure (f' a')
      ap' (Left  f') (Right a') = f' <$> wrap a'
      ap' (Right f') (Right a') = wrap $ (<*>) <$> f' <*> a'
      ap' (Right f') (Left  a') = wrap $ fmap (fmap ($a')) f'
  {-# INLINE (<*>) #-}

instance (Applicative f, Monad m) => Monad (FT f m) where
  FT f >>= k = FT $ \pure' bind' -> f (\a -> runFT (k a) pure' bind') bind'
  {-# INLINE (>>=) #-}

instance (Applicative f, Monad m) => MonadFree f (FT f m) where
  wrap a = FT $ \pure' bind' -> bind' (\x -> runFT x pure' bind') a
  {-# INLINE wrap #-}

instance MonadTrans (FT f) where
  lift a = FT $ \pure' _ -> a >>= pure'
  {-# INLINE lift #-}

-- TODO: The `Applicative f` constraint is unnecessary. `join` can be inlined
freeHead :: (Applicative f, Monad m) => FT f m a -> m (Either a (f (FT f m a)))
freeHead (FT f) = f (pure . Left)
  $ \g -> pure . Right . fmap (join . lift . fmap (either return wrap) . g)
{-# INLINE freeHead #-}

iterT :: (Functor f, Applicative m) => (f (m a) -> m a) -> FT f m a -> m a
iterT f (FT g) = g pure $ \h x -> f (fmap h x)
{-# INLINE iterT #-}

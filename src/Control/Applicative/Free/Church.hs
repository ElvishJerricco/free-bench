{-# LANGUAGE DeriveFunctor             #-}
{-# LANGUAGE ExistentialQuantification #-}
{-# LANGUAGE RankNTypes                #-}
{-# LANGUAGE TypeOperators             #-}

module Control.Applicative.Free.Church where

--------------------------------------------------------------------------------

-- import qualified Control.Applicative.Free as Ap
-- import           Data.Functor.Coyoneda
-- import           Data.Functor.Day

-- type (f ~> g) x = forall y. f (x -> y) -> g y

-- newtype (f :~> g) a = E { runApExp :: (f ~> g) a }
-- evalA :: Functor f => Day (f :~> g) f a -> g a
-- evalA (Day (E f) a g) = f (flip g <$> a)

-- newtype Codensity f a = Codensity { unCodensity :: (f ~> f) a }
--   deriving Functor

-- instance Functor f => Applicative (Codensity f) where
--   pure a = Codensity $ fmap ($ a)
--   Codensity f <*> Codensity a = Codensity $ \y -> f (a $ fmap (\g x h -> g (h x)) y)

-- type Ap f = Codensity (Coyoneda (Ap.Ap f))

-- liftAp :: f a -> Ap f a
-- liftAp a = Codensity $ \(Coyoneda f y) -> _

-- hoistCoyoneda :: (forall x . f x -> g x) -> Coyoneda f a -> Coyoneda g a
-- hoistCoyoneda f (Coyoneda g x) = Coyoneda g (f x)

-- runAp :: Applicative g => (forall x . f x -> g x) -> Ap f a -> g a
-- runAp f (Codensity g) =
--   lowerCoyoneda $ hoistCoyoneda (Ap.runAp f) $ g (liftCoyoneda $ pure id)

--------------------------------------------------------------------------------

import qualified Control.Applicative.Free as Ap
import           Data.Functor.Coyoneda
import           Data.Functor.Day

type (f ~> g) x = forall y. f y -> g (x, y)

newtype (f :~> g) a = E ((f ~> g) a)
evalA :: Functor g => Day (f :~> g) f a -> g a
evalA (Day (E f) a g) = uncurry g <$> f a

newtype Codensity f a = Codensity { unCodensity :: (f ~> f) a }
  deriving Functor

instance Functor f => Applicative (Codensity f) where
  pure a = Codensity $ \y -> (,) a <$> y
  Codensity f <*> Codensity a = Codensity $ \y -> (\(f', (a', y')) -> (f' a', y')) <$> f (a y)

type Ap f = Codensity (Coyoneda (Ap.Ap f))

liftAp :: f a -> Ap f a
liftAp a = Codensity $ \(Coyoneda f y) -> _

--------------------------------------------------------------------------------

-- import Control.Applicative.Free

-- foldAp :: (a -> r a) -> (forall x y. f x -> Ap f (x -> y) -> r y) -> Ap f a -> r a
-- foldAp p _ (Pure a) = p a
-- foldAp _ a (Ap x b) = a x b

-- retractAp' :: Applicative f => Ap f a -> f a
-- retractAp' = foldAp pure (\x b -> retractAp' b <*> x)

-- runAp' :: Applicative g => (forall x. f x -> g x) -> Ap f a -> g a
-- runAp' f = foldAp pure $ \x b -> runAp' f b <*> f x

--------------------------------------------------------------------------------

-- import Control.Applicative.Free

-- foldAp :: (forall x. x -> r x) -> (forall x y. f x -> r (x -> y) -> r y) -> Ap f a -> r a
-- foldAp p _ (Pure a) = p a
-- foldAp p f (Ap x b) = f x (foldAp p f b)

--------------------------------------------------------------------------------

-- newtype Ap f a = Ap { unAp :: forall r. Functor r => (forall x. x -> r x) -> (forall x y. f x -> r (x -> y) -> r y) -> r a }

-- instance Functor (Ap f) where
--   fmap f (Ap g) = Ap $ \pure' ap' -> f <$> g pure' ap'

-- instance Applicative (Ap f) where
--   pure a = Ap $ \pure' _ -> pure' a
--   Ap f <*> Ap a = Ap $ \pure' ap' ->

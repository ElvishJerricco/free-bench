import qualified Bench.Freer as Freer
import qualified Bench.Free.Church as Church
import qualified Bench.Free.Church.Ap as Church.Ap
import qualified Bench.FreeT.Church as ChurchT
import qualified Bench.FreeT.Church.Ap as ChurchT.Ap
import qualified Bench.Haxl as Haxl
import           Criterion
import           Criterion.Main

main :: IO ()
main = defaultMain
  [ bench "Haxl.par1 100000" $ whnfIO $ Haxl.par1 100000
  , bench "Haxl.par2 100000" $ whnfIO $ Haxl.par2 100000
  , bench "Haxl.seqr 1000000" $ whnfIO $ Haxl.seqr 1000000
  , bench "Haxl.seql 100000" $ whnfIO $ Haxl.seql 100000
  , bench "Haxl.tree 18" $ whnfIO $ Haxl.tree 18
  , bench "Freer.par1 100000" $ whnf Freer.par1 100000
  , bench "Freer.par2 100000" $ whnf Freer.par2 100000
  , bench "Freer.seqr 1000000" $ whnf Freer.seqr 1000000
  , bench "Freer.seql 100000" $ whnf Freer.seql 100000
  , bench "Freer.tree 18" $ whnf Freer.tree 18
  , bench "Church.par1 100000" $ whnf Church.par1 100000
  , bench "Church.par2 100000" $ whnf Church.par2 100000
  , bench "Church.seqr 1000000" $ whnf Church.seqr 1000000
  , bench "Church.seql 100000" $ whnf Church.seql 100000
  , bench "Church.tree 18" $ whnf Church.tree 18
  , bench "ChurchT.par1 100000" $ whnfIO $ ChurchT.par1 100000
  , bench "ChurchT.par2 100000" $ whnfIO $ ChurchT.par2 100000
  , bench "ChurchT.seqr 1000000" $ whnfIO $ ChurchT.seqr 1000000
  , bench "ChurchT.seql 100000" $ whnfIO $ ChurchT.seql 100000
  , bench "ChurchT.tree 18" $ whnfIO $ ChurchT.tree 18
  , bench "Church.Ap.par1 100000" $ whnf Church.Ap.par1 100000
  , bench "Church.Ap.par2 100000" $ whnf Church.Ap.par2 100000
  , bench "Church.Ap.seqr 1000000" $ whnf Church.Ap.seqr 1000000
  , bench "Church.Ap.seql 100000" $ whnf Church.Ap.seql 100000
  , bench "Church.Ap.tree 18" $ whnf Church.Ap.tree 18
  , bench "ChurchT.Ap.par1 100000" $ whnfIO $ ChurchT.Ap.par1 100000
  , bench "ChurchT.Ap.par2 100000" $ whnfIO $ ChurchT.Ap.par2 100000
  , bench "ChurchT.Ap.seqr 1000000" $ whnfIO $ ChurchT.Ap.seqr 1000000
  , bench "ChurchT.Ap.seql 100000" $ whnfIO $ ChurchT.Ap.seql 100000
  , bench "ChurchT.Ap.tree 18" $ whnfIO $ ChurchT.Ap.tree 18
  ]

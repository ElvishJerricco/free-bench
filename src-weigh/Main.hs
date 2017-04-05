import qualified Bench.Freer as Freer
import qualified Bench.Free.Church as Church
import qualified Bench.Free.Church.Ap as Church.Ap
import qualified Bench.FreeT.Church as ChurchT
import qualified Bench.FreeT.Church.Ap as ChurchT.Ap
import qualified Bench.Haxl as Haxl
import           Weigh

main :: IO ()
main = mainWith $ do
  io   "Haxl.par1 1000000"       Haxl.par1       1000000
  io   "Haxl.par2 100000"        Haxl.par2       100000
  io   "Haxl.seqr 1000000"       Haxl.seqr       1000000
  io   "Haxl.seql 100000"        Haxl.seql       100000
  io   "Haxl.tree 18"            Haxl.tree       18

  func "Freer.par1 1000000"      Freer.par1      1000000
  func "Freer.par2 100000"       Freer.par2      100000
  func "Freer.seqr 1000000"      Freer.seqr      1000000
  func "Freer.seql 100000"       Freer.seql      100000
  func "Freer.tree 18"           Freer.tree      18

  func "Church.par1 1000000"     Church.par1     1000000
  func "Church.par2 100000"      Church.par2     100000
  func "Church.seqr 1000000"     Church.seqr     1000000
  func "Church.seql 100000"      Church.seql     100000
  func "Church.tree 18"          Church.tree     18

  io   "ChurchT.par1 1000000"    ChurchT.par1    1000000
  io   "ChurchT.par2 100000"     ChurchT.par2    100000
  io   "ChurchT.seqr 1000000"    ChurchT.seqr    1000000
  io   "ChurchT.seql 100000"     ChurchT.seql    100000
  io   "ChurchT.tree 18"         ChurchT.tree    18

  func "Church.Ap.par1 1000000"  Church.Ap.par1  1000000
  func "Church.Ap.par2 100000"   Church.Ap.par2  100000
  func "Church.Ap.seqr 1000000"  Church.Ap.seqr  1000000
  func "Church.Ap.seql 100000"   Church.Ap.seql  100000
  func "Church.Ap.tree 18"       Church.Ap.tree  18

  io   "ChurchT.Ap.par1 1000000" ChurchT.Ap.par1 1000000
  io   "ChurchT.Ap.par2 100000"  ChurchT.Ap.par2 100000
  io   "ChurchT.Ap.seqr 1000000" ChurchT.Ap.seqr 1000000
  io   "ChurchT.Ap.seql 100000"  ChurchT.Ap.seql 100000
  io   "ChurchT.Ap.tree 18"      ChurchT.Ap.tree 18

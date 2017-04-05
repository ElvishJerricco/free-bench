free-bench
==========

Benchmarking the church encoded free monad (`Church`), the church
encoded free monad transformer (`ChurchT`), applicative optimized
variants of each (`Church.Ap`, `ChurchT.Ap`), `haxl` (`Haxl`), and
`freer-effects` (`Freer`). These benchmarks are meant to simulate
effectful programs with no reflection. My conclusion is that the
church encoded free monad is the fastest one in this case. The
advantage of `Freer` is only relevant when you intend to do
reflection, which is uncommon when you're only trying to use a free
monad for extensible effects.

```
free-bench-0.1.0.0: benchmarks
Running 2 benchmarks...
Benchmark free-bench-criterion: RUNNING...
benchmarking Haxl.par1 100000
time                 72.52 ms   (68.00 ms .. 76.47 ms)
                     0.995 R²   (0.990 R² .. 0.998 R²)
mean                 75.93 ms   (73.84 ms .. 80.66 ms)
std dev              4.990 ms   (2.495 ms .. 7.526 ms)
variance introduced by outliers: 17% (moderately inflated)

benchmarking Haxl.par2 100000
time                 260.9 ms   (246.3 ms .. 278.2 ms)
                     0.999 R²   (0.996 R² .. 1.000 R²)
mean                 274.1 ms   (270.5 ms .. 275.5 ms)
std dev              2.488 ms   (257.4 μs .. 3.312 ms)
variance introduced by outliers: 16% (moderately inflated)

benchmarking Haxl.seqr 1000000
time                 76.89 ms   (68.35 ms .. 82.54 ms)
                     0.983 R²   (0.950 R² .. 0.997 R²)
mean                 81.80 ms   (78.48 ms .. 87.19 ms)
std dev              6.773 ms   (4.900 ms .. 9.399 ms)
variance introduced by outliers: 28% (moderately inflated)

benchmarking Haxl.seql 100000
time                 405.0 ms   (361.4 ms .. 427.8 ms)
                     0.998 R²   (0.997 R² .. 1.000 R²)
mean                 397.3 ms   (387.6 ms .. 403.5 ms)
std dev              9.229 ms   (0.0 s .. 10.58 ms)
variance introduced by outliers: 19% (moderately inflated)

benchmarking Haxl.tree 18
time                 611.6 ms   (569.8 ms .. 643.4 ms)
                     0.999 R²   (0.998 R² .. 1.000 R²)
mean                 598.1 ms   (590.2 ms .. 602.5 ms)
std dev              6.953 ms   (0.0 s .. 7.672 ms)
variance introduced by outliers: 19% (moderately inflated)

benchmarking Freer.par1 100000
time                 59.11 ms   (55.20 ms .. 63.39 ms)
                     0.993 R²   (0.985 R² .. 0.999 R²)
mean                 63.65 ms   (62.09 ms .. 68.11 ms)
std dev              3.747 ms   (1.382 ms .. 6.161 ms)
variance introduced by outliers: 17% (moderately inflated)

benchmarking Freer.par2 100000
time                 86.76 ms   (84.54 ms .. 88.65 ms)
                     0.999 R²   (0.996 R² .. 1.000 R²)
mean                 88.73 ms   (87.32 ms .. 90.78 ms)
std dev              2.756 ms   (1.591 ms .. 4.013 ms)

benchmarking Freer.seqr 1000000
time                 48.75 ms   (41.82 ms .. 56.23 ms)
                     0.952 R²   (0.897 R² .. 0.995 R²)
mean                 53.59 ms   (50.09 ms .. 64.08 ms)
std dev              10.58 ms   (3.471 ms .. 17.70 ms)
variance introduced by outliers: 68% (severely inflated)

benchmarking Freer.seql 100000
time                 51.90 ms   (49.66 ms .. 54.33 ms)
                     0.995 R²   (0.989 R² .. 0.998 R²)
mean                 51.36 ms   (49.02 ms .. 53.91 ms)
std dev              4.099 ms   (2.350 ms .. 6.682 ms)
variance introduced by outliers: 29% (moderately inflated)

benchmarking Freer.tree 18
time                 495.9 ms   (417.8 ms .. 557.6 ms)
                     0.996 R²   (0.995 R² .. 1.000 R²)
mean                 550.0 ms   (519.8 ms .. 569.0 ms)
std dev              28.59 ms   (0.0 s .. 32.80 ms)
variance introduced by outliers: 19% (moderately inflated)

benchmarking Church.par1 100000
time                 9.729 ms   (9.577 ms .. 9.836 ms)
                     0.999 R²   (0.998 R² .. 0.999 R²)
mean                 9.981 ms   (9.889 ms .. 10.14 ms)
std dev              343.7 μs   (232.4 μs .. 536.7 μs)
variance introduced by outliers: 13% (moderately inflated)

benchmarking Church.par2 100000
time                 11.06 ms   (10.96 ms .. 11.15 ms)
                     0.999 R²   (0.999 R² .. 1.000 R²)
mean                 11.15 ms   (11.07 ms .. 11.30 ms)
std dev              293.0 μs   (168.7 μs .. 513.0 μs)

benchmarking Church.seqr 1000000
time                 48.65 ms   (45.55 ms .. 51.23 ms)
                     0.992 R²   (0.984 R² .. 0.999 R²)
mean                 47.25 ms   (46.20 ms .. 48.76 ms)
std dev              2.370 ms   (1.190 ms .. 3.199 ms)
variance introduced by outliers: 13% (moderately inflated)

benchmarking Church.seql 100000
time                 21.57 ms   (20.96 ms .. 21.92 ms)
                     0.997 R²   (0.993 R² .. 1.000 R²)
mean                 22.81 ms   (22.34 ms .. 23.91 ms)
std dev              1.486 ms   (694.6 μs .. 2.441 ms)
variance introduced by outliers: 24% (moderately inflated)

benchmarking Church.tree 18
time                 119.0 ms   (112.6 ms .. 123.1 ms)
                     0.997 R²   (0.992 R² .. 1.000 R²)
mean                 123.5 ms   (120.6 ms .. 126.9 ms)
std dev              4.415 ms   (3.339 ms .. 5.554 ms)
variance introduced by outliers: 11% (moderately inflated)

benchmarking ChurchT.par1 100000
time                 7.208 ms   (7.136 ms .. 7.268 ms)
                     1.000 R²   (0.999 R² .. 1.000 R²)
mean                 7.240 ms   (7.211 ms .. 7.282 ms)
std dev              103.6 μs   (81.06 μs .. 147.3 μs)

benchmarking ChurchT.par2 100000
time                 19.91 ms   (19.57 ms .. 20.28 ms)
                     0.999 R²   (0.997 R² .. 1.000 R²)
mean                 20.14 ms   (19.94 ms .. 20.69 ms)
std dev              772.5 μs   (281.5 μs .. 1.379 ms)
variance introduced by outliers: 13% (moderately inflated)

benchmarking ChurchT.seqr 1000000
time                 17.54 ms   (17.39 ms .. 17.69 ms)
                     0.999 R²   (0.999 R² .. 1.000 R²)
mean                 17.76 ms   (17.64 ms .. 18.05 ms)
std dev              424.5 μs   (272.2 μs .. 684.8 μs)

benchmarking ChurchT.seql 100000
time                 27.88 ms   (27.22 ms .. 28.61 ms)
                     0.998 R²   (0.994 R² .. 1.000 R²)
mean                 29.05 ms   (28.55 ms .. 30.37 ms)
std dev              1.794 ms   (455.9 μs .. 3.404 ms)
variance introduced by outliers: 21% (moderately inflated)

benchmarking ChurchT.tree 18
time                 13.30 ns   (13.10 ns .. 13.46 ns)
                     0.998 R²   (0.998 R² .. 0.999 R²)
mean                 12.94 ns   (12.78 ns .. 13.14 ns)
std dev              628.3 ps   (544.1 ps .. 728.2 ps)
variance introduced by outliers: 72% (severely inflated)

benchmarking Church.Ap.par1 100000
time                 176.0 ms   (172.7 ms .. 184.8 ms)
                     0.999 R²   (0.996 R² .. 1.000 R²)
mean                 180.6 ms   (178.3 ms .. 182.7 ms)
std dev              2.956 ms   (2.430 ms .. 3.155 ms)
variance introduced by outliers: 14% (moderately inflated)

benchmarking Church.Ap.par2 100000
time                 191.0 ms   (168.4 ms .. 209.9 ms)
                     0.991 R²   (0.968 R² .. 1.000 R²)
mean                 209.6 ms   (196.4 ms .. 215.1 ms)
std dev              10.06 ms   (1.649 ms .. 13.44 ms)
variance introduced by outliers: 14% (moderately inflated)

benchmarking Church.Ap.seqr 1000000
time                 169.3 ms   (143.5 ms .. 191.2 ms)
                     0.984 R²   (0.957 R² .. 1.000 R²)
mean                 157.6 ms   (150.9 ms .. 166.2 ms)
std dev              10.58 ms   (6.994 ms .. 13.91 ms)
variance introduced by outliers: 13% (moderately inflated)

benchmarking Church.Ap.seql 100000
time                 37.35 ms   (35.19 ms .. 39.92 ms)
                     0.988 R²   (0.976 R² .. 0.996 R²)
mean                 40.30 ms   (39.12 ms .. 42.22 ms)
std dev              3.181 ms   (1.767 ms .. 5.102 ms)
variance introduced by outliers: 25% (moderately inflated)

benchmarking Church.Ap.tree 18
time                 1.147 s    (987.1 ms .. 1.294 s)
                     0.998 R²   (0.991 R² .. 1.000 R²)
mean                 1.239 s    (1.221 s .. 1.251 s)
std dev              18.45 ms   (0.0 s .. 21.31 ms)
variance introduced by outliers: 19% (moderately inflated)

benchmarking ChurchT.Ap.par1 100000
time                 936.6 ms   (908.9 ms .. 952.1 ms)
                     1.000 R²   (1.000 R² .. 1.000 R²)
mean                 942.9 ms   (936.7 ms .. 946.1 ms)
std dev              5.396 ms   (0.0 s .. 5.443 ms)
variance introduced by outliers: 19% (moderately inflated)

benchmarking ChurchT.Ap.par2 100000
time                 996.6 ms   (849.7 ms .. 1.185 s)
                     0.996 R²   (0.987 R² .. 1.000 R²)
mean                 967.8 ms   (922.8 ms .. 983.6 ms)
std dev              43.80 ms   (0.0 s .. 50.53 ms)
variance introduced by outliers: 19% (moderately inflated)

benchmarking ChurchT.Ap.seqr 1000000
time                 13.23 ns   (12.97 ns .. 13.53 ns)
                     0.997 R²   (0.995 R² .. 0.999 R²)
mean                 13.18 ns   (12.95 ns .. 13.41 ns)
std dev              816.8 ps   (652.3 ps .. 1.014 ns)
variance introduced by outliers: 81% (severely inflated)

benchmarking ChurchT.Ap.seql 100000
time                 13.30 ns   (13.20 ns .. 13.40 ns)
                     0.999 R²   (0.998 R² .. 0.999 R²)
mean                 13.73 ns   (13.52 ns .. 14.01 ns)
std dev              895.1 ps   (719.8 ps .. 1.135 ns)
variance introduced by outliers: 83% (severely inflated)

benchmarking ChurchT.Ap.tree 18
time                 1.346 s    (1.117 s .. 1.609 s)
                     0.995 R²   (0.991 R² .. 1.000 R²)
mean                 1.384 s    (1.354 s .. 1.412 s)
std dev              47.84 ms   (0.0 s .. 49.06 ms)
variance introduced by outliers: 19% (moderately inflated)

Benchmark free-bench-criterion: FINISH
Benchmark free-bench-weigh: RUNNING...

Case                             Bytes    GCs  Check
Haxl.par1 1000000          593,230,496  1,076  OK   
Haxl.par2 100000           241,063,456    461  OK   
Haxl.seqr 1000000           96,003,904    186  OK   
Haxl.seql 100000           321,873,808    627  OK   
Haxl.tree 18               399,562,544    768  OK   
Freer.par1 1000000         504,322,648    971  OK   
Freer.par2 100000           59,271,224    114  OK   
Freer.seqr 1000000         167,999,912    325  OK   
Freer.seql 100000           29,599,888     57  OK   
Freer.tree 18              432,044,536    829  OK   
Church.par1 1000000        120,032,736    229  OK   
Church.par2 100000          15,232,768     29  OK   
Church.seqr 1000000        104,032,752    200  OK   
Church.seql 100000          16,034,048     30  OK   
Church.tree 18             142,605,808    275  OK   
ChurchT.par1 1000000        88,000,008    168  OK   
ChurchT.par2 100000         34,432,640     66  OK   
ChurchT.seqr 1000000        72,000,024    138  OK   
ChurchT.seql 100000         28,032,648     53  OK   
ChurchT.tree 18            199,228,824    384  OK   
Church.Ap.par1 1000000   1,076,617,792  1,934  OK   
Church.Ap.par2 100000      114,070,816    202  OK   
Church.Ap.seqr 1000000     296,032,752    568  OK   
Church.Ap.seql 100000       40,832,768     78  OK   
Church.Ap.tree 18          729,839,240  1,397  OK   
ChurchT.Ap.par1 1000000  4,700,973,584  8,804  OK   
ChurchT.Ap.par2 100000     478,069,208    894  OK   
ChurchT.Ap.seqr 1000000    240,033,064    459  OK   
ChurchT.Ap.seql 100000      45,632,776     87  OK   
ChurchT.Ap.tree 18         861,959,768  1,651  OK   
Benchmark free-bench-weigh: FINISH
Completed 2 action(s).
```

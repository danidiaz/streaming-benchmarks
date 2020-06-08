    cabal run exe:streaming-benchmarks -- --output=foo.html


# example results

	benchmarking foo/Stream len
	time                 5.344 ms   (5.244 ms .. 5.454 ms)
						 0.997 R²   (0.995 R² .. 0.999 R²)
	mean                 5.405 ms   (5.341 ms .. 5.475 ms)
	std dev              204.9 μs   (162.9 μs .. 295.9 μs)
	variance introduced by outliers: 19% (moderately inflated)

	benchmarking foo/ByteString len
	time                 5.155 ms   (5.087 ms .. 5.234 ms)
						 0.998 R²   (0.996 R² .. 0.999 R²)
	mean                 5.176 ms   (5.126 ms .. 5.243 ms)
	std dev              183.2 μs   (136.4 μs .. 249.9 μs)
	variance introduced by outliers: 17% (moderately inflated)

There doesn't seem to be much of a difference, but maybe the benchmark is too
naive.

# useful links

- [criterion tutorial](http://www.serpentine.com/criterion/tutorial.html)
- [criterion in Hackage](http://hackage.haskell.org/package/criterion)


module Main where

import Criterion.Main
import qualified Data.ByteString as B
import Streaming
import qualified Streaming.Prelude as S
import qualified Data.ByteString.Streaming as BS

readProust :: IO B.ByteString
readProust = B.readFile "./2650-0.txt"   

-- | take a big preexisting bytestring, generate a stream of chunks of size chunkSize
stream1 :: Int -> B.ByteString -> Stream (Of B.ByteString) IO ()
stream1 chunkSize = go
    where
    go b = do 
        let (chunk,rest) = B.splitAt chunkSize b
        if B.null chunk
            then return ()
            else 
                do S.yield chunk
                   go rest

-- | take a big preexisting bytestring, generate a stream of chunks of size chunkSize
stream2 :: Int -> B.ByteString -> BS.ByteString IO ()
stream2 chunkSize = go
    where
    go b = do 
        let (chunk,rest) = B.splitAt chunkSize b
        if B.null chunk
            then return ()
            else 
                do BS.chunk chunk
                   go rest

-- | accumulate the length of a stream of strict bytestring chunks
benchmark1 :: B.ByteString -> Benchmarkable
benchmark1 = nfIO . S.fold_ (\acc b -> acc + B.length b) 0 id . stream1 4

-- | calculate the length of a streamed ByteString
benchmark2 :: B.ByteString -> Benchmarkable
benchmark2 = nfIO . BS.length_ . stream2 4 

main :: IO ()
main = do
    let batchSize = 4
    defaultMain [
                bgroup "foo" [
                      env readProust $ bench "Stream len" . benchmark1
                    , env readProust $ bench "ByteString len " . benchmark2
            ]
        ]


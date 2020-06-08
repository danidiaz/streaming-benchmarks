module Main where

import Criterion.Main
import qualified Data.ByteString as B
import Streaming
import qualified Streaming.Prelude as S
import qualified Data.ByteString.Streaming as BS


readProust :: IO B.ByteString
readProust = B.readFile "./2650-0.txt"   

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
main :: IO ()
main = do
    swann <- readProust 
    print $ B.length swann
    defaultMain [
                bgroup "foo" [
            ]
        ]
    return ()


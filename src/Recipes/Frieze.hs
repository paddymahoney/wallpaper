module Recipes.Frieze where

import           Types
import           Complextra
import           Lib

import           Data.Complex


nm :: RealFloat a => Int -> Int -> Recipe a
nm n m z = exp (fromIntegral n .*^ (im * z))
         * exp (fromIntegral m .*^ (im * conjugate z))

p111 :: RealFloat a => [Coef a] -> Recipe a
p111  = wallpaper nm

p211 :: RealFloat a => [Coef a] -> Recipe a
p211 cs = wallpaper nm (cs ++ (negateCnm <$> cs))


p1m1 :: RealFloat a => [Coef a] -> Recipe a
p1m1 cs = wallpaper nm (cs ++ (reverseCnm <$> cs))

p11m :: RealFloat a => [Coef a] -> Recipe a
p11m cs = wallpaper nm (cs ++ (negateCnm . reverseCnm <$> cs))

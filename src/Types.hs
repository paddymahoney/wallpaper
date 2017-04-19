{-# LANGUAGE StrictData            #-}
{-# LANGUage TypeFamilies          #-}
{-# LANGUAGE TypeSynonymInstances  #-}

module Types where

import           Codec.Picture
import           Data.Complex (Complex)

type Recipe a = Complex a -> Complex a

data Coef a = Coef
  { nCoord :: Int
  , mCoord :: Int
  , anm    :: Complex a
  } deriving (Show, Eq)

data Options a = Options
  { width     :: Int
  , height    :: Int
  , repLength :: Int
  , scale     :: a
  }

defaultOpts :: Options Double
defaultOpts = Options 750 750 200 1

class Img a where
  type Pxl a :: *
  getPxl :: a -> Int -> Int-> Pxl a
  generateImg :: (Int -> Int -> Pxl a) -> Int -> Int -> a
  imgWidth :: a -> Int
  imgHeight :: a -> Int

instance Pixel p => Img (Image p) where
  type Pxl (Image p) = p
  getPxl = pixelAt
  generateImg = generateImage
  imgWidth = imageWidth
  imgHeight = imageHeight

class BlackWhite a where
  black :: a
  white :: a

instance BlackWhite PixelRGBA8 where
  black = PixelRGBA8 0 0 0 255
  white = PixelRGBA8 255 255 255 255

instance BlackWhite PixelRGB8 where
  black = PixelRGB8 0 0 0
  white = PixelRGB8 255 255 255

instance BlackWhite PixelYCbCr8 where
  black = PixelYCbCr8 0 0 0
  white = PixelYCbCr8 255 255 255

instance BlackWhite Pixel8 where
  black = 0
  white = 255

instance BlackWhite PixelYA8 where
  black = PixelYA8 0 255
  white = PixelYA8 255 255

instance BlackWhite PixelCMYK8 where
  black = PixelCMYK8  0 0 0 255
  white = PixelCMYK8 0 0 0 0

class Invertible a where
  invert :: a -> a

instance Invertible PixelRGBA8 where
  invert (PixelRGBA8 r g b a) = PixelRGBA8 (255-r) (255-g) (255-b) a

instance Invertible PixelRGB8 where
  invert (PixelRGB8 r g b)  = PixelRGB8 (255-r) (255-g) (255-b)

instance Invertible PixelYCbCr8 where
  invert (PixelYCbCr8 r g b)  = PixelYCbCr8 (255-r) (255-g) (255-b)

instance Invertible Pixel8 where
  invert p = 255 - p

instance Invertible PixelYA8 where
  invert (PixelYA8 c a) = PixelYA8 (255-c) a

instance Invertible PixelCMYK8 where
  invert (PixelCMYK8 r g b a) = PixelCMYK8 (255-r) (255-g) (255-b) a

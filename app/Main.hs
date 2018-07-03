{-# LANGUAGE OverloadedStrings #-}

module Main where
 import Prelude

 import GHC.IO.Encoding (setLocaleEncoding, utf8)

 import System.FilePath ((</>))

 import Hakyll

 main :: IO ()
 main = do
  setLocaleEncoding utf8
  hakyllWith config $ do
   iconRule
   templatesRule
   stylesRule
   articlesRule

 config :: Configuration
 config = defaultConfiguration {
  providerDirectory = "docs-pre",
  destinationDirectory = "docs"}

 iconRule :: Rules ()
 iconRule = match "icon.png" $ do
  route idRoute
  compile copyFileCompiler

 templatesRule :: Rules ()
 templatesRule = match "templates\\\\*" $ compile templateCompiler

 stylesRule :: Rules ()
 stylesRule = match "styles\\\\*" $ do
  route idRoute
  compile $ compressCssCompiler

 articlesRule :: Rules ()
 articlesRule = match "articles\\\\graphics_in_haskell.rst" $ do
  route $ setExtension "html"
  compile pandocCompiler

 -------------------------------------------------------------------------------

 matchGlob :: String -> Rules () -> Rules ()
 matchGlob path rule = match (fromGlob path) rule

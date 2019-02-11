module Iterator where

class Iterator i where
  iterMap :: (a -> b) -> i a -> i b
  iterFold :: (a -> b -> a) -> a -> i b -> a

data List a = Cons a (List a)
            | Nil deriving (Eq, Show)

data Tree a = Branch a (List (Tree a))
            | Leaf deriving (Eq, Show)

data Queue a = Queue (List a) (List a) deriving (Show)

instance (Eq a) => Eq (Queue a) where
    (==) (Queue Nil ys) (Queue Nil xs) = ys == xs
    (==) q r = (rebalance q) == (rebalance r)

enqueue :: Queue a -> a -> Queue a
enqueue (Queue inbox outbox) x = Queue (Cons x inbox) outbox

rebalance (Queue Nil ys) = Queue Nil ys
rebalance (Queue (Cons x xs) ys) = rebalance (Queue xs (Cons x ys))

dequeue :: Queue a -> (Maybe a, Queue a)
dequeue (Queue Nil Nil) = (Nothing, Queue Nil Nil)
dequeue (Queue xs (Cons y ys)) = (Just y, Queue xs ys)
dequeue (Queue xs Nil) = dequeue (rebalance (Queue xs Nil))

instance Iterator List where
  iterMap f (Cons head tail) = Cons (f head) (iterMap f tail)
  iterMap f Nil = Nil 

  iterFold f res (Cons head tail) = iterFold f (f res head) tail
  iterFold f res Nil = res
instance Iterator Tree where
  iterMap f (Branch root children) = Branch (f root) (iterMap (iterMap f) children) 
  iterMap f Leaf = Leaf

  iterFold f res (Branch root children) = iterFold (iterFold f) (f res root) children
  iterFold f res Leaf = res
instance Iterator Queue where
  iterMap f (Queue head tail) = Queue (iterMap f head) (iterMap f tail)

  iterFold f res (Queue head tail) = iterFold f (iterFold f res head) tail
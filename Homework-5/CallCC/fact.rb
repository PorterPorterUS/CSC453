require 'continuation'

def factorial(n)
  return 1 if n == 0
  n * factorial(n - 1)
end

def fact_cps(n, c = callcc{|k| [n, 1, k]})
  (n, acc, k) = c
  if n == 0
    acc
  else
    k.call(n - 1, n * acc, k)
  end
end
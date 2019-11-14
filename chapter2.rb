# Exercise 1
def coinFlip
  n = rand(6)+1
  puts n
  return n>3 ? "heads" : "tails"
end

# Exercise 2
# No result probability is 0.625(62,5%)
heads = 3.0/4
tails = 1.0/4
two_heads = heads**2
two_tails = tails**2
no_res_probability = two_heads+two_tails

# Exercise 3
# No result probability is 0.5(50%)
heads2 = 1.0/2
tails2 = 1.0/2
two_heads2 = heads2**2
two_tails2 = tails2**2
no_res_probability2 = two_heads2+two_tails2

# Exercise 4
# Fair die: ~1.5%(6!/6**6), worse with biased die
def biasedSix
  loop do
    rands = []
    6.times { rands << rand(6)+1 }
    f=true
    1.upto(6) do |i|
      if(!rands.include?(i))
        f=false
        break
      end
    end
    return rands[0] if f
  end
end


# Exercise 5
# Runtime is O(M)

def pick(arr,m)
  max_i = arr.size-1
  0.upto(m-1) do |i|
    j = rand(i..max_i)
    arr[i],arr[j] = arr[j],arr[i]
  end
  return arr[0..m-1]
end


# Exercise 6
# Order doesnt matter

def randomize(arr)
  max_i = arr.size-1
  0.upto(max_i) do |i|
    j = rand(i..max_i)
    arr[i],arr[j] = arr[j],arr[i]
  end
  return arr
end


def dealCards(players)
  cards = []
  1.upto(52) { |i| cards << i }
  randomize(cards)
  result = []
  i = 0
  players.times do
    p = []
    5.times do
      p << cards[i]
      i+=1
    end
    result << p
  end
  return result
end

# Exercise 7

def twoSix
  a=rand(1..6)
  b=rand(1..6)
  return a+b
end

def trials(t)
  r = Array.new(11,0)
  t.times { r[twoSix-2]+=1 }
  2.upto(12) do |i|
    p = r[i-2]/t.to_f*100
    puts "#{i} - #{p.round}%"
  end
  return r
end


# Exercise 8
# If m<n algorithm changes order of arguments

def euclid(m,n)
  while(n!=0)
    r=m%n
    m=n
    n=r
  end
  return m
end

# Exercise 10

def exponentiation(a,p)
  if([0,1].include?(p)) then return [1,a][p] end
  n=1
  arr=[]
  while(n<p)
    arr << a**n
    n*=2
  end
  n/=2
  r=n
  i=arr.size-1
  product=arr[i]
  loop do
    while(r+n>p)
      n/=2
      i-=1
    end
    r+=n
    product*=arr[i]
    break if r>=p
  end
  return product
end


T = 200

0.upto(T) do |i|
  0.upto(T) do |j|
    if exponentiation(i,j)!=i**j then raise "Error for values #{i},#{j}" end
  end
end


# Exercise 14
# [561, 1105, 1729, 2465, 2821, 6601, 8911]

def sieve(n)
  is_composite = Array.new(n+1,false)
  (4..n).step(2) do |i|
    is_composite[i] = true
  end
  
  current_prime = 3
  stop_at = Integer.sqrt(n)
  
  while(current_prime <= stop_at)
    (current_prime*2..n).step(current_prime) { |i| is_composite[i] = true }
    
    #current_prime+=2
    #while((current_prime<=n)&&(is_composite[current_prime]))
    #  current_prime+=2
    #end
    
    loop do
      current_prime+=2
      break if(!((current_prime<=n)&&(is_composite[current_prime])))
    end
    
  end
  
  primes = []
  2.upto(n) do |i|
    if(!is_composite[i]) then primes << i end
  end
  
  return primes
end

PRIMES=[2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47]

if(sieve(50)!=PRIMES) then raise "Error" end

def isPrime(n)
  if(n==1) then return false end
  r=true
  (n-1).downto(2) do |i|
    if(n%i==0)
      r=false
      break
    end
  end
  return r
end


# For composite numbers
def isCarmichael(n)
  r=true
  (n-1).downto(2) do |a|
    if((euclid(a,n)==1)&&((a**(n-1)-1)%n!=0))
      r=false
      break
    end
  end
  return r
end


def generateCarmichael(limit)
  numbers,primes = [],sieve(limit)
  2.upto(limit) do |i|
    if((!primes.include?(i))&&(isCarmichael(i))) then numbers << i end
  end
  return numbers
end

if(generateCarmichael(3000)!=[561, 1105, 1729, 2465, 2821]) then raise "Error" end


# Exercise 9
# Least common multiple
# g=GCD(a,b), A=g*m, B=g*n,
# A*B/GCD(a,b) = g*m*g*n/g = g*m*n
def lcd(a,b)
  return a*b/euclid(a,b)
end

# Exercise 14
# Root of function f(x)-g(x) is where functions intersect


# Exercise 15
# Middle rectangle can reduce error for increasing and decreasing curves

def poly(x)
  return x**2
end

def linear(x)
  return x*2
end

def constant(x)
  return 10
end

# Left
def rectangleRule(func,xmin,xmax,intervals)
  dx=(xmax-xmin)/intervals
  total_area=0
  x=xmin
  intervals.times do
    total_area = total_area + dx*send(func,x)
    x+=dx
  end
  return total_area
end

# Middle
def rectangleRule2(func,xmin,xmax,intervals)
  dx=(xmax-xmin)/intervals
  total_area=0
  x=xmin+dx/2
  intervals.times do
    total_area = total_area + dx*send(func,x)
    x+=dx
  end
  return total_area
end


if(rectangleRule(:poly,0,200,25)!=2508800) then raise "Error" end
if(rectangleRule2(:poly,0,200,25)!=2665600) then raise "Error" end


# Exercise 12
# ...



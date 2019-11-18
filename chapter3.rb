# Exercises 1, 2
class Sentinel
  attr_accessor :next
end

class Cell
  attr_accessor :value, :next
  def initialize(n) @value=n end
end

ERR="Error"

def iter(top)
  while(top.next!=nil)
    puts top.next.value
    top=top.next
  end
end

def addAtBeginning(top,new_cell)
  new_cell.next=top.next
  top.next=new_cell
end

# Return new bottom
def addAtEnd(bottom,new_cell)
  bottom.next=new_cell
  return new_cell
end

def findCellBefore(top,value)
  while(top.next!=nil)
    if(top.next.value==value)then return top end
    top=top.next
  end
  return nil
end

def listLength(sentinel)
  l=0
  while(sentinel.next!=nil)
    l+=1
    sentinel=sentinel.next
  end
  return l
end

# Return updated bottom
def deleteAfter(after_me,bottom)
  if(after_me.next.next.nil?) then bottom = after_me end
  after_me.next=after_me.next.next
  return bottom
end

sent=Sentinel.new
bottomCell=Cell.new(42)
addAtBeginning(sent,bottomCell)
[12,38,80,2,16].each { | n | addAtBeginning(sent,Cell.new(n)) }
unless(listLength(sent)==6) then raise ERR end
bottomCell=addAtEnd(bottomCell,Cell.new(68))
bottomCell=addAtEnd(bottomCell,Cell.new(69))
bottomCell=addAtEnd(bottomCell,Cell.new(70))
unless(bottomCell.value==70) then raise ERR end
unless(listLength(sent)==9) then raise ERR end
cell69=findCellBefore(sent,70)
bottomCell=deleteAfter(cell69,bottomCell)
unless(listLength(sent)==8) then raise ERR end
unless(bottomCell.value==69) then raise ERR end

sentC=Sentinel.new
botC=Cell.new(33)
addAtBeginning(sentC,botC)
if(listLength(sentC)!=1)then raise ERR end
botC=deleteAfter(sentC,botC)
if(listLength(sentC)!=0)then raise ERR end
unless(botC==sentC) then raise ERR end
botC=addAtEnd(botC,Cell.new(2))
if(listLength(sentC)!=1)then raise ERR end
unless(botC.value==2)then raise ERR end

sentinel=Sentinel.new
sentinel2=Sentinel.new
[12,38,80,2,16].each { | n | addAtBeginning(sentinel,Cell.new(n)) }
max_cell=findCellBefore(sentinel,80).next



def findMaxCell(top)
  if((nc=top.next)==nil) then return nc end
  mc=top=nc
  while((nc=top.next)!=nil)
    if(nc.value>mc.value) then mc=nc end
    top=top.next
  end
  return mc
end


unless(findCellBefore(sentinel,9).nil?) then raise ERR end
unless(findMaxCell(sentinel2).nil?) then raise ERR end
if(findMaxCell(sentinel)!=max_cell) then raise ERR end

# Exercises 3,4,5,6

class SentinelD
  attr_accessor :next, :previous
  attr_reader :value
  def initialize
    @value=Float::INFINITY
  end
end

class CellD
  attr_accessor :value, :next, :previous
  def initialize(n) @value=n end
end

def insertCell(after_me,new_cell)
  new_cell.next=after_me.next # new_cell right link
  new_cell.previous=after_me # new_cell left link
  new_cell.next.previous=new_cell # right cell, left link
  new_cell.previous.next=new_cell # left cell, right link
end

def addAtBeginningD(top,new_cell)
  insertCell(top,new_cell)
end

def addAtBottom(bottom,new_cell)
  insertCell(bottom.previous,new_cell)
end

topSentinel=SentinelD.new
bottomSentinel=SentinelD.new
topSentinel.next=bottomSentinel
bottomSentinel.previous=topSentinel
[12,34,35,28,7,3].each { |i| addAtBeginningD(topSentinel,CellD.new(i)) }
addAtBottom(bottomSentinel,CellD.new(123))
cellToDel=CellD.new(2)
addAtBottom(bottomSentinel,cellToDel)
addAtBottom(bottomSentinel,CellD.new(77))


def iterD(top)
  while(top.next.value<Float::INFINITY)
    puts top.next.value
    top=top.next
  end
end

def iterB(bottom)
  while(bottom.previous.value<Float::INFINITY)
    puts bottom.previous.value
    bottom=bottom.previous
  end
end

def iterBoth(top,bottom)
  iterD(top)
  puts "------------------------"
  iterB(bottom)
  puts "------------------------"
end

def len(top)
  l=0
  while(top.next.value<Float::INFINITY)
    l+=1
    top=top.next
  end
  return l
end

def deleteD(targetCell)
  targetCell.previous.next=targetCell.next # left cell right link
  targetCell.next.previous=targetCell.previous # right cell left link
end

def testDelete(top,target)
  l=len(top)
  deleteD(target)
  return len(top)==l-1
end


unless(testDelete(topSentinel,cellToDel)) then raise ERR end

# Exercise 9
def isSortedAsc(top)
  if(top.next==nil||top.next.next.nil?) then return true end
  while(top.next.next!=nil)
    if(top.next.value>top.next.next.value) then return false end
    top=top.next
  end
  return true
end

unsorted = Sentinel.new
[1,2,3,4,5].each { | n | addAtBeginning(unsorted,Cell.new(n)) } # [5,4,3,2,1]
sorted = Sentinel.new
[5,4,3,2,1].each { | n | addAtBeginning(sorted,Cell.new(n)) } # [1,2,3,4,5]


if(isSortedAsc(unsorted))then raise ERR end
unless(isSortedAsc(sorted))then raise ERR end



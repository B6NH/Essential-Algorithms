# Exercises 1, 2

def factorial(n)
  return n.zero? ? 1 : n * factorial(n-1)
end

def fibonacci(n)
  return n<=1 ? n : fibonacci(n-1) + fibonacci(n-2)
end

ERR="Error"

# Exercise 3
def hanoi(from,to,helper,n)
  if(n==1)
    puts "#{from} -> #{to}" # move one disc
  else
    hanoi(from,helper,to,n-1) # move smaller discs to helper
    puts "#{from} -> #{to}" # move largest disc to destination
    hanoi(helper,to,from,n-1) # move smaller disc to destination
  end
end

#hanoi("A","C","B",3)

# Exercises 5, 6

require 'ruby2d'

set background: 'white'
set fullscreen: true

set width: 1920
set height: 1080
set viewport_width: 1920
set viewport_height: 1080

class Point
  attr_accessor :x, :y
  def initialize(x=0,y=0)
    @x=x
    @y=y
  end
end

# angle is angle of whole curve, ang is angle of next depths
def drawKoch(depth,pt1,angle,length,color,ang=60)
  v=0.0174532925
  angle_radians=angle*v
  if(depth==0)
    xx=length*Math.cos(angle_radians)+pt1.x
    yy=length*Math.sin(angle_radians)+pt1.y
    Line.new(
      x1: pt1.x, y1: pt1.y,
      x2: xx, y2: yy,
      width: 2,
      color: color,
      z: 20
    )
  else
    side=length/3.0 # triangle side
    s=Math.cos(ang*v)*side*2 # triangle bottom(space between 2 parts)
    part=(length-s)/2.0

    pt2=Point.new
    pt2.x=part*Math.cos(angle_radians)+pt1.x
    pt2.y=part*Math.sin(angle_radians)+pt1.y

    pt3=Point.new
    pt3.x=side*Math.cos((angle-ang)*v)+pt2.x
    pt3.y=side*Math.sin((angle-ang)*v)+pt2.y

    pt4=Point.new
    pt4.x=side*Math.cos((angle+ang)*v)+pt3.x
    pt4.y=side*Math.sin((angle+ang)*v)+pt3.y

    drawKoch(depth-1,pt1,angle,part,color,ang)
    drawKoch(depth-1,pt2,angle-ang,side,color,ang)
    drawKoch(depth-1,pt3,angle+ang,side,color,ang)
    drawKoch(depth-1,pt4,angle,part,color,ang)
  end
end

# 4 Koch curves
snowFlake = lambda { |point,size,color,angle=60,depth=3|
  x,y=point.x,point.y
  drawKoch(depth,Point.new(x,y),0,size,color,angle)
  drawKoch(depth,Point.new(x+size,y),90,size,color,angle)
  drawKoch(depth,Point.new(x+size,y+size),180,size,color,angle)
  drawKoch(depth,Point.new(x,y+size),270,size,color,angle)
  }

# Koch snowflake(3 Koch curves)
realSnowFlake = lambda { |point,size,color,angle=60,depth=3|
  x,y=point.x,point.y
  pt3=Point.new(size/2+x,y+(size*Math.sqrt(3))/2.0)
  drawKoch(depth,Point.new(x,y),0,size,color,angle)
  drawKoch(depth,Point.new(x+size,y),120,size,color,angle)
  drawKoch(depth,pt3,240,size,color,angle)
  }

COLORS=['blue','red','orange','green','lime','fuchsia','aqua','purple']

def star(point,startS,fun,dv)
  startX,startY=point.x,point.y
  step=100
  5.times do
    fun.call(Point.new(startX,startY),startS,COLORS[rand(COLORS.size)])
    startX+=step
    startY+=step/dv.to_f # dv=1 for snowFlake, dv=2 for realSnowFlake
    startS-=step*2
  end
end

#star(Point.new(180,200),600,snowFlake,1)
#star(Point.new(1140,200),600,realSnowFlake,2)
#realSnowFlake.call(Point.new(400,300),500,'red',85,5)
#snowFlake.call(Point.new(400,300),500,'red',85,5)
#show

# Exercise 7
def drawRelative(x,y,current)
  targetX = current.x + x
  targetY = current.y + y
  Line.new(
    x1: current.x, y1: current.y,
    x2: targetX, y2: targetY,
    width: 3,
    color: 'fuchsia',
    z: 20
  )

  return Point.new(targetX,targetY)
end


def hilbert(depth,dx,dy,current)
  if(depth>0)
    current = hilbert(depth-1,dy,dx,current)
  end
  current = drawRelative(dx,dy,current)
  if(depth>0)
    current = hilbert(depth-1,dx,dy,current)
  end
  current = drawRelative(dy,dx,current)
  if(depth>0)
    current = hilbert(depth-1,dx,dy,current)
  end
  current = drawRelative(-dx,-dy,current)
  if(depth>0)
    current = hilbert(depth-1,-dy,-dx,current)
  end
  return current
end

#hilbert(4,20,0,Point.new(20,20))
#show

# Exercises 8, 9

def sierpRight(depth,dx,dy,cr)
  if(depth>0)
    depth = depth - 1
    cr = sierpRight(depth,dx,dy,cr)
    cr = drawRelative(dx,dy,cr)
    cr = sierpDown(depth,dx,dy,cr)
    cr = drawRelative(2*dx,0,cr)
    cr = sierpUp(depth,dx,dy,cr)
    cr = drawRelative(dx,-dy,cr)
    cr = sierpRight(depth,dx,dy,cr)
  end
  return cr
end

def sierpDown(depth,dx,dy,cr)
  if(depth>0)
    depth = depth - 1
    cr = sierpDown(depth,dx,dy,cr)
    cr = drawRelative(-dx,dy,cr)
    cr = sierpLeft(depth,dx,dy,cr)
    cr = drawRelative(0,2*dy,cr)
    cr = sierpRight(depth,dx,dy,cr)
    cr = drawRelative(dx,dy,cr)
    cr = sierpDown(depth,dx,dy,cr)
  end
  return cr
end

def sierpLeft(depth,dx,dy,cr)
  if(depth>0)
    depth = depth - 1
    cr = sierpLeft(depth,dx,dy,cr)
    cr = drawRelative(-dx,-dy,cr)
    cr = sierpUp(depth,dx,dy,cr)
    cr = drawRelative(-2*dx,0,cr)
    cr = sierpDown(depth,dx,dy,cr)
    cr = drawRelative(-dx,dy,cr)
    cr = sierpLeft(depth,dx,dy,cr)
  end
  return cr
end

def sierpUp(depth,dx,dy,cr) #
  if(depth>0)
    depth = depth - 1
    cr = sierpUp(depth,dx,dy,cr)
    cr = drawRelative(dx,-dy,cr)
    cr = sierpRight(depth,dx,dy,cr)
    cr = drawRelative(0,-2*dy,cr)
    cr = sierpLeft(depth,dx,dy,cr)
    cr = drawRelative(-dx,-dy,cr)
    cr = sierpUp(depth,dx,dy,cr)
  end
  return cr
end



def sierpinski(depth,dx,dy,cr)
  cr = sierpRight(depth,dx,dy,cr)
  cr = drawRelative(dx,dy,cr)
  cr = sierpDown(depth,dx,dy,cr)
  cr = drawRelative(-dx,dy,cr)
  cr = sierpLeft(depth,dx,dy,cr)
  cr = drawRelative(-dx,-dy,cr)
  cr = sierpUp(depth,dx,dy,cr)
  drawRelative(dx,-dy,cr)
end

#sierpinski(4,12,12,Point.new(100,100))
#show


# Exercises 10, 11

def gasket(depth,side,position)
  half_side=side/2.0
  height = Math::sqrt(side**2 - half_side**2)

  if(depth.zero?)
    Triangle.new(
      x1: position.x,  y1: position.y, # top
      x2: position.x+half_side, y2: position.y+height, # right
      x3: position.x-half_side, y3: position.y+height, # left
      color: 'red',
      z: 100
    )
  else
    new_half = (half_side/2.0)
    new_height = Math::sqrt(half_side**2 - new_half**2)
    left_top = Point.new(position.x - new_half,position.y+new_height)
    right_top = Point.new(position.x + new_half,position.y+new_height)
    
    gasket(depth-1,half_side,position) # top
    gasket(depth-1,half_side,left_top) # left
    gasket(depth-1,half_side,right_top) # right
  end
end

#gasket(6,1000,Point.new(800,100))
#show

def carpet(depth,side,position)
  if(depth.zero?)
    Square.new(
      x: position.x, y: position.y,
      size: side,
      color: 'blue',
      z: 10
    )
  else
    ns = side/3.0 # new side
    px,py = position.x, position.y
    nd = depth-1 # new depth
    
    carpet(nd,ns,Point.new(px,py))
    carpet(nd,ns,Point.new(px+ns,py))
    carpet(nd,ns,Point.new(px+2*ns,py))
    
    carpet(nd,ns,Point.new(px,py+ns))
    carpet(nd,ns,Point.new(px+2*ns,py+ns))
    
    carpet(nd,ns,Point.new(px,py+2*ns))
    carpet(nd,ns,Point.new(px+ns,py+2*ns))
    carpet(nd,ns,Point.new(px+2*ns,py+2*ns))
  end
end


#carpet(4,600,Point.new(100,100))
#show


# ----------------------------------------------------------------
# TESTS
# ----------------------------------------------------------------
raise ERR if(factorial(3)!=6)
raise ERR if(factorial(4)!=24)
raise ERR if(factorial(5)!=120)
raise ERR if(factorial(6)!=720)
# ----------------------------------------------------------------
raise ERR if(fibonacci(6)!=8)
raise ERR if(fibonacci(7)!=13)
raise ERR if(fibonacci(8)!=21)
raise ERR if(fibonacci(9)!=34)
# ----------------------------------------------------------------

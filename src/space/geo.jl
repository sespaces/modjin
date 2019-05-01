# all things geodesic including transformations between standard
# geospatial coordinate systems
using Geodesy

# for direct manipulations of Cartesian and Longitude-Latitude coordinates
using CoordinateTransformations, Rotations, StaticArrays

# geometric and trigonomic constants
include("mathies.jl")

# distance from icosohedron center to vertices (1.90...)
icoso_circumradius = sqrt(Φ^2 + 1)
earth_radius = 6378137.0
expansion = 1 + 2π/5
contraction = 1 / (1 + 2π/5)
r = earth_radius * contraction

# interior angles from center to vertices
icoso_interior = rad2deg(atan(2))




# pi/10 is 18 degrees, 3 * pi/10 is 54
# in geographic terms, the first element of each pair is North (Z+),
#   the second is East (Y+)
directions = SVector.([ ( 0           ,  0            ),
                        ( sin(pi/10)  , -cos(pi/10)   ),
                        (-sin(3*pi/10), -cos(3*pi/10) ),
                        (-sin(3*pi/10),  cos(3*pi/10) ),
                        ( sin(pi/10)  ,  cos(pi/10)   ),
                        ( atan(2),  0 )])

center = LLA(0.0,0.0,0.0)

dir = LLA(rad2deg(pi/2 - atan(2)), 0.0, 0.0)

#trans = ENUfromLLA(center,wgs84)
#trans(direction)
# above, in one line:
dir_enu = ENU(dir,center,wgs84)

center, dir

ecef_enu = ECEFfromENU(center,wgs84)

lla_ecef = LLAfromECEF(wgs84)

dir_ecef = ecef_enu(dir_enu)

lla_ecef(dir_ecef)

point5 = lla_ecef(dir_ecef)


t =  0 # polar angle at start is 0E
pointsxy = []
for k in 4:-1:0
    push!(pointsxy, ( (r * sin(t + k * 2(pi/5))),
                      (r * cos(t + k * 2(pi/5))) ))
end
pointsxy
#dir5 = ENU(0.0, fi * r, 0.0)
#dir1 = ENU(-cos(2 * pio5),sin(2 * pio5), 0.0)
#point5 = ecef_enu(dir5)
#lla(point5)
#return([(point[1], point[2]) for point in pointsxy])

pointsxy[1]
point1 = ENU(pointsxy[1][1], pointsxy[1][2], 0.0)
p1_ecef = ecef_enu(point1)
lla_enu(p1_ecef)


pointsxy[5]
point5 = ENU(pointsxy[5][1], pointsxy[5][2], 0.0)
p5_ecef = ecef_enu(point5)
p5_lla = lla_enu(p5_ecef)


"""
typeof(pointsxy[5])

trans = ENUfromLLA(center,wgs84)
origin = trans(center)
point_enu = trans(point_lla)|
x = ECEFfromENU(center, wgs84)(newpoint)
LLAfromECEF(x)
"""

#rotY = LinearMap(RotZ(directions[6][1]))
#rotZ = LinearMap(RotY(directions[6][2]))
rotY = LinearMap(RotZ(sin(pio10)))
rotZ = LinearMap(RotY(0.0))
rotZY = compose(rotZ, rotY)
rotYZ = compose(rotY, rotZ)

old_ecef = ECEF(0.0, earth_radius, 0.0)
tolla = LLAfromECEF(wgs84)
old_lla = tolla(old_ecef)

rotz_old = tolla(ECEF(rotZ(old_ecef)))
roty_old = tolla(ECEF(rotY(old_ecef)))
rotzy_old = tolla(ECEF(rotZY(old_ecef)))
rotyz_old = tolla(ECEF(rotYZ(old_ecef)))

protY = LinearMap(RotZ(proportioned_dirs[6][1]))
protZ = LinearMap(RotY(proportioned_dirs[6][2]))
protZY = compose(protZ, protY)
protYZ = compose(protY, protZ)

protz_old = tolla(ECEF(protZ(old_ecef)))
proty_old = tolla(ECEF(protY(old_ecef)))
protzy_old = tolla(ECEF(protZY(old_ecef)))
protyz_old = tolla(ECEF(protYZ(old_ecef)))

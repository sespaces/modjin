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
pentpoints_right = SVector.([ ( sin(pi/10)  , -cos(pi/10)   ),
                              (-sin(3*pi/10), -cos(3*pi/10) ),
                              (-sin(3*pi/10),  cos(3*pi/10) ),
                              ( sin(pi/10)  ,  cos(pi/10)   ),
                              ( atan(2),  0 )])


# counter-clockwise x,y coords for pentagon with point up at fifth place
pentpoints_north = SVector.([ (-cos(pi/10)  ,  sin(pi/10)   ),
                              (-cos(3*pi/10), -sin(3*pi/10) ),
                              ( cos(3*pi/10), -sin(3*pi/10) ),
                              ( cos(pi/10)  ,  sin(pi/10)   ),
                              ( 0.0         ,  pi/2 - atan(2))
                              ])

dirs = pentpoints_north
dir_degrees = [(rad2deg(dir[1]), rad2deg(dir[2])) for dir in dirs]
dirs_lla = [ LLA( dir[2], dir[1], 0.0 ) for dir in dir_degrees]
dirs_ecef = [ ECEF( , dir[1], 0.0 dir[2]) for dir in dirs]
center = LLA(-90.0,90.0,0.0)
dirs_enu
#dir = LLA(rad2deg(pi/2 - atan(2)), 0.0, 0.0)
dir5 = LLA(dir_degrees[5][2], dir_degrees[5][1], 0.0)
dir5_enu = ENU(dir5,center,wgs84)

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

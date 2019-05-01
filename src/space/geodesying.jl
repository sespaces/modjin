# all things geodesic including transformations between standard
# geospatial coordinate systems
using Geodesy

# for direct manipulations of Cartesian and Longitude-Latitude coordinates
using CoordinateTransformations, Rotations, StaticArrays

# geometric and trigonomic constants
include("mathies.jl")


Φ
icoso_circumradius = sqrt(Φ^2 + 1)
r = earth_radius = 6378137.0

# pi/10 is 18 degrees, 3 * pi/10 is 54
# in geographic terms, the first element of each pair is North (Z+),
#   the second is East (Y+)
directions = SVector.([ ( 0           ,  0            ),
                        ( sin(pi/10)  , -cos(pi/10)   ),
                        (-sin(3*pi/10), -cos(3*pi/10) ),
                        (-sin(3*pi/10),  cos(3*pi/10) ),
                        ( sin(pi/10)  ,  cos(pi/10)   ),
                        ( Φ           ,  0            )])
proportioned_dirs = r * directions

rotY = LinearMap(RotZ(directions[6][1]))
rotZ = LinearMap(RotY(directions[6][2]))
rotZY = compose(rotZ, rotY)
rotYZ = compose(rotY, rotZ)


protY = LinearMap(RotZ(proportioned_dirs[6][1]))
protZ = LinearMap(RotY(proportioned_dirs[6][2]))
protZY = compose(rotZ, rotY)
protYZ = compose(rotY, rotZ)

composite = LinearMap(RotZ(directions[2][2])) ∘ LinearMap(RotY(directions[2][1]))
comp2 = inv(composite)

old_ecef = ECEF(0.0, earth_radius * -icoso_circumradius, 0.0)

tolla = LLAfromECEF(wgs84)

old_lla = tolla(old_ecef)

rotz_old = tolla(ECEF(rotZ(old_ecef)))
roty_old = tolla(ECEF(rotY(old_ecef)))

rotzy_old = tolla(ECEF(rotZY(old_ecef)))
rotyz_old = tolla(ECEF(rotYZ(old_ecef)))

protz_old = tolla(ECEF(protZ(old_ecef)))
proty_old = tolla(ECEF(protY(old_ecef)))

protzy_old = tolla(ECEF(protZY(old_ecef)))
protyz_old = tolla(ECEF(protYZ(old_ecef)))

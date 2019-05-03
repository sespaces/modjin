# all things geodesic including transformations between standard
# geospatial coordinate systems
using Geodesy

# for direct manipulations of Cartesian and Longitude-Latitude coordinates
using CoordinateTransformations, Rotations, StaticArrays

# geometric and trigonomic constants
include("mathies.jl")


# interior angles from center to vertices
icoso_interior = rad2deg(atan(2))
# distance from icosohedron center to vertices (1.90...)
icoso_circumradius = sqrt(Φ^2 + 1)
icoso_edge_len = 1 / cos(π/10)

earth_radius = 6378137.0
earth_diam = 2 * earth_radius
equator_circumference = pi * earth_diam

# 180 degrees = pi, so halve circumference
earthpi = equator_circumference / 2.0

# edge length of first icosohedron; 1/10 of circumference
earth_t = earth_radius * icoso_edge_len




expansion = 1 + 2π/5
contraction = 1 / (1 + 2π/5)

r = earth_radius * contraction


# icoso_verts points have an edge not a vertex at top and bottom;
# rotate -31.71 degrees ( -( pi/2 - atan(Φ) ) ) on the X axis
rotateX  = LinearMap( RotX( -( pi/2 - atan(Φ)) ) )

# that results in untidy longitudes; spin eastward 18 degrees
rotateZ  = LinearMap( RotZ(pi/10) )

# create a composite rotation
rotate = rotateZ ∘ rotateX

points = SVector.(rotate.(GEO_ICOSO_VERTS))

## generate LLA's for each point

# latitude is asin(z / R)
#   with rounding to prevent error in asin when |z/r| > 1
bead_lats = asin.( round(point[3]/icoso_circumradius, sigdigits=9) for point in points)

# longitude is atan2(y, x)
bead_lons = [atan(point[2],point[1]) for point in points]

degrees_lat = round.(rad2deg.(bead_lats), sigdigits=7)
degrees_lon = round.(rad2deg.(bead_lons))

earth12_labels = ["MA","BA","DA","LA","KA","SA","ME","BE","DE","LE","KE","SE"]

struct Bead
    location::LLA
    radius::Float64
    label::String
    description::String
end

earth12 = []

contracted_radius = contraction * earth_radius

for i in 1:12
    push!(earth12, Bead(LLA(degrees_lat[i],  degrees_lon[i]),
                        contracted_radius,
                        earth12_labels[i],
                        "point " * string(i) * " of 12 equidistant points"))
end

#println([(bead.label * "\n", bead.location, "\n") for bead in earth12])
for i in 1:11
    bead1 = earth12[i]
    for j in i+1:12
        bead2 = earth12[j]
        println(bead1.label, " to ", bead2.label, " = ",
                distance(bead1.location, bead2.location))
    end
    println("\n")
end

dist(p1::LLA, p2::LLA) =  pi * distance(p1, p2)

b1 = earth12[1].location
b2 = earth12[2].location

d = dist(b1,b2)


earth_radius
earth_diam = 2 * earth_radius
equator_circumference = pi * earth_diam
# 180 degrees = pi, so halve circumference
earthpi = equator_circumference / 2.0

sqrt((5+sqrt(5))/8) = cos(Pi/10)
# edge length of first icosohedron; 1/10 of circumference

earth_t = earth_radius / cos(pi/10)

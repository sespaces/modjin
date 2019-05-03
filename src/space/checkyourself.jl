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

# rate by which to expand or contract the radius of original circle
expansion = 1 + 2π/5
contraction = 1 / (1 + 2π/5)

## Set the original vertices (beads) at N/S poles, +/- 26.56 lat;
##    longitudes of thein North are 36, 108, 180, -108, -36
##    longitudes in South are 0, 72, 144, -144, -72

# icoso_verts points have an edge not a vertex at top and bottom;
# rotate -31.71 degrees ( -( pi/2 - atan(Φ) ) ) on the X axis
rotateX  = LinearMap( RotX( -( pi/2 - atan(Φ)) ) )
# that results in untidy longitudes; spin eastward 18 degrees
rotateZ  = LinearMap( RotZ(pi/10) )
# create a composite rotation
rotate = rotateZ ∘ rotateX
# create vectors for each point
bead_vectors = SVector.(rotate.(GEO_ICOSO_VERTS))
bead_vectors[1]
## create ECEF's for each point
ECEF(bead_vectors[2])
beads_ecef = [ECEF(vector) for vector in bead_vectors]
beads_ecef[4]



## create LLA's for each point
# this doesn't work; see rounding error correction in beads_lat below
#   bead_lla = LLAfromECEF(wgs84)
#   beads_lla_ecef = [bead_lla(bead) for bead in beads_ecef ]

# latitude is asin(z / R); rounding prevents asin error at |z/r| > 1
beads_lat = asin.( round(bead[3]/icoso_circumradius, sigdigits=9)
                       for bead in bead_vectors)
# longitude is atan2(y, x)
beads_lon = [atan(bead[2],bead[1]) for bead in bead_vectors]
degrees_lat = round.(rad2deg.(beads_lat), sigdigits=7)
degrees_lon = round.(rad2deg.(beads_lon))


beads_lla = []
for i in 1:12
    push!(beads_lla, LLA(degrees_lat[i],  degrees_lon[i]))
end
beads_lla

## create initial set of beads
#create "Bead" type
struct Bead
    location::LLA
    radius::Float64
    label::String
    description::String
end
# make some labels
earth12_labels = ["MA","BA","DA","LA","KA","SA","ME","BE","DE","LE","KE","SE"]
# calculate the new radius associated with new bead
# TODO TODO: this is wrong; needs radian help
contracted_radius = contraction * earth_radius
# populate the set
earth12 = []
for i in 1:12
    push!(earth12, Bead(beads_lla[i], contracted_radius, earth12_labels[i],
            "point " * string(i) * " of 12 equidistant points"))
end
beads12 = earth12


for i in 1:11
    bead1 = earth12[i]
    for j in i+1:12
        bead2 = earth12[j]
        println(bead1.label, " to ", bead2.label, " = ",
                distance(bead1.location, bead2.location))
    end
    println("\n")
end

b1 = beads12[1].location
b2 = beads12[2].location

abs(earth_t - distance(b1, b2))

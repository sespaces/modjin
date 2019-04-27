""" mathies.jl -- helpful geometry constants and aliases
    author: Daniel H. Morgan
    version: 0.1.1
    date: April 22, 2019
"""
# Shortcuts and Aliases

#1 km = (1/1.609344) mi = 0.62137119 mi
const KM_PER_MILE_RATIO = 1.609344
const MILE_PER_KM_RATIO = 0.62137119

## Math Constants
#### square roots of integers 2, 3, 5, 6, 8, and 10
    const SQRT2 = sqrt(2)
    const SQRT3 = sqrt(3)
    const SQRT5 = sqrt(5)
    const SQRT6 = sqrt(6)
    const SQRT8 = sqrt(8)
    const SQRT10 = sqrt(10)
### variations of phi
    const φ = (sqrt(5) - 1) / 2        # \varphi, inverse golden ratio 0.618...
    ϕ = const Φ = (sqrt(5) + 1) / 2    # \phi or \Phi, golden ratio 1.618...
    const ΦSQ =  1 + ((sqrt(5) + 1) / 2)  # \PhiSQ, phi squared, 2.618...
    const HALFφ= φ/2.0
    const HALFΦ = Φ/2.0
    const HALFΦSQ = ΦSQ/2.0
    const SQRTφ = sqrt(φ)
    const SQRTΦ = sqrt(Φ)
    const SQRTΦSQ = sqrt(ΦSQ)
### fractions of pi
    const πOVER2 = pi / 2
    const πOVER3 = pi / 3
    const πOVER4 = pi / 4
    const πOVER5 = pi / 5
    const πOVER6 = pi / 6
    const πOVER10 = pi / 10
## Cartesian Geometric Points
### 3D-Graphics orientation where:
    # a cube of edge-length 2, as seen from straight-on has its
    #   right face (+X) centered at [1, 0, 0], its
    #     top face (+Y) at [0, 1, 0], and its
    #     front face (+Z) centererd at [0, 0, 1];
    #     the left face is -X, bottom is -Y, and rear is -Z;
    #   +T, +U, +V, +W are vertices at right-top-front, right-bottom-rear,
    #     left-top-rear, and left-bottom-front, respectively;
    #   N, O, P, Q, R, S are the midpoints of the edges where:
    #     +N is the midpoint of top edge of front face, +O on bottom of front,
    #     +P on right edge of front face, +Q is right edge of right face,
    #     +R is top edge of right face, +S is top edge of left face
const CTR = [0, 0, 0]
##### center points X Y Z, vertices T U V W, and edge midpoints N O P Q R S
const X = [ 1,  0,  0]
const Y = [ 0,  1,  0]
const Z = [ 0,  0,  1]
const T = [ 1,  1,  1]
const U = [ 1, -1, -1]
const V = [-1,  1, -1]
const W = [-1, -1,  1]
const N = [ 0,  1,  1]
const O = [ 0, -1,  1]
const P = [ 1,  0,  1]
const Q = [ 1,  0, -1]
const R = [ 1,  1,  0]
const S = [-1,  1,  0]

""" GEOGRAPHIC CARTESIAN: North is Z+, 180 East is Y+, 90 East is X+
const X = [ 1,  0,  0]
const Y = [ 0,  1,  0]
const Z = [ 0,  0,  1]
const T = [ 1,  1,  1]
const U = [ 1, -1, -1]
const V = [-1,  1, -1]
const W = [-1, -1,  1]

const N = [ 0,  1,  1]
const O = [ 0, -1,  1]
const P = [ 1,  0,  1]
const Q = [ 1,  0, -1]
const R = [ 1,  1,  0]
const S = [-1,  1,  0]
"""


#### each vector transformed by magnitudes phi and 1/phi
const ΦX  = Φ * X, const φX = φ * X
const ΦY  = Φ * Y, const φY = φ * Y
const ΦZ  = Φ * Z, const φZ = φ * Z
const ΦT  = Φ * T, const φT = φ * T
const ΦU = Φ * U, const φU = φ * U
const ΦV = Φ * V, const φV = φ * V
const ΦW = Φ * W, const φW = φ * W
const ΦN = Φ * N, const φN = φ * N
const ΦO = Φ * O, const φO = φ * O
const ΦP = Φ * P, const φP = φ * P
const ΦQ = Φ * Q, const φQ = φ * Q
const ΦR = Φ * R, const φR = φ * R
const ΦS = Φ * S, const φS = φ * S
#### variations on N through S for use as dodecahedral vertices
const Nφ = [ 0,  φ,  Φ ]
const Oφ = [ 0, -φ,  Φ ]
const Pφ = [ Φ,  0,  φ ]
const Qφ = [ Φ,  0, -φ ]
const Rφ = [ Φ,  φ,  0 ]
const Sφ = [-φ,  Φ,  0 ]
#### variations on N through S for use as icosohedral vertices
const NΦ = [ 0,  Φ,  1 ]
const OΦ = [ 0, -Φ,  1 ]
const PΦ = [ 1,  0,  Φ ]
const QΦ = [ 1,  0, -Φ ]
const RΦ = [ Φ,  1,  0 ]
const SΦ = [-Φ,  1,  0 ]
# Polyhedra
const TETRA_VERTS = [T, U, V, W]
const OCTA_VERTS = [X, Y, Z, -X, -Y, -Z]
const CUBE_VERTS = [T, U, V, W, -T, -U, -V, -W]
const DODECA_VERTS = [T, U, V, W, -T, -U, -V, -W,
                      Nφ, Oφ, Pφ, Qφ, Rφ, Sφ,
                      -Nφ, -Oφ, -Pφ, -Qφ, -Rφ, -Sφ]
const ICOSO_VERTS = [NΦ, OΦ, PΦ, QΦ, RΦ, SΦ,
                     -NΦ, -OΦ, -PΦ, -QΦ, -RΦ, -SΦ]
const TRIACONTA_VERTS = vcat(DODECA_VERTS, ICOSO_VERTS)
const RHOMBIC_DODECA_VERTS = vcat(CUBE_VERTS, 1.5*OCTA_VERTS)


# GEOSPATIAL -- Z+ takes value Y+ and Y+ takes Z- from graphics-orientation
# icosohedral vertices
# TODO: composite transformation indicated in comment above; apply to [TODO: Typed ] arrays
#    of constants organized similar to above non-arrayed, non-typed constants
const GNΦ = [ 0, -1,  Φ ]
const GOΦ = [ 0,  1,  Φ ]
const GPΦ = [ 1, -Φ,  0 ]
const GQΦ = [-1, -Φ,  0 ]
const GRΦ = [ Φ,  0,  1 ]
const GSΦ = [-Φ,  0,  1 ]

GEO_ICOSO_VERTS = [-GNΦ, -GOΦ, -GPΦ, -GQΦ, -GRΦ, -GSΦ, GNΦ, GOΦ, GPΦ, GQΦ, GRΦ, GSΦ]

earth_radius = 6378137 # 6,378,137 meters, roughly 6,378 Km


## Aliases
### math constants
#### square roots of integers 2, 3, 5, 6, 8, and 10
    sq2 = SQRT2
    sq3 = SQRT3
    sq5 = SQRT5
    sq6 = SQRT6
    sq8 = SQRT8
    sq10 = SQRT10
#### 1/phi, phi, and phi^2, with their halves and square roots
    fe = φ
    fi = Φ
    fu = ΦSQ
    hafe = HALFφ
    hafi = HALFΦ
    hafu = HALFΦSQ
    sqfe = SQRTΦ
    sqfi = SQRTΦ
    sqfu = SQRTΦSQ
#### N through S variations
    nfi, ofi, pfi, qfi, rfi, sfi = NΦ, OΦ, PΦ, QΦ, RΦ, SΦ
    nfe, ofe, pfe, qfe, rfe, sfe = Nφ, Oφ, Pφ, Qφ, Rφ, Sφ
#### fractions of pi
    pio2 = πOVER2
    pio3 = πOVER3
    pio4 = πOVER4
    pio5 = πOVER5
    pio6 = πOVER6
    pio10 = πOVER10
included_message = "mathies.jl inclusion concluded"

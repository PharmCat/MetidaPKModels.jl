module MetidaPKModels

"""
Extravascular one-compartmental model.
"""
function ev1cpk(F, D, kₐ, kₑ, V, t, tlag = 0)
    t = t - tlag
    if t < 0 return zero(t) end
    F * D * kₐ * (exp(-kₑ * t) - exp(-kₐ * t)) / (V * (kₐ - kₑ))
end

"""

Differential equations for extravascular one-compartmental model.
"""
function de_ev1cpk!(du, u, p, t)
    kₐ, kₑ, V₁ = p
    A, C₁  = u
    du[1]  = -kₐ * A
    du[2]  =  kₐ * A / V₁ - kₑ  * C₁ 
end

"""
Differential equations for extravascular two-compartmental model (only V₁).
"""
function de_ev2cpk1v!(du, u, p, t)
    kₐ, kₑ, k₁₂, k₂₁, V₁ = p
    A, C₁, C₂ = u
    du[1] = -kₐ  * A
    du[2] =  kₐ  * A / V₁   - (kₑ  + k₁₂) * C₁ + k₂₁ * C₂
    du[3] =  k₁₂ * C₁ -  k₂₁ * C₂
end

"""
Differential equations for extravascular two-compartmental model (V₁, V₂).
"""
function de_ev2cpk2v!(du, u, p, t)
    kₐ, kₑ, k₁₂, k₂₁, V₁, V₂ = p
    A, C₁, C₂ = u
    ζ = V₂ / V₁
    du[1] = -kₐ  * A
    du[2] =  kₐ  * A  / V₁  - (kₑ  + k₁₂) * C₁ + k₂₁ * ζ * C₂
    du[3] =  k₁₂ * C₁ / ζ -  k₂₁ * C₂
end


"""
Differential equations for extravascular two-compartmental model (only V₁) where k₁₂ = k₂₁.
"""
function de_ev2cpk1v_ek!(du, u, p, t)
    kₐ, kₑ, kᵩ, V₁ = p
    A, C₁, C₂ = u
    du[1] = -kₐ  * A
    du[2] =  kₐ  * A / V₁  - kₑ * C₁ - kᵩ * (C₁ -  C₂)
    du[3] =  kᵩ * (C₁ -  C₂)
end


"""
Differential equations for extravascular two-compartmental model (V₁, V₂) where k₁₂ = k₂₁.
"""
function de_ev2cpk2v_ek!(du, u, p, t)
    kₐ, kₑ, kᵩ, V₁, V₂ = p
    A, C₁, C₂ = u
    ζ = V₂ / V₁
    du[1] = -kₐ * A
    du[2] =  kₐ * A / V₁ - kₑ * C₁  - kᵩ * (C₁ - ζ * C₂)
    du[3] =  kᵩ * ( C₁ / ζ -  C₂)
end


end

module MetidaPKModels

function ev1cpk(F, D, kₐ, kₑ, V, t, tlag = 0)
    t = t - tlag
    if t < 0 return zero(t) end
    F * D * kₐ * (exp(-kₑ * t) - exp(-kₐ * t)) / (V * (kₐ - kₑ))
end

function de_ev1cpk!(du, u, p, t)
    kₐ, kₑ = p
    A, C₁  = u
    du[1]  = -kₐ * A
    du[2]  =  kₐ * A - kₑ  * C₁ 
end

function de_ev2cpk!(du, u, p, t)
    kₐ, kₑ, k₁₂, k₂₁ = p
    A, C₁, C₂ = u
    du[1] = -kₐ  * A
    du[2] =  kₐ  * A  - (kₑ  + k₁₂) * C₁ + k₂₁ * C₂
    du[3] =  k₁₂ * C₁ -  k₂₁ * C₂
end

end

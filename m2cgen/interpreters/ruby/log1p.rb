def log1p(x)
    if x == 0.0
        return 0.0
    end
    if x == -1.0
        return -Float::INFINITY
    end
    if x < -1.0
        return Float::NAN
    end
    x_abs = x.abs
    if x_abs < 0.5 * Float::EPSILON
        return x
    end
    if (x > 0.0 && x < 1e-8) || (x > -1e-9 && x < 0.0)
        return x * (1.0 - x * 0.5)
    end
    if x_abs < 0.375
        coeffs = [
             0.10378693562743769800686267719098e+1,
            -0.13364301504908918098766041553133e+0,
             0.19408249135520563357926199374750e-1,
            -0.30107551127535777690376537776592e-2,
             0.48694614797154850090456366509137e-3,
            -0.81054881893175356066809943008622e-4,
             0.13778847799559524782938251496059e-4,
            -0.23802210894358970251369992914935e-5,
             0.41640416213865183476391859901989e-6,
            -0.73595828378075994984266837031998e-7,
             0.13117611876241674949152294345011e-7,
            -0.23546709317742425136696092330175e-8,
             0.42522773276034997775638052962567e-9,
            -0.77190894134840796826108107493300e-10,
             0.14075746481359069909215356472191e-10,
            -0.25769072058024680627537078627584e-11,
             0.47342406666294421849154395005938e-12,
            -0.87249012674742641745301263292675e-13,
             0.16124614902740551465739833119115e-13,
            -0.29875652015665773006710792416815e-14,
             0.55480701209082887983041321697279e-15,
            -0.10324619158271569595141333961932e-15]
        return x * (1.0 - x * chebyshev_broucke(x / 0.375, coeffs))
    end
    return Math.log(1.0 + x)
end
def chebyshev_broucke(x, coeffs)
    b2 = b1 = b0 = 0.0
    x2 = x * 2
    coeffs.reverse_each do |i|
        b2 = b1
        b1 = b0
        b0 = x2 * b1 - b2 + i
    end
    (b0 - b2) * 0.5
end
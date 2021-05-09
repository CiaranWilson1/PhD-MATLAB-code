function phasor = lsPhasor(coeff,jj,a11)
phasor(coeff) = e^(jj*angle(a11));
end
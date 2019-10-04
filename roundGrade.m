function gradesRounded = roundGrade(grades)
%
% Input argumenter: grades: En vektor (med karaktere).
%
% Output argumenter: gradesRounded: En vektor (hvert element er et tal på 7-trinsskalaen).
%
% Funktionen skal afrunde hvert element i vektoren grades og returnere den nærmeste
% karakter på 7-trinsskalaen:
%
roundTargets = [-3,0,2,4,7,10,12];
% interp1 afrunder til 'nearest' i roundTargets. 'extrap' tager værdier udenfor roundTargets
gradesRounded = interp1(roundTargets,roundTargets,grades,'nearest','extrap');
end

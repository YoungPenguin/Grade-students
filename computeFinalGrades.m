function gradesFinal = computeFinalGrades(grades)
%
% Input argumenter: grades: En N � M matrix som indeholder karakterer p�
%                   7-trinsskalaen (og vores tilf�jelse evt. udenfor eller
%                    NaN v�rdier) givet til N studerende for M opgaver.
%
% Output argumenter: gradesFinal: En vektor med l�ngde N som indeholder den
%                    endelige karakter for hver af de N studerende.
%
% Funktionen skal: Hvis der kun er en opgave (M = 1) er den endelige karakter
%                  lig karakteren for den opgave. Da vi ogs� h�ndterer
%                  v�rdier, der ikke er p� 7-trinsskalaen, v�lger vi ogs� at
%                  afrunde denne.
%
%                  Hvis der er to eller flere opgaver (M > 1), skal den laveste
%                  karakter ikke medregnes. Den endelige karakter beregnes som
%                  gennemsnittet af de M-1 h�jeste karaktere, afrundet til
%                  n�rmeste karakter p� skalaen (vha. funktionen roundGrade).
%
% Hvis en karakter er dumpet, s� er den studerende dumpet(alts� -3 ikke 00).
% Dumpet er alle grades der er (grades <= -3) da hvis en grade er mindre
% end -3 vil den blive afrundet til -3. Vi har derfor tolket det som om at
% gradesFinal for disse v�rdier skal v�re -3.
%
% I vores program er det ikke n�dvendigt at alle studerende har l�st samme
% antal opgaver. (se REDEEM for eksempler)
%

% Diffinerer hvad der er dumpet
dumpet = any(grades <= -3,2);
[N,~] = size(grades);
% Array af zeros, for at holde st�rrelsen af vektoren.
gradesFinal = zeros(1,N);
% Kun 1 opgave l�st (dette er eksklusiv NaN v�rdier) og ikke dumpet
for i = 1:N
    if size(grades(~isnan(grades(i,:))),2) == 1 && any(~dumpet)
        % Vi s�tter blot karakteren 2 gange, da den laveste vil blive
        % fjernet og dermed giver sig selv. Det er gjort p� denne m�de, for
        % at h�ndtere evt. NaN v�rdier, hvis ikke alle har l�st samme antal opgaver
        grades(i,1:2) = sort(grades(i,1));
        % Vi �nskede ogs� at afrunde, hvis der kun var 1 karakter men de
        % stadigv�k ikke var p� syvtrinsskalaen
    end
end
% Hvis dumpet f�r man -3
gradesFinal(dumpet)  = -3;
% Soterer alle v�rdier, der ikke er dumpet
grades = sort(grades(~dumpet,:),2);
% Laveste karakter i grades(:,1) tages fra s�ledes
grades = grades(:,2:end);
% Afrunder med roundGrade, og vi s�tter dem korrekt i gradesFinal vektoren
gradesFinal(~any(gradesFinal == -3,1)) = roundGrade(nanmean(grades,2));
gradesFinal = gradesFinal(:);
end

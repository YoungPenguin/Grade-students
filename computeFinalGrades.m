function gradesFinal = computeFinalGrades(grades)
%
% Input argumenter: grades: En N × M matrix som indeholder karakterer på
%                   7-trinsskalaen (og vores tilføjelse evt. udenfor eller
%                    NaN værdier) givet til N studerende for M opgaver.
%
% Output argumenter: gradesFinal: En vektor med længde N som indeholder den
%                    endelige karakter for hver af de N studerende.
%
% Funktionen skal: Hvis der kun er en opgave (M = 1) er den endelige karakter
%                  lig karakteren for den opgave. Da vi også håndterer
%                  værdier, der ikke er på 7-trinsskalaen, vælger vi også at
%                  afrunde denne.
%
%                  Hvis der er to eller flere opgaver (M > 1), skal den laveste
%                  karakter ikke medregnes. Den endelige karakter beregnes som
%                  gennemsnittet af de M-1 højeste karaktere, afrundet til
%                  nærmeste karakter på skalaen (vha. funktionen roundGrade).
%
% Hvis en karakter er dumpet, så er den studerende dumpet(altså -3 ikke 00).
% Dumpet er alle grades der er (grades <= -3) da hvis en grade er mindre
% end -3 vil den blive afrundet til -3. Vi har derfor tolket det som om at
% gradesFinal for disse værdier skal være -3.
%
% I vores program er det ikke nødvendigt at alle studerende har løst samme
% antal opgaver. (se REDEEM for eksempler)
%

% Diffinerer hvad der er dumpet
dumpet = any(grades <= -3,2);
[N,~] = size(grades);
% Array af zeros, for at holde størrelsen af vektoren.
gradesFinal = zeros(1,N);
% Kun 1 opgave løst (dette er eksklusiv NaN værdier) og ikke dumpet
for i = 1:N
    if size(grades(~isnan(grades(i,:))),2) == 1 && any(~dumpet)
        % Vi sætter blot karakteren 2 gange, da den laveste vil blive
        % fjernet og dermed giver sig selv. Det er gjort på denne måde, for
        % at håndtere evt. NaN værdier, hvis ikke alle har løst samme antal opgaver
        grades(i,1:2) = sort(grades(i,1));
        % Vi ønskede også at afrunde, hvis der kun var 1 karakter men de
        % stadigvæk ikke var på syvtrinsskalaen
    end
end
% Hvis dumpet får man -3
gradesFinal(dumpet)  = -3;
% Soterer alle værdier, der ikke er dumpet
grades = sort(grades(~dumpet,:),2);
% Laveste karakter i grades(:,1) tages fra således
grades = grades(:,2:end);
% Afrunder med roundGrade, og vi sætter dem korrekt i gradesFinal vektoren
gradesFinal(~any(gradesFinal == -3,1)) = roundGrade(nanmean(grades,2));
gradesFinal = gradesFinal(:);
end

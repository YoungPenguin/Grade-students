function infoFunktion(grades)
%
% Funktionen laver udskriften når en en gyldig datafil er loadet. I udskriftet 
% vil der blive nævnt antal opgaver, antal elever og det samlede karatergennemsnit.
%
% Input argumenter: grades: En N × M matrix som indeholder karakterer fra
%                           den ønskede fil
% Output argumenter: nej
%
% Bruger-input: nej
%
% Skærm-output: ja (Antal studerende, hvor mange opgaver samt klasseGennemsnit.)
%
[N,M] = size(grades);
fprintf('\nFilen indeholder %d studerende, med maksimalt %d opgaver løst. \n',N,M);
gradesFinal = computeFinalGrades(grades);
% nanmean benyttes, hvis en studerende er skrevet ind uden nogle karaktere.
klasseGennemsnit = nanmean(gradesFinal);
fprintf('\nDe studerendes samlet gennemsnit %.2f \n',klasseGennemsnit);
end

function errorCheck(grades)
%
% Funktionen skal vise en rapport over fejl (hvis der er nogle) i den indl�ste datafil,
% hvis brugeren v�lger at checke for datafejl.
%
% Input argumenter: grades (table format) (den indl�ste data, med studie-id,
%                   navne og karaktere (i vores tilf�llede gradesTable)).
% Bruger-input: nej.
%
% Sk�rm-output: Hvor der er fejl data ( samme studie-id, eller karakter der
%               ikke findes p� 7-trinsskalaen)(bliver udskrevet i r�d tekst
%               dette er meningen).
%

syvtrinsskala = [-3; 0; 2; 4; 7; 10; 12];
[N,M] = size(grades);
studentID = grades{:,1};
%% Duplicate studentID inspired from: https://se.mathworks.com/matlabcentral/answers/265262-finding-duplicate-string-values-in-two-cell-array-22124x1
% Dataen inddeles vedbrug af histc og unique, herefter udtages E>1, da det
% er her, vi vil finde vores duplikater.
[uniqueList,~,uniqueNdx] = unique(studentID);
E = histc(uniqueNdx,1:numel(uniqueList));
dupNames = uniqueList(E>1);
for i = 1:length(dupNames)
    % fprintf(2,...) laver texten r�d
    fprintf(2, 'studienummeret %s. findes flere gange\n',dupNames{i});
end
%% Invalid grades
% Vi finder blot alle de grades der ikke er i vores karakterskala (variablen syvtrinsskala)
for i = 1:N
    % Vi k�rer l�kken fra 3, da vi ikke �nsker navn og studienummer med her
    for j = 3:M
        if ~ismember(grades{i,j},syvtrinsskala)
            % fprintf(2,...) laver texten r�d
            fprintf(2, 'Der er opgivet en ugyldig karakter for %s , i Assignment %d. linje %d. \n', studentID{i}, j-2, i); % j-2 da vi har j = 3:N
        end
    end
end
end

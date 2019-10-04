function gradeTable = dataLoad(filename)
%
% Funktionen skal indlæse data fra datafilen filename. Hver linje i datafilen indeholder
% de følgende felter: StudentID,Name,Assignment1,Assignment2,...,Assignmentn.
%
% Input argumenter: filename; En tekst-streng som indeholder filnavnet på en datafil.
%
% Bruger-input: nej
%
% Skærm-output: nej
%
% Output argumenter: gradeTable En N x M table.
%        Denne funktion er blevet implementeret pga.
%        vi har valgt at løse denne opgave som om, at det er muligt at der
%        ved en fejl kunne komme evt tekst eller ingen værdi i karakter-felterne
%        for nogle studerende. Denne funktion gør det muligt at bruge denne data
%        påtrods af disse fejl. Disse fejl vil stadigvæk bliver vist under
%        fejltjek. Dette er gjordt, da vi ikke synes det var klart om disse
%        tilfælede skulle kunne håndteres, samt vi ønskede at udvikle lidt
%        på programmet.
%

% Vi nulstiller warning
lastwarn('');

% Komma-separeret (CSV) datafil loades
gradeTable = readtable(filename,'ReadVariableNames',true);
[N,M]      = size(gradeTable);

[~, msgidlast] = lastwarn;
% Vi informere brugeren om hvad denne meddelse betyder ifht. den loadet fil
if strcmp(msgidlast,'MATLAB:table:ModifiedAndSavedVarnames')
    fprintf(2, '\nFormateringen af filen er abnorm, du vil opleve fejl hvis dette ikke korrigeres i filen\n')
    return;
end
% Hvis der optræder text i karakterfleter
for i = 1:N
    for j = 3:M
        cell = gradeTable {i,j};
        % Hvis der indgår bogstaver i et karakter felt
        if iscell(cell)
            % +46 fordi det er ASCII +48-2 da vi starter på 3
            navn = ['Assignment',j+46];
            % Konverterer tal i en text (string) til tal der kan anvendes (double)
            t    = str2double(gradeTable{:,j});
            % Substituere den ønskede
            gradeTable(:,j) = [];
            % Tallene i datafilen er nu brugbare for resten af vores kode
            gradeTable = addvars(gradeTable,t,'NewVariableNames', {navn},'Before',j);
        end
    end
end
end

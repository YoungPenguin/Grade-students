%% Hoved-script
%% MATLAB R2018a
%% Projekt 2: Eksamensprojekt
%% Program til karaktergivning af studerende
%
%              L�S REDEEM!!!
%
% Dette er vores Hoved-script til projektet
%
% Vi clear og clc, n�r programmet afsluttes, udkommenter de 2 sidste linjer
% i hoved-scriptet hvis du ikke �nsker dette!
%
% Vi har udviklet de obligatoriske funktioner:
%% roundGrade
%% computeFinalGrades
%% gradesPlot
%
% Herudover har vi tilf�jet et par funktioner for overskuelighedens skyld
%% dataLoad
%% errorCheck
%% infoFunktion
% mere info omkring disse f�lger.
%
% I dette hoved-script er der:
%
% Bruger-input: ja (se opgave formuleringe samt l�bende kommentering)
% Sk�rm-output: ja (se opgave formuleringe samt l�bende kommentering)
%
%% Initialiserer
% Lidt OCD, men nu er vi sikre p�, at de starter tomme (lidt overkill)
gradeTable   = [];
gradesOnly   = [];
% itemlist bruges til hovemMenu
itemListNavn = {'1. Indl�s ny data.', '2. Check for datafejl.',...
    '3. Generer diagrammer.','4. Vis karakterliste.','5. Afslut.'};

% For ikke at blive stuck i et uendeligt loop, s� tjekker vi om der er .csv
% filer tilst�de i working dir. Hvis det ikke er tilf�ldet afsluttes.
if ~isempty(dir('*csv'))
    % Liste over mulige gyldige filer
    dir('*csv');
    % Start p� script der beder brugeren om at indl�se en fil via prompt
    filename = input('\nIntast et gyldigt filnavn? ', 's');
    while ~isfile(filename)
        errordlg('V�lg en gyldig fil','Ugyldig fil');
        dir('*csv');
        filename = input('\nIntast et gyldigt filnavn? ', 's');
    end
else
    % hvis der ikke findes nogle .csv filer i dit working directory
    fprintf(2,'\nDer blev ikke fundet nogle gyldige filer i dit working directory\n');
    clear;
    return;
end
% dataLoad benyttes til at indl�se filen (mere info l�ses i dataLoad)
gradeTable  = dataLoad(filename);
% Laver en matrix som kr�vet til det korrekte input
gradesOnly = gradeTable{:,3:end};

% Hvis filen er tom/fyldt?
if ~isempty(gradeTable)
    % Antal studerende, hvor mange opgaver samt klasseGennemsnit.
    infoFunktion(gradesOnly);
else
    % Hvis det er en tom fil
    disp('Den valgte fil er tom');
end

% N�r den �nskede fil er indtastet (som ikke er tom), visses hovemenuen.
%% menu start
while true
    hovedMenu = menu('Hovedmenu','1. Indl�s ny data.', '2. Check for datafejl.',...
        '3. Generer diagrammer.','4. Vis karakterliste.','5. Afslut.');
    % For at h�ndtere det r�de kryds laves et if-statement. Det er lavet s�dan, for at g�re
    % koden overskuelig og l�sebar. Dette er lavet istedet for case 0, hvis ikke ithemList anvendes.
    if hovedMenu ~= 0
        switch itemListNavn{hovedMenu}
            case '1. Indl�s ny data.'
                % uigetfile load af fil. Giver kun adgang til .csv filer
                [filename,path] = uigetfile('*csv');
                if isequal(filename,0)
                    % Ugyldig fil
                    errordlg('V�lg en gyldig fil','Ugyldig fil');
                else
                    % Diffinerer matrix til input i andre funktioner
                    gradeTable  = dataLoad(filename);
                    gradesOnly = gradeTable{:,3:end};
                    
                    if ~isempty(gradeTable)
                        disp(['Valgte fil: ', fullfile(path,filename)]);
                        % Antal studerende, hvor mange opgaver samt klasseGennemsnit.
                        infoFunktion(gradesOnly);
                    else
                        disp('Den valgte fil er tom');
                    end
                end
            case '2. Check for datafejl.'
                if ~isempty(gradeTable)
                    % Dataen tjekkes for fejl via errorCheck-funktionen (se mere i errorCheck)
                    answer = questdlg('Hvor �nsker du at tjeke for datafejl?',...
                        'wut are you doin', ...
                        'data-fil','karakterliste','data-fil');
                    % H�ndterer answer
                    switch answer
                        case 'data-fil'
                            errorCheck(gradeTable);
                            disp('Data-filen er blevet tjeket for fejl');
                        case 'karakterliste'
                            errorCheck(sortrows(gradeTable,2));
                            disp('Karakterlisten er blevet tjeket for fejl');
                    end
                else
                    % H�ndterer answer
                    answer = questdlg('Indl�s data','hvad laver du?','OK','OK');
                    switch answer
                        case 'OK'
                    end
                end
                
            case '3. Generer diagrammer.'
                if ~isempty(gradeTable)
                    % Dataen plottes via vores gradesPlots, input En N � M
                    % matrix (n�rmere beskrevet i gradesPlot funktionen)
                    gradesPlot(gradesOnly);
                else
                    answer=questdlg('Indl�s data','hvad laver du?','OK','OK');
                    % H�ndterer answer
                    switch answer
                        case 'OK'
                    end
                end
                
            case '4. Vis karakterliste.'
                if ~isempty(gradeTable)
                    gradesFinal = computeFinalGrades(gradesOnly);
                    % Tilf�jer gradesFinal til den endelige karakterliste
                    liste = addvars(gradeTable,gradesFinal);
                    % Soterer i alfabetisk orden
                    disp(sortrows(liste,2));
                else
                    answer=questdlg('Indl�s data','hvad laver du?','OK','OK');
                    % H�ndterer answer
                    switch answer
                        case 'OK'
                    end
                end
            case '5. Afslut.'
                answer = questdlg('Er du sikker p� du vil afslutte? alt data vil blive tabt!',...
                    'Stop vent', ...
                    'Ja','Nej','Ja');
                % H�ndterer answer
                switch answer
                    case 'Ja'
                        % Alt lukkes og der clear og clc efter break
                        close all;
                        break;
                end
        end
    else % exit kryds
        answer = questdlg('Er du sikker p� du vil afslutte? alt data vil blive tabt!',...
            'Stop vent', ...
            'Ja','Nej','Ja');
        % H�ndterer answer
        switch answer
            case 'Ja'
                % Alt lukkes og der clear og clc efter break
                close all;
                break;
        end
    end
end
clear;
clc;

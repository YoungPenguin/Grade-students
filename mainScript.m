%% Hoved-script
%% MATLAB R2018a
%% Projekt 2: Eksamensprojekt
%% Program til karaktergivning af studerende
%
%              LÆS REDEEM!!!
%
% Dette er vores Hoved-script til projektet
%
% Vi clear og clc, når programmet afsluttes, udkommenter de 2 sidste linjer
% i hoved-scriptet hvis du ikke ønsker dette!
%
% Vi har udviklet de obligatoriske funktioner:
%% roundGrade
%% computeFinalGrades
%% gradesPlot
%
% Herudover har vi tilføjet et par funktioner for overskuelighedens skyld
%% dataLoad
%% errorCheck
%% infoFunktion
% mere info omkring disse følger.
%
% I dette hoved-script er der:
%
% Bruger-input: ja (se opgave formuleringe samt løbende kommentering)
% Skærm-output: ja (se opgave formuleringe samt løbende kommentering)
%
%% Initialiserer
% Lidt OCD, men nu er vi sikre på, at de starter tomme (lidt overkill)
gradeTable   = [];
gradesOnly   = [];
% itemlist bruges til hovemMenu
itemListNavn = {'1. Indlæs ny data.', '2. Check for datafejl.',...
    '3. Generer diagrammer.','4. Vis karakterliste.','5. Afslut.'};

% For ikke at blive stuck i et uendeligt loop, så tjekker vi om der er .csv
% filer tilstæde i working dir. Hvis det ikke er tilfældet afsluttes.
if ~isempty(dir('*csv'))
    % Liste over mulige gyldige filer
    dir('*csv');
    % Start på script der beder brugeren om at indlæse en fil via prompt
    filename = input('\nIntast et gyldigt filnavn? ', 's');
    while ~isfile(filename)
        errordlg('Vælg en gyldig fil','Ugyldig fil');
        dir('*csv');
        filename = input('\nIntast et gyldigt filnavn? ', 's');
    end
else
    % hvis der ikke findes nogle .csv filer i dit working directory
    fprintf(2,'\nDer blev ikke fundet nogle gyldige filer i dit working directory\n');
    clear;
    return;
end
% dataLoad benyttes til at indlæse filen (mere info læses i dataLoad)
gradeTable  = dataLoad(filename);
% Laver en matrix som krævet til det korrekte input
gradesOnly = gradeTable{:,3:end};

% Hvis filen er tom/fyldt?
if ~isempty(gradeTable)
    % Antal studerende, hvor mange opgaver samt klasseGennemsnit.
    infoFunktion(gradesOnly);
else
    % Hvis det er en tom fil
    disp('Den valgte fil er tom');
end

% Når den ønskede fil er indtastet (som ikke er tom), visses hovemenuen.
%% menu start
while true
    hovedMenu = menu('Hovedmenu','1. Indlæs ny data.', '2. Check for datafejl.',...
        '3. Generer diagrammer.','4. Vis karakterliste.','5. Afslut.');
    % For at håndtere det røde kryds laves et if-statement. Det er lavet sådan, for at gøre
    % koden overskuelig og læsebar. Dette er lavet istedet for case 0, hvis ikke ithemList anvendes.
    if hovedMenu ~= 0
        switch itemListNavn{hovedMenu}
            case '1. Indlæs ny data.'
                % uigetfile load af fil. Giver kun adgang til .csv filer
                [filename,path] = uigetfile('*csv');
                if isequal(filename,0)
                    % Ugyldig fil
                    errordlg('Vælg en gyldig fil','Ugyldig fil');
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
                    answer = questdlg('Hvor ønsker du at tjeke for datafejl?',...
                        'wut are you doin', ...
                        'data-fil','karakterliste','data-fil');
                    % Håndterer answer
                    switch answer
                        case 'data-fil'
                            errorCheck(gradeTable);
                            disp('Data-filen er blevet tjeket for fejl');
                        case 'karakterliste'
                            errorCheck(sortrows(gradeTable,2));
                            disp('Karakterlisten er blevet tjeket for fejl');
                    end
                else
                    % Håndterer answer
                    answer = questdlg('Indlæs data','hvad laver du?','OK','OK');
                    switch answer
                        case 'OK'
                    end
                end
                
            case '3. Generer diagrammer.'
                if ~isempty(gradeTable)
                    % Dataen plottes via vores gradesPlots, input En N × M
                    % matrix (nærmere beskrevet i gradesPlot funktionen)
                    gradesPlot(gradesOnly);
                else
                    answer=questdlg('Indlæs data','hvad laver du?','OK','OK');
                    % Håndterer answer
                    switch answer
                        case 'OK'
                    end
                end
                
            case '4. Vis karakterliste.'
                if ~isempty(gradeTable)
                    gradesFinal = computeFinalGrades(gradesOnly);
                    % Tilføjer gradesFinal til den endelige karakterliste
                    liste = addvars(gradeTable,gradesFinal);
                    % Soterer i alfabetisk orden
                    disp(sortrows(liste,2));
                else
                    answer=questdlg('Indlæs data','hvad laver du?','OK','OK');
                    % Håndterer answer
                    switch answer
                        case 'OK'
                    end
                end
            case '5. Afslut.'
                answer = questdlg('Er du sikker på du vil afslutte? alt data vil blive tabt!',...
                    'Stop vent', ...
                    'Ja','Nej','Ja');
                % Håndterer answer
                switch answer
                    case 'Ja'
                        % Alt lukkes og der clear og clc efter break
                        close all;
                        break;
                end
        end
    else % exit kryds
        answer = questdlg('Er du sikker på du vil afslutte? alt data vil blive tabt!',...
            'Stop vent', ...
            'Ja','Nej','Ja');
        % Håndterer answer
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

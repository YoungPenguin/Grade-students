function gradesPlot(grades)
%
% Input argumenter: grades: En N × M matrix som indeholder karakterer
%                           givet til N studerende for M opgaver.
%
% Output argumenter: nej
%
% Bruger-input: nej
%
% Skærm-output: ja diagrammer (figure), som specificeret i opgaveformuleringen.
%

% gradesFinal skal benyttes til bar diagrammet
gradesFinal = computeFinalGrades(grades);
%% Bar-diagram
figure(1); clf;
% Vi resizer vinduet til en passende størrelse
set(gcf,'Position',[300,150,1200,600]);
subplot(1,2,1);
% Bar-diagrammet bliver lavet via histogram ved at kategorisere gradesFinal.
% "categorical" er brugt, da dette er den mest effektive løsning (testet med
% tic - toc)
C = categorical(gradesFinal, [-3 0 2 4 7 10 12],...
    {'-3','00','02','4','7','10','12'});
histogram(C,'BarWidth',0.5)
xlabel('Grades');
% Den øvre grænse er den højeste antal af en karakter, som er i uniqueNdx
[~,~,uniqueNdx] = unique(C);
yticks(0:max(uniqueNdx));
ylabel('Quantity');
title('Final grades');

%% Plot 2
subplot(1,2,2);

% Offset-værdier til forskydningen
offset_min    = -0.1;
offset_max    = 0.1;

% Random offset matrix
offset_matrix1 = (offset_max-offset_min).*rand(size(grades)) + offset_min;
offset_matrix2 = (offset_max-offset_min).*rand(size(grades)) + offset_min;

% Matrix til assignments (x koordinatet)
Assignments   = repmat(1:size(grades,2),size(grades,1),1);

% Plotter data: offset matrixen bliver adderede til hhv. Assignments og grades
hold on
plot(Assignments + offset_matrix1, grades + offset_matrix2,'*');

% For at undgå fejl ved kun 1 opgave, plottes gennemsnitslinjen for hver opgave,
for i = 1:size(grades,2)
    line([i-0.5,i+0.5],[nanmean(grades(:,i),1),nanmean(grades(:,i),1)]);
end
% Titler på plot og akser
title('Grades per assignment');
xlabel('Assignments')
ylabel('Grades')
% Akse limits bliver +- 0.5 for at sikre at punkter ikke ligger på selve aksen
xlim([0.5, size(Assignments,2)+0.5]);
xticks(0:max(Assignments(:)));
% Opdeler y-aksen efter karaktererne, samt outliers. unique tilføjes så
% der ikke kommer problemer, hvis max eller min er en værdi i arrayet.
ylim([min(grades(:))-0.5, max(grades(:))+0.5]);
yticks(unique([min(grades(:)) -3 0 2 4 7 10 12 max(grades(:))]));
end

function [filename1,filename2] = save_files(I,J)
    if ~exist('output', 'dir')
        mkdir('output');
    end
    fig1 = figure('visible','off');
    imshow(I);
    fig2 = figure('visible','off');
    imshow(J);
    folder = 'output\';
    timestamp = datestr(now, 'yyyy-mm-dd--HH-MM-ss');
    filename1=['Initial--',timestamp];
    saveas(fig1, fullfile(folder, filename1), 'png');
    filename2=['Selection--',timestamp];
    saveas(fig2, fullfile(folder, filename2), 'png');
end


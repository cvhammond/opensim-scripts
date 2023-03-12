% This function makes a .mot file from the input values below. 
%
% Instructions should have the following format:
% instructions{item_num} = {coordinate_name, coordinate_value, time}
% I.E.
% instructions{1} = {'r_elbow_flex', 0, 0}
% instructions{2} = {'r_elbow_flex', 130, 2}
% and the .mot file will linear interpolate over the time period.
%
% (string, Cell Array, number) -> (None)
% Save motion file to outfile
function MakeMot(outfile, instructions, dataRate)

fileID = fopen(outfile, 'w');
motion = makeHeader(outfile, dataRate, instructions);
[names, columns] = makeColumns(instructions, dataRate);
motion = [motion names newline];
for i=1:length(columns{1})
    row = '';
    for j=1:length(columns)
        row = [row num2str(columns{j}(i)) char(9)];
    end
    motion = [motion row newline];
end
fprintf(fileID,'%s',motion);



end
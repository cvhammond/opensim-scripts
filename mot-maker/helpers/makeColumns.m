function [names, columns] = makeColumns(instructions, dataRate)
names = ['time'];
latestTime = getLatestTime(instructions);
columns{1} = linspace(0, latestTime, latestTime*dataRate);
uniqueCoords = getUniqueCoords(instructions);
for i=1:length(uniqueCoords)
    names = [names char(9) uniqueCoords{i}]; 
    coordInstructions = getInstructionsByCoordinateName(instructions, ...
        uniqueCoords{i});
    sortedInstructions = sortInstructions(coordInstructions);
    sortedInstructions = addStartAndFinish(sortedInstructions, latestTime);
    columns{i+1} = makeColumn(sortedInstructions, dataRate);
end
end

function coordInstr = getInstructionsByCoordinateName(instructions, coord)
coordInstr = {};
    for j=1:length(instructions)
        if(strcmp(instructions{j}{1},coord))
            coordInstr{length(coordInstr)+1} = instructions{j};
        end
    end
end

function sortedInstructions = sortInstructions(coordInstructions)
nList = cellfun(@(x)x{3}, coordInstructions);
[~, sortIdx] = sort(nList);
sortedInstructions = coordInstructions(sortIdx);
end

function sortedInstructions = addStartAndFinish(instructions, latestTime)
if(instructions{1}{3} ~= 0)
    sortedInstructions = [{{instructions{1}{1}, instructions{1}{2}, ...
        0}}, instructions];
else
    sortedInstructions = instructions;
end
if(instructions{length(instructions)}{3} ~= latestTime)
    sortedInstructions{length(sortedInstructions)+1} = ...
        {instructions{1}{1}, instructions{length(instructions)}{2}, ...
        latestTime};
end
end

function column = makeColumn(instructions, dataRate)
column = [];
for i=2:length(instructions)
    numPoints = (instructions{i}{3} - instructions{i-1}{3}) * dataRate;
    column = [column linspace(instructions{i-1}{2}, instructions{i}{2}, ...
        numPoints)];
end
end
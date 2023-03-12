function uniqueCoords = getUniqueCoords(instructions)
uniqueCoords{1} = instructions{1}{1};
for i=2:length(instructions)
    presentInUnique = false;
    for j=1:length(uniqueCoords)
        if(strcmp(instructions{i}{1},uniqueCoords{j}))
            presentInUnique = true;
        end
    end
    if(~presentInUnique)
        uniqueCoords{length(uniqueCoords)+1} = instructions{i}{1};
    end
end
end
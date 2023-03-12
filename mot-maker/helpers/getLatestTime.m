function latest = getLatestTime(instructions)
latest = 0;
for i=1:length(instructions)
    if(instructions{i}{3} > latest)
        latest = instructions{i}{3};
    end
end
end
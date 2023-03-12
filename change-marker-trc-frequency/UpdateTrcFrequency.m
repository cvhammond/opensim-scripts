% This function takes the marker data in a .trc file and applies interp1 to
% the data to get out the new desired frequency.
%
%
%
%
function UpdateTrcFrequency(markerFileName, outputFileName, newFrequency)
import org.opensim.modeling.*
markers = TimeSeriesTableVec3(markerFileName); %import marker file
time = getTimeAsArray(markers.getIndependentColumn()); % get time array
numElements = floor((time(length(time)) - time(1)) * newFrequency);
newTime = linspace(time(1), time(length(time)), numElements);%new time vals
output = TimeSeriesTableVec3(markerFileName); %import input for output
updateOutputRows(output, numElements); % modify number of rows
updateOutputTime(output, newTime); % modify time column
for i=0:markers.getColumnLabels().size()-1
    column = markers.getDependentColumnAtIndex(i);
    [x,y,z] = interpolateXYZ(column, time, newTime);
    outputColumn = output.updDependentColumnAtIndex(i);
    for j=0:outputColumn.size()-1
        outputColumn.set(j, Vec3(x(j+1), y(j+1), z(j+1)))
    end
end
trcFileAdapter = TRCFileAdapter();
trcFileAdapter.write(output, outputFileName)
end

function timeArray = getTimeAsArray(time)
for i=0:time.size()-1
    timeArray(i+1) = time.get(i);
end
end

function updateOutputRows(output, numElements)
while(output.getNumRows() ~= numElements)
    if(output.getNumRows() < numElements)
        output.appendRow(0, output.getRowAtIndex(0))
    else
        output.removeRowAtIndex(0)
    end
end
end

function updateOutputTime(output, newTime)
for i=0:length(newTime)-1
    output.setIndependentValueAtIndex(i,newTime(i+1))
end
end

function [x, y, z] = interpolateXYZ(column, time, newTime)
    for j=0:column.size()-1
        x(j+1) = column.get(j).get(0);
        y(j+1) = column.get(j).get(1);
        z(j+1) = column.get(j).get(2);
    end
    x = interp1(time, x, newTime);
    y = interp1(time, y, newTime);
    z = interp1(time, z, newTime);
end
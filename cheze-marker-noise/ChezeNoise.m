% This function applies the Cheze noise as described in the paper:
%
% Chèze, L.†, Fregly, B.J., and Dimnet, J. (1998) Determination of joint
% functional axes from noisy marker data using the finite helical axis.
% Human Movement Science 17, 1-15.

% (string, string) -> (None)

function ChezeNoise(markerFileName,outputFileName)
import org.opensim.modeling.*
markers = Storage(markerFileName); %import markers
fn = makeRandomChezeNoiseFunction();
time = ArrayDouble();
markers.getTimeColumn(time);
output = Storage(markerFileName); %make output storage from input

for i=0:markers.getColumnLabels().size()-2
    dblArray = ArrayDouble();
    markers.getDataColumn(0, dblArray);
    applyChezeFunctionToColumn(fn, time, dblArray);
    output.setDataColumn(i,dblArray)
end
output.print(outputFileName);
end

function applyChezeFunctionToColumn(fn, time, column)
for i=0:column.getSize()-1
    column.set(i, fn(time.get(i), column.get(i)))
end
end
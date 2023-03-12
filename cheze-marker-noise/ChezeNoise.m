% This function applies the Cheze noise to a .trc marker file as described
% in the paper:
%
% Chèze, L.†, Fregly, B.J., and Dimnet, J. (1998) Determination of joint
% functional axes from noisy marker data using the finite helical axis.
% Human Movement Science 17, 1-15.
%
% (string, string) -> (None)

function ChezeNoise(markerFileName, outputFileName)
import org.opensim.modeling.*
markers = TimeSeriesTableVec3(markerFileName); %import markers
fn = makeRandomChezeNoiseFunction();
time = markers.getIndependentColumn();
output = TimeSeriesTableVec3(markerFileName); %make output storage from input
for i=0:markers.getColumnLabels().size()-1
    column = output.updDependentColumnAtIndex(i);
    applyChezeFunctionToColumn(fn, time, column);
end
trcFileAdapter = TRCFileAdapter();
trcFileAdapter.write(output, outputFileName)
end

function applyChezeFunctionToColumn(fn, time, column)
import org.opensim.modeling.*
for i=0:column.size()-1
    x = fn(time.get(i), column.get(i).get(0));
    y = fn(time.get(i), column.get(i).get(1));
    z = fn(time.get(i), column.get(i).get(2));
    column.set(i, Vec3(x,y,z))
end
end
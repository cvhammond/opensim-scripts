% This function creates a Cheze noise function with random values for noise
% parameters (see published paper for specifics)

% (None) -> (Function Handle)
% Returns a randomly generated Cheze noise function
function fn = makeRandomChezeNoiseFunction()
amplitude = 0.02 * rand() - 0.01; %random value between [-0.01,0.01] meter
frequency = 25 * rand(); %random value between [0, 25] radians/sec
phaseAngle = 2 * pi * rand(); %random value between [0, 2pi] radians
amplitude, frequency, phaseAngle
fn = @(time,value)value + amplitude*sin(frequency*time + phaseAngle);
end

% f(t) = A * sin(frequency*t + phase)


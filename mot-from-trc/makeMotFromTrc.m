function makeMotFromTrc(model, trcFileName, motFileName)
import org.opensim.modeling.*
model = Model(model);
IKTool = InverseKinematicsTool();
IKTool.setModel(model);
IKTool.setMarkerDataFileName(trcFileName);
IKTool.setOutputMotionFileName(motFileName);
IKTool.run();
end


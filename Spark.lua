-- Spark Module 10/3/2024
-- Eli 

local Spark = {}

--- Emit particles from a ParticleEmitter.
-- @param Emitter ParticleEmitter The emitter instance that emits particles.
-- @return ParticleEmitter|nil The emitter instance if successful, or nil if invalid.

function Spark:EmitFunction(Emitter: ParticleEmitter): ParticleEmitter | nil
	assert(typeof(Emitter) == "Instance" and Emitter:IsA("ParticleEmitter"), "Emitter must be a ParticleEmitter")

	-- Attributes for controlling the emitter
	local EmitCount = Emitter:GetAttribute("EmitCount")
	local EmitDelay = Emitter:GetAttribute("EmitDelay")
	local EmitDuration = Emitter:GetAttribute('EmitDuration')

	-- Default EmitCount if none or less than 1
	if not EmitCount or EmitCount < 1 then
		EmitCount = 1
	end

	-- Emit particles after the specified delay
	task.delay(EmitDelay, function()
		if EmitDuration and EmitDuration > 0 then
			local startTime = os.clock()
			while os.clock() - startTime < EmitDuration do
				Emitter:Emit(EmitCount)
				wait(1 / Emitter.Rate)
			end
		else
			Emitter:Emit(EmitCount or Emitter.Rate)
		end
	end)

	return Emitter
end

--- Enable a Beam instance.
-- @param Beam Beam The beam instance to enable.
-- @return Beam|nil The beam instance if successful, or nil if invalid.

function Spark:EnableBeam(Beam: Beam): Beam | nil
	assert(typeof(Beam) == "Instance" and Beam:IsA("Beam"), "Beam must be a Beam")

	-- Attributes for controlling the beam
	local BeamDuration = Beam:GetAttribute("EmitDuration")
	local BeamDelay = Beam:GetAttribute("EmitDelay")

	-- Enable beam after specified delay
	task.delay(BeamDelay or 0, function()
		Beam.Enabled = true
		if BeamDuration and BeamDuration > 0 then
			task.delay(BeamDuration, function()
				Beam.Enabled = false
			end)
		end
	end)

	return Beam
end

--- Emit particles from various emitters attached to an instance.
-- @param VFXAttachment Instance The instance containing ParticleEmitters or Beams.
-- @return nil


function Spark:EmitParticles(VFXAttachment: Instance): nil
	if VFXAttachment:IsA("ParticleEmitter") then
		self:EmitFunction(VFXAttachment)
		return
	elseif VFXAttachment:IsA("Beam") then
		self:EnableBeam(VFXAttachment)
		return
	end

	-- Iterate through children and call appropriate function
	for _, Emitter in ipairs(VFXAttachment:GetChildren()) do
		if Emitter:IsA('ParticleEmitter') then
			self:EmitFunction(Emitter)
		elseif Emitter:IsA('Beam') then
			self:EnableBeam(Emitter)
		else
			Spark:EmitParticles(Emitter)
		end
	end

	return nil
end

return Spark
local Spark = {}

--- Emit particles from a ParticleEmitter.
-- @param Emitter ParticleEmitter - The emitter to use.
-- @return ParticleEmitter|nil - The emitter if successful.
function Spark.EmitFromEmitter(Emitter: ParticleEmitter): ParticleEmitter | nil
	assert(typeof(Emitter) == "Instance" and Emitter:IsA("ParticleEmitter"), "Emitter must be a ParticleEmitter")

	local Count = Emitter:GetAttribute("EmitCount") or 1
	local DelayTime = Emitter:GetAttribute("EmitDelay") or 0
	local Duration = Emitter:GetAttribute("EmitDuration") or 0

	-- Cancellation flag to allow stopping the emission.
	Emitter._CancelEmission = false

	task.delay(DelayTime, function()
		if Duration > 0 then
			local StartTime = tick()
			while tick() - StartTime < Duration and not Emitter._CancelEmission do
				local Success, Err = pcall(function()
					Emitter:Emit(Count)
				end)
				if not Success then
					warn("Error emitting particles:", Err)
				end
				task.wait(1 / Emitter.Rate)
			end
		else
			pcall(function()
				Emitter:Emit(Count)
			end)
		end
	end)

	return Emitter
end

--- Cancel emission for a ParticleEmitter.
-- @param Emitter ParticleEmitter - The emitter to cancel.
function Spark.CancelEmission(Emitter: ParticleEmitter)
	assert(typeof(Emitter) == "Instance" and Emitter:IsA("ParticleEmitter"), "Emitter must be a ParticleEmitter")
	Emitter._CancelEmission = true
end

--- Activate a Beam.
-- @param Beam Beam - The beam instance to activate.
-- @return Beam|nil - The beam if successful.
function Spark.ActivateBeam(Beam: Beam): Beam | nil
	assert(typeof(Beam) == "Instance" and Beam:IsA("Beam"), "Beam must be a Beam")

	local Duration = Beam:GetAttribute("EmitDuration") or 0
	local DelayTime = Beam:GetAttribute("EmitDelay") or 0

	Beam._CancelEmission = false

	task.delay(DelayTime, function()
		Beam.Enabled = true
		if Duration > 0 then
			task.delay(Duration, function()
				if not Beam._CancelEmission then
					Beam.Enabled = false
				end
			end)
		end
	end)

	return Beam
end

--- Cancel beam activation.
-- @param Beam Beam - The beam instance to cancel.
function Spark.CancelBeam(Beam: Beam)
	assert(typeof(Beam) == "Instance" and Beam:IsA("Beam"), "Beam must be a Beam")
	Beam._CancelEmission = true
	Beam.Enabled = false
end

--- Process an instance for ParticleEmitters or Beams.
-- @param Attachment Instance - The instance containing VFX components.
function Spark.ProcessVFXAttachment(Attachment: Instance): nil
	if Attachment:IsA("ParticleEmitter") then
		Spark.EmitFromEmitter(Attachment)
	elseif Attachment:IsA("Beam") then
		Spark.ActivateBeam(Attachment)
	else
		for _, Child in ipairs(Attachment:GetChildren()) do
			Spark.ProcessVFXAttachment(Child)
		end
	end
	return nil
end

return Spark

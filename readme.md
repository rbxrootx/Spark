# Spark Module

This module allows developers to easily control particle and beam effects in Roblox with customizable attributes for emission, delay, and duration.

## Features

- Emit particles from ParticleEmitter instances with customizable emit count, delay, and duration
- Activate and control Beam effects with specified durations and delays
- Cancel ongoing particle emissions or beam activations
- Recursively process complex attachment hierarchies containing multiple ParticleEmitters or Beams

## Installation

1. Copy the `Spark.lua` file to your Roblox project.
2. Require the module in your script:
   ```lua
   local Spark = require(path.to.Spark)
   ```

## Usage

### Emitting Particles

To emit particles from a ParticleEmitter:

```lua
local emitter = workspace.ParticleEmitterInstance -- Replace with your ParticleEmitter instance
Spark.EmitFromEmitter(emitter)
```

To cancel an ongoing particle emission:

```lua
Spark.CancelEmission(emitter)
```

### Activating Beams

To activate a Beam instance:

```lua
local beam = workspace.BeamInstance -- Replace with your Beam instance
Spark.ActivateBeam(beam)
```

To cancel an active beam:

```lua
Spark.CancelBeam(beam)
```

### Processing VFX Attachments

You can process an entire instance and its children for any ParticleEmitters or Beams:

```lua
local attachment = workspace.VFXAttachment -- Replace with your attachment containing ParticleEmitters or Beams
Spark.ProcessVFXAttachment(attachment)
```

## Attributes

The Spark Module uses specific attributes to control the behavior of ParticleEmitters and Beams:

### ParticleEmitter Attributes
- `EmitCount` (number): The number of particles to emit per cycle (defaults to 1)
- `EmitDelay` (number): Delay in seconds before emitting particles (defaults to 0)
- `EmitDuration` (number): Duration in seconds for which the particles should be emitted (defaults to 0)

### Beam Attributes
- `EmitDelay` (number): Delay in seconds before enabling the beam (defaults to 0)
- `EmitDuration` (number): Duration in seconds for which the beam should be enabled (defaults to 0)

## Examples

### Example 1: Emit Particles with Custom Attributes

```lua
local emitter = workspace.ParticleEmitterInstance
emitter:SetAttribute("EmitCount", 10)
emitter:SetAttribute("EmitDelay", 2)
emitter:SetAttribute("EmitDuration", 5)
Spark.EmitFromEmitter(emitter)
```

This will emit 10 particles after a delay of 2 seconds, for a duration of 5 seconds.

### Example 2: Activate Beam with Delay and Duration

```lua
local beam = workspace.BeamInstance
beam:SetAttribute("EmitDelay", 1)
beam:SetAttribute("EmitDuration", 3)
Spark.ActivateBeam(beam)
```

This will enable the beam after 1 second and disable it after 3 seconds.

### Example 3: Process an Attachment Hierarchy

```lua
local vfxModel = workspace.VFXModel -- A model containing multiple attachments with particle effects and beams
Spark.ProcessVFXAttachment(vfxModel)
```

This will recursively find and activate all ParticleEmitters and Beams within the model.

## API Reference

### Spark.EmitFromEmitter(Emitter: ParticleEmitter): ParticleEmitter | nil
Emits particles from a ParticleEmitter based on its attributes.
- `Emitter`: The ParticleEmitter instance to emit particles from
- Returns: The emitter if successful, nil otherwise

### Spark.CancelEmission(Emitter: ParticleEmitter)
Cancels an ongoing particle emission.
- `Emitter`: The ParticleEmitter instance to cancel emission for

### Spark.ActivateBeam(Beam: Beam): Beam | nil
Activates a Beam based on its attributes.
- `Beam`: The Beam instance to activate
- Returns: The beam if successful, nil otherwise

### Spark.CancelBeam(Beam: Beam)
Cancels an active beam and disables it.
- `Beam`: The Beam instance to cancel

### Spark.ProcessVFXAttachment(Attachment: Instance): nil
Recursively processes an instance for ParticleEmitters and Beams.
- `Attachment`: The instance to process

## License

This project is licensed under the MIT License.

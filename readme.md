# Spark Module

This module allows developers to play dynamic particle and beam effects with custom attributes for emission, delay, and duration.

## Features

- Emit particles from ParticleEmitter instances with customizable emit count, delay, and duration.
- Enable and control Beam effects with specified durations and delays.
- Recursive handling of effects for complex attachment hierarchies containing multiple ParticleEmitters or Beams.

## Installation

1. Copy the `Spark.lua` file to your Roblox project.
2. Require the module in your script:

   ```lua
   local Spark = require(path.to.Spark)
   ```

## Usage

### Emit Particles

To emit particles from a ParticleEmitter:

```lua
local emitter = workspace.ParticleEmitterInstance -- Replace with your ParticleEmitter instance
Spark:EmitFunction(emitter)
```

### Enable Beam

To enable a Beam instance:

```lua
local beam = workspace.BeamInstance -- Replace with your Beam instance
Spark:EnableBeam(beam)
```

### Emit Particles or Enable Beams from Attachments

You can also emit particles or enable beams for all ParticleEmitters or Beams attached to an instance:

```lua
local attachment = workspace.VFXAttachment -- Replace with your attachment containing ParticleEmitters or Beams
Spark:EmitParticles(attachment)
```

## Attributes

The Spark Module relies on specific attributes to control the behavior of ParticleEmitters and Beams:

- `EmitCount` (number): The number of particles to emit per cycle.
- `EmitDelay` (number): Delay (in seconds) before emitting particles or enabling beams.
- `EmitDuration` (number): Duration (in seconds) for which the particles should be emitted or the beam should be enabled.

## Examples

### Example 1: Emit Particles with Custom Attributes

```lua
local emitter = workspace.ParticleEmitterInstance
emitter:SetAttribute("EmitCount", 10)
emitter:SetAttribute("EmitDelay", 2)
emitter:SetAttribute("EmitDuration", 5)

Spark:EmitFunction(emitter)
```

This will emit 10 particles after a delay of 2 seconds, for a duration of 5 seconds.

### Example 2: Enable Beam with Delay and Duration

```lua
local beam = workspace.BeamInstance
beam:SetAttribute("EmitDelay", 1)
beam:SetAttribute("EmitDuration", 3)

Spark:EnableBeam(beam)
```

This will enable the beam after 1 second and disable it after 3 seconds.

## License

This project is licensed under the MIT License.


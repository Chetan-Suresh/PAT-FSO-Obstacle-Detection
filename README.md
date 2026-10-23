# PAT-Enabled Free-Space Optical Audio Link with Obstacle Detection

This project explores wireless audio transmission using a free-space optical (FSO) link. Instead of relying on a physical audio cable between the transmitter and receiver, the system uses a laser beam to carry the audio signal through free space.

The setup combines audio transmission and reception with a pan-and-tilt (PAT) mechanism and ultrasonic obstacle detection. The goal is to maintain an optical path between the transmitter and receiver and automatically interrupt audio transmission when an obstacle is detected.

The repository includes the project report, hardware photographs, component list, and embedded firmware for pan-and-tilt control and obstacle detection.

## How It Works

### 1. Free-Space Optical Audio Transmission

The audio signal is processed by the transmitter circuitry and used to modulate a laser. The light beam carries the signal through free space to the receiving end.

A photodiode or solar-panel-based receiver converts the incoming light back into an electrical signal, which is processed by the receiving circuitry to recover the audio for playback.

### 2. Pan-and-Tilt Control

The pan-and-tilt mechanism uses two servo motors to adjust the direction of the transmitter.

The included `firmware.PAT` program accepts serial commands to control the pan and tilt angles. It limits the requested angles to the range of 0–180 degrees and moves the servos gradually toward their target positions.

### 3. Ultrasonic Obstacle Detection

The `firmware.OD` program uses an HC-SR04 ultrasonic sensor to measure the distance to nearby objects.

The current firmware uses a threshold of 120 cm:

- If an object is detected closer than 120 cm, the amplifier control output is set LOW.
- If the measured distance is 120 cm or greater, the output is set HIGH again.

This output controls the amplifier's shutdown pin, providing a basic way to interrupt audio transmission when an obstacle is detected.

## Hardware Components

The component list in `hardware.txt` includes:

- MAX4466 microphone module
- Audio amplifier module
- Arduino or ESP32-based microcontroller boards
- Laser diode
- Photodiode or solar-panel receiver
- Servo motors for pan-and-tilt movement
- HC-SR04 ultrasonic distance sensor
- Joystick module
- LM2596 DC-DC buck converters
- 100 kΩ potentiometer
- Speaker

Refer to [`hardware.txt`](hardware.txt) and [`PAT_FSO_OD.pdf`](PAT_FSO_OD.pdf) for the project component list and further details.

## Repository Contents

| File | Description |
|---|---|
| `firmware.PAT` | Serial-controlled pan-and-tilt servo firmware |
| `firmware.OD` | Ultrasonic obstacle detection and amplifier control firmware |
| `hardware.txt` | Hardware components and a brief system explanation |
| `PAT_FSO_OD.pdf` | Project report |
| `transmitter.jfif` | Transmitter hardware photograph |
| `receiver.jfif` | Receiver hardware photograph |

## Getting Started

### Requirements

- Arduino IDE or another compatible embedded development environment
- A compatible microcontroller board
- Servo library support for the pan-and-tilt program
- The required sensors, servos, audio circuitry, and supporting components

### Preparing the Firmware

The source files currently use the extensions `.PAT` and `.OD`, rather than the usual `.ino` extension used by Arduino sketches.

To work with them in the Arduino IDE, create two separate sketch folders and copy the contents of each file into a corresponding `.ino` file.

For example:

```text
PAT_Controller/
└── PAT_Controller.ino

Obstacle_Detection/
└── Obstacle_Detection.ino
```

Select the correct board and port before compiling and uploading each sketch. The two programs are separate and should not be combined unchanged into a single sketch.

### Pan-and-Tilt Controller

The current firmware uses these pin assignments:

| Component | Pin |
|---|---|
| Pan servo | 9 |
| Tilt servo | 10 |

Open the Serial Monitor at **9600 baud** and send a command using the following format:

```text
P120
T45
```

`P` sets the pan angle, and `T` sets the tilt angle. The program constrains the angle to the range of 0–180 degrees and uses a gradual movement function.

### Obstacle-Detection Controller

The current firmware uses the following pins:

| Component | Pin |
|---|---|
| HC-SR04 trigger | 9 |
| HC-SR04 echo | 10 |
| Amplifier shutdown control | 11 |

The program repeatedly measures the distance and compares it with the 120 cm threshold. Check your actual wiring and amplifier shutdown logic before powering the circuit.

## Implementation Notes

The committed pan-and-tilt firmware currently provides serial-based manual angle control. The broader project description also discusses red-marker-based alignment, but that tracking functionality is not implemented in the two firmware files included here.

The obstacle-detection firmware implements the distance check and amplifier control described above. Other system behavior depends on the physical circuit and any additional controller code used in the complete setup.

## Safety

This project uses a laser and electronic hardware. Never point the laser toward anyone's eyes or at reflective surfaces. Keep the beam path controlled during testing, and verify the wiring, supply voltage, and component ratings before powering the circuit.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

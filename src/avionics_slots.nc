( ============================================================================ )
( CNC TOOLPATH: MULTI-LAYER AVIONICS CHASSIS SLIDER SLOTS ROUTINE             )
( CONFIGURATION: 0.093" STANDARD WIDTH TRACKING GROOVES / CLIMB MILLING RUN  )
( HARDWARE MATERIAL: TI-ALN COATED RUGGED CARBIDE TOOLING PATHS ON GR.5 ALLOY  )
( ============================================================================ )

G20 ( Enforce Inch Measurement Units Mode )
G90 G94 G17 ( Absolute Coordinates, Feed per Minute Mode, XY Machining Plane Selection )
G00 Z3.5 ( Rapid Traverse Clearance Z Lift to Safe Machine Clearance Height Plane )

( --- CNC MACHINE TOOL DEFINITION BLOCK --- )
( TOOL 14: 0.0625" TWO-FLUTE SOLID CARBIDE HIGH-PERFORMANCE SLOTTING ENDMILL    )
T14 M06 ( Execute Automated Mechanical Tool Change Sequence )
S3200 M03 ( Engage Spindle Drive: 3200 RPM Clockwise Rotational Direction )
M08 ( Engage High-Pressure Water-Soluble Flood Coolant Pump Flow )

( ============================================================================ )
( CARVING SLIDER SLOT TRACK LAYER 1: ALIGNED AT Y-OFFSET -2.000 INCHES         )
( ============================================================================ )
G00 X-7.250 Y-2.000 ( Rapid Drive to Left-Wall Target Infeed Coordinate Line )
G01 Z8.000 F15.0 ( Controlled Vertical Depth Entry Into Avionics Chassis Stock )

( Execute Left-Track Pass 1 )
G01 Z-8.000 F6.2 ( Precision Down-Feed Cut to Bottom Step Limit Wall )
G00 Z3.500 ( Rapid Vertical Lift Clear of Channel )

G00 X7.250 Y-2.000 ( Rapid Cross-Over Travel to Right-Wall Mirror Slot Target )
G01 Z8.000 F15.0 ( Enter Right-Wall Infeed Coordinate Matrix )
G01 Z-8.000 F6.2 ( Precision Down-Feed Cut to Bottom Step Limit Wall )
G00 Z3.500 ( Rapid Vertical Lift Clear of Channel )

( ============================================================================ )
( CARVING SLIDER SLOT TRACK LAYER 2: ALIGNED AT Y-OFFSET -0.750 INCHES         )
( ============================================================================ )
G00 X-7.250 Y-0.750 ( Move Tool Head to Parallel Slot Step 2 Target )
G01 Z8.000 F15.0
G01 Z-8.000 F6.2
G00 Z3.500

G00 X7.250 Y-0.750
G01 Z8.000 F15.0
G01 Z-8.000 F6.2
G00 Z3.500

( --- SYSTEM SHUTDOWN TERMINATION RUN CLEANUP --- )
M09 ( Disengage High-Pressure Coolant Flow Streams )
G00 Z3.500 M05 ( Rapid Height Extraction Z-Lift / Spindle Drive Motor Stop )
G28 G90 X0 Y0 Z0 ( Force Complete Gantry Return Loop back To Home Reference Ground Zero )
M30 ( Complete Memory Program End and Auto-Rewind Control File Index Loop )

( ============================================================================ )
( CNC TOOLPATH: ANTI-PINCH COUNTER-WEIGHTED SEAT SAFETY INTERLOCK GATES        )
( REPOSITORY FILENAME: src/interlock_gates.nc                                  )
( HARDWARE BASE: 5-AXIS GANTRY MILL / TI-ALN RUGGED SOLID CARBIDE PROFILE BIT  )
( COMPLIANCE: OSHA ANTI-REDUCTION PINCH POINT DIRECTIVE (ZERO-FASTENER DESIGN) )
( ============================================================================ )

G20 ( Enforce Inch Measurement Units Mode )
G90 G94 G17 ( Absolute Coordinates, Feed per Minute Mode, XY Machining Plane Selection )
G00 Z3.0 ( Rapid Traverse Clearance Z Lift to Safe Machine Clearance Plane Height )

( --- CNC MACHINE TOOL DEFINITION BLOCK --- )
( TOOL 09: 0.250" THREE-FLUTE COATED CARBIDE HIGH-PERFORMANCE ROUGHING ENDMILL  )
T09 M06 ( Execute Automated Mechanical Tool Change Sequence )
S2400 M03 ( Engage Spindle Drive: 2400 RPM Clockwise Rotational Direction )
M08 ( Engage High-Pressure Water-Soluble Flood Coolant Pump Flow Line )

( ============================================================================ )
( STAGE 1: MILLING THE LEFT INTERLOCK GATE WEDGE (PILOT SEAT LOCKOUT HUB)      )
( ============================================================================ )
G00 X14.000 Y39.500 ( Rapid Drive to Left-Side Mechanical Gate Axis Layout Center )
G00 Z0.100 ( Rapid Vertical Approach Drop to Safe Material Approach Plane )

G01 Z-0.062 F11.0 ( Plunge Cutter to Maximum Regulated Framework Depth Baseline )
G03 X16.000 Y39.500 I1.000 J0.0 F8.0 ( Trochoidal Swarf Entry Spiral Cut Pass )

( Carve out the 45-degree angle retention slope that traps the sliding hinge pin )
G01 X16.000 Y40.500 F14.0 ( Line Cut Up along Outer Bracket Shoulder )
G01 X14.000 Y38.500 F10.5 ( Angled Linear Interpolation Step - Cutting the Safe-Gate Wedge )
G01 X14.000 Y39.500 F14.0 ( Close Profile Base Boundary Loop Cut Line )

G00 Z3.000 ( Rapid Vertical Extraction Clear of Machined Left Safety Latch )

( ============================================================================ )
( STAGE 2: MILLING THE RIGHT INTERLOCK GATE WEDGE (CO-PILOT SEAT LOCKOUT HUB)   )
( ============================================================================ )
G00 X-14.000 Y39.500 ( Rapid Cross-Over Travel to Right-Side Mirror Gate Origin )
G00 Z0.100 ( Rapid Vertical Approach Drop to Safe Material Approach Plane )

G01 Z-0.062 F11.0 ( Engage Mill to Framing Floor Level )
G03 X-12.000 Y39.500 I1.000 J0.0 F8.0 ( Mirror Trochoidal Spiral Cut Pass )

G01 X-12.000 Y40.500 F14.0
G01 X-14.000 Y38.500 F10.5 ( Angled Linear Interpolation Step - Cutting Mirror Wedge )
G01 X-14.000 Y39.500 F14.0

( --- SYSTEM SHUTDOWN TERMINATION RUN CLEANUP --- )
M09 ( Disengage High-Pressure Coolant Flow Streams )
G00 Z3.000 M05 ( Rapid Height Extraction Z-Lift / Spindle Drive Motor Stop )
G28 G90 X0 Y0 Z0 ( Force Complete Gantry Return Loop back To Home Reference Ground Zero )
M30 ( Complete Memory Program End and Auto-Rewind Control File Index Loop )

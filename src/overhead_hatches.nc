( ============================================================================ )
( CNC TOOLPATH: DUAL OVERHEAD PORTAL CUTOUTS & PLUG DOOR FLANGE SEATS          )
( REPOSITORY FILENAME: src/overhead_hatches.nc                                 )
( HARDWARE baseline: 5-AXIS GANTRY ROUTER / TI-ALN RUGGED SOLID CARBIDE MILL   )
( CONFIGURATION: COMPRESSION HOUSING SHELF FOR DUAL 35.0 PSI ACDELCO SEALS    )
( ============================================================================ )

G20 ( Enforce Inch Measurement Units Mode )
G90 G94 G17 ( Absolute Coordinates, Feed per Minute Mode, XY Machining Plane Selection )
G00 Z4.5 ( Rapid Traverse Clearance Z Lift to Safe Machine Clearance Height Plane )

( --- CNC MACHINE TOOL DEFINITION BLOCK --- )
( TOOL 07: 0.375" FOUR-FLUTE SOLID CARBIDE HIGH-PERFORMANCE ROUGHING ENDMILL   )
T07 M06 ( Execute Automated Mechanical Tool Change Sequence )
S2200 M03 ( Engage Spindle Drive: 2200 RPM Clockwise Rotational Direction )
M08 ( Engage High-Pressure Water-Soluble Flood Coolant Pump Flow Line )

( ============================================================================ )
( STAGE 1: MILLING THE LEFT OVERHEAD CREW ENTRY PORT (PILOT SIDE PORTAL)       )
( ============================================================================ )
G00 X-22.000 Y-16.000 ( Rapid Drive to Left-Seat Hatch Corner Alignment Center Origin )
G00 Z0.100 ( Rapid Vertical Approach Drop to Safe Material Approach Plane )

G01 Z-0.062 F12.0 ( Plunge Cutter to Maximum Regulated Framework Depth Baseline )
G03 X-10.000 Y-16.000 I6.000 J0.0 F9.5 ( Climb Mill Along Bottom Flat Framing Edge Line )
G03 X-10.000 Y16.000 I0.0 J16.000 F9.5 ( Smooth 1.5-Inch Corner Fillet Radius Move )
G03 X-22.000 Y16.000 I-6.000 J0.0 F9.5 ( Clean Flat Top Margin Profile Structural Sweep )
G03 X-22.000 Y-16.000 I0.0 J-16.000 F9.5 ( Return Orbit Corner Fillet Path Arc Close )

( --- STEP 2: MILLING THE STEPPED FLANGE RECESSED SEAT FOR ACDELCO SEALS --- )
G01 Z-0.030 F10.0 ( Step Down to Precision Depth for Rubber Tracking Groove )
G03 X-22.500 Y-16.500 I0.0 J0.500 F7.0 ( Wider Concentric Counterbore Side Shaving Pass )

G00 Z4.500 ( Rapid Vertical Extraction Clear of Machined Left Hatch Port )

( ============================================================================ )
( STAGE 2: MILLING THE RIGHT OVERHEAD CREW ENTRY PORT (CO-PILOT SIDE PORTAL)   )
( ============================================================================ )
G00 X22.000 Y-16.000 ( Rapid Cross-Over Travel to Right-Seat Hatch Corner Origin )
G00 Z0.100 ( Rapid Vertical Approach Drop to Safe Material Approach Plane )

G01 Z-0.062 F12.0 ( Plunge Cutter to Maximum Regulated Framework Depth Baseline )
G03 X34.000 Y-16.000 I6.000 J0.0 F9.5 ( Climb Mill Along Bottom Flat Framing Edge Line )
G03 X34.000 Y16.000 I0.0 J16.000 F9.5 ( Smooth 1.5-Inch Corner Fillet Radius Move )
G03 X22.000 Y16.000 I-6.000 J0.0 F9.5 ( Clean Flat Top Margin Profile Structural Sweep )
G03 X22.000 Y-16.000 I0.0 J-16.000 F9.5 ( Return Orbit Corner Fillet Path Arc Close )

( --- STEP 2: MILLING THE STEPPED FLANGE RECESSED SEAT FOR ACDELCO SEALS --- )
G01 Z-0.030 F10.0
G03 X21.500 Y-16.500 I0.0 J0.500 F7.0

( --- SYSTEM SHUTDOWN TERMINATION RUN CLEANUP --- )
M09 ( Disengage High-Pressure Coolant Flow Streams )
G00 Z4.500 M05 ( Rapid Height Extraction Z-Lift / Spindle Drive Motor Stop )
G28 G90 X0 Y0 Z0 ( Force Complete Gantry Return Loop back To Home Reference Ground Zero )
M30 ( Complete Memory Program End and Auto-Rewind Control File Index Loop )

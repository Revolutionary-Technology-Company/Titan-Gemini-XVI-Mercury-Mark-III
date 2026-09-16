( ============================================================================ )
( CNC TOOLPATH: TWO-SEATER EXPANDED INSTRUMENT BULKHEAD FACEPLATE              )
( REPOSITORY FILENAME: src/dashboard_faceplate.nc                              )
( HARDWARE BASE: 5-AXIS GANTRY ROUTER / WATER-SOLUBLE FLOOD COOLANT HIGH-FEED  )
( COMPLIANCE: 0.062" FRAME SKELETON INTEGRATION CEILING (ZERO-BOLT FLANGE)     )
( ============================================================================ )

G20 ( Enforce Inch Measurement Units Mode )
G90 G94 G17 ( Absolute Coordinates, Feed per Minute Mode, XY Machining Plane Selection )
G00 Z3.5 ( Rapid Traverse Clearance Z Lift to Safe Machine Clearance Height Plane )

( --- CNC MACHINE TOOL DEFINITION BLOCK --- )
( TOOL 03: 0.500" FOUR-FLUTE ULTRA-HIGH-SPEED COATED SOLID CARBIDE ENDMILL     )
T03 M06 ( Execute Automated Mechanical Tool Change Sequence )
S2500 M03 ( Engage Spindle Drive: 2500 RPM Clockwise Rotational Direction )
M08 ( Engage High-Pressure Water-Soluble Flood Coolant Pump Line Flow )

( ============================================================================ )
( STAGE 1: MILLING OUT THE LEFT PILOT SIDE PANORAMIC DISPLAY CUTOUT             )
( ============================================================================ )
G00 X-14.500 Y1.000 ( Rapid Drive to Left-Seat Display Center Origin Reference Point )
G00 Z0.100 ( Rapid Vertical Approach Drop to Safe Material Approach Plane )

G01 Z-0.062 F12.0 ( Plunge Cutter to Maximum Regulated Framework Depth Baseline )
G03 X-5.500 Y1.000 I9.000 J0.0 F10.5 ( Clean Linear Direct Side Sweep - Cutting Top Edge )
G03 X-5.500 Y-4.000 I0.0 J-5.000 F8.0 ( Smooth 0.50-Inch Safety Corner Fillet Move )
G03 X-23.500 Y-4.000 I-9.000 J0.0 F10.5 ( Clean Flat Bottom Margin Profile Structural Sweep )
G03 X-23.500 Y1.000 I0.0 J5.000 F8.0 ( Return Orbit Corner Fillet Path Arc Close )

G00 Z3.500 ( Rapid Vertical Extraction Clear of Machined Left Display Window )

( ============================================================================ )
( STAGE 2: MILLING OUT THE RIGHT CO-PILOT SIDE PANORAMIC DISPLAY CUTOUT         )
( ============================================================================ )
G00 X14.500 Y1.000 ( Rapid Cross-Over Travel to Right-Seat Display Center Origin )
G00 Z0.100 ( Rapid Vertical Approach Drop to Safe Material Approach Plane )

G01 Z-0.062 F12.0 ( Engage Mill to Framing Floor Level )
G03 X23.500 Y1.000 I9.000 J0.0 F10.5 ( Clean Linear Direct Side Sweep - Cutting Top Edge )
G03 X23.500 Y-4.000 I0.0 J-5.000 F8.0 ( Smooth 0.50-Inch Safety Corner Fillet Move )
G03 X5.500 Y-4.000 I-9.000 J0.0 F10.5 ( Clean Flat Bottom Margin Profile Structural Sweep )
G03 X5.500 Y1.000 I0.0 J5.000 F8.0 ( Return Orbit Corner Fillet Path Arc Close )

G00 Z3.500 ( Rapid Vertical Extraction Clear of Machined Right Display Window )

( ============================================================================ )
( STAGE 3: MILLING OUT THE SHARED CENTER OVERRIDE TOGGLE BOX PORTAL           )
( ============================================================================ )
G00 X0.000 Y-4.500 ( Navigate to Dashboard Center Line Base Location )
G00 Z0.100 ( Drop to Safe Approach Plane )
G01 Z-0.062 F11.0 ( Re-engage Mill )
G01 X4.000 Y-4.500 F12.0
G01 X4.000 Y-2.500 F12.0
G01 X-4.000 Y-2.500 F12.0
G01 X-4.000 Y-4.500 F12.0
G01 X0.000 Y-4.500 F12.0 ( Close Central Mechanical Override Portal Box )

( --- SYSTEM SHUTDOWN TERMINATION RUN CLEANUP --- )
M09 ( Disengage High-Pressure Coolant Flow Streams )
G00 Z3.500 M05 ( Rapid Height Extraction Z-Lift / Spindle Drive Motor Stop )
G28 G90 X0 Y0 Z0 ( Force Complete Gantry Return Loop back To Home Reference Ground Zero )
M30 ( Complete Memory Program End and Auto-Rewind Control File Index Loop )

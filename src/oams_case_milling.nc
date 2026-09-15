( ============================================================================ )
( CNC TOOLPATH: OAMS THRUSTER SOLENOID DRIVER CIRCUIT PROTECTION CASING        )
( HARDWARE CONFIGURATION: 5-AXIS POCKET INTEGRATION LOOP PASS / GR.5 ALLOY    )
( OPERATION PROTOCOL: CLIMB MILLING ROTATIONAL PASS / HIGH-PRESSURE FLOOD      )
( ============================================================================ )

G20 ( Enforce Inch Measurement Units Mode )
G90 G94 G17 ( Absolute Coordinates, Feed per Minute Mode, XY Machining Plane Selection )
G00 Z3.0 ( Rapid Traverse Clearance Z Lift to Safe Machine Clearance Height Plane )

( --- CNC MACHINE TOOL DEFINITION BLOCK --- )
( TOOL 10: 0.375" THREE-FLUTE RUGGED CARBIDE HIGH-FEED ROUGHING ENDMILL        )
T10 M06 ( Execute Automated Mechanical Tool Change Sequence )
S2400 M03 ( Engage Spindle Drive: 2400 RPM Clockwise Rotational Direction )
M08 ( Engage High-Pressure Water-Soluble Flood Coolant System Pump Line Flow )

( --- POCKET DEEP EXCAVATION STEPPING CYCLE PASSES --- )
G00 X0.0 Y0.0 ( Rapid Core Approach Drive to Valve Housing Layout Center Origin )
G00 Z0.100 ( Rapid Vertical Approach Drop to Safe Material Approach Plane )

( Roughing Step-Down Pass 1 )
G01 Z-0.150 F12.5 ( Controlled Z-Axis Plunge Depth Insertion Into Block Matrix )
G03 X0.0 Y0.0 I0.1875 J0.0 F9.0 ( Helical Spiral Core Peeling Entry Wave Toolpath )
G01 X-4.000 Y-3.000 F16.0 ( Strip Out Left Corner Pocket Section )
G01 X4.000 Y-3.000
G01 X4.000 Y3.000
G01 X-4.000 Y3.000
G01 X-4.000 Y-3.000 ( Close Boundary Loop Initial Clean Path Box )

( Roughing Step-Down Pass 2 )
G01 Z-0.300 F12.5 ( Advance Pocket Mill Deeper Into Shielding Wall Stock )
G01 X-4.000 Y-3.000 F16.0
G01 X4.000 Y-3.000
G01 X4.000 Y3.000
G01 X-4.000 Y3.000
G01 X-4.000 Y-3.000

( --- FINAL COMPLIANCE SMOOTHING PERIMETER PASS --- )
G01 Z-0.350 F10.0 ( Reach Final Target Pocket Floor Thickness Baseline )
G03 X-4.000 Y-3.000 I0.0 J0.500 F7.5 ( Ultra-Precision Finishing Shaving Pass )
G00 Z3.000 F40.0 ( Rapid Safe Vertical Extraction Clear of Machined Casing Pockets )

( --- SYSTEM SHUTDOWN TERMINATION RUN CLEANUP --- )
M09 ( Disengage High-Pressure Coolant Flow Streams )
G00 Z3.000 M05 ( Rapid Height Extraction Z-Lift / Spindle Drive Motor Stop )
G28 G90 X0 Y0 Z0 ( Force Complete Gantry Return Loop back To Home Reference Ground Zero )
M30 ( Complete Memory Program End and Auto-Rewind Control File Index Loop )

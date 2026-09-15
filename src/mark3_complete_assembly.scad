// ============================================================================
// PROJECT: TITAN GEMINI XVI / MERCURY MARK III COMPLETE INTEGRATED ASSEMBLY
// REPOSITORY PATH: src/mark3_complete_assembly.scad
// CONFIGURATION: 120.0" FORGING BASE / TWO-SEATER INTEGRATED SKELETON
// COMPLIANCE: 0.062" CEILING FRAME SKELETON / ZERO MECHANICAL FASTENER PORTS
// ============================================================================

$fn = 180; // High resolution triangulation mesh for multi-axis CNC pathing

// --- MASTER DESIGN ARCHITECTURE VARIABLES (INCHES) ---
TITAN_BASE_OD = 120.0;       // Historical Titan core diameter (10 Feet)
CAPSULE_TOP_OD = 24.0;       // Apex Parachute Flange Diameter
TOTAL_HEIGHT = 135.0;         // Extended Conical Height of Capsule Can
FORGING_WALL = 1.50;         // DOC-Approved "Sewer Plate" heavy ring solid thickness
FRAME_MAX_CEILING = 0.062;   // Regulated "Mining Hat" internal rib thickness floor
SKIN_SHEET_THICK = 0.025;    // Stamped Titanium Shell Base Sheet
WINDOW_ARC_R = 38.5;         // Curvature profile for Fused Silica panes
NASA_PIN_R = 0.09375;        // Exact 3/16" pin profile matching standard wrenches
THRUSTER_R = 4.50;           // Bore scale for heavy electroacoustic vortex engines

// --- SECTION 1: MASTER BASE RING & SUPPORT MATRIX ---
module HeavyTitanBaseRing() {
    echo("CNC Toolpath: Turning 120-Inch Heavy Base Ring Forging; Wall =", FORGING_WALL);
    color("Silver")
    difference() {
        // Main solid stock ring blank
        cylinder(h = 4.0, r = TITAN_BASE_OD / 2, center = true);
        
        // Central borehole clearing interior cabin floor footprint
        translate([0, 0, -2.5])
        cylinder(h = 6.0, r = (TITAN_BASE_OD / 2) - FORGING_WALL);
        
        // Upper CNC Step Shoulder: Receiver shelf to flush-weld 0.025" skins
        translate([0, 0, 1.25])
        cylinder(h = 1.0, r = (TITAN_BASE_OD / 2) - SKIN_SHEET_THICK);
        
        // External Marmon Separation Slots: 4-Point pyrotechnic booster clamp hook channels
        for (slot = [0 : 90 : 270]) {
            rotate([0, 0, slot])
            translate([TITAN_BASE_OD / 2 - 0.75, -2.5, -2.5])
            cube([1.5, 5.0, 5.0]);
        }
    }
}

module TitanScaleFloorMatrix() {
    echo("CNC Toolpath: Face-Milling 12-Spoke Radial Load-Bearing Floor Matrix");
    color("DarkSlateGray")
    union() {
        // 12 primary structural spokes transfering crew G-loads straight to the base loop
        for (spoke = [0 : 30 : 360]) {
            rotate([0, 0, spoke])
            translate([0, -FRAME_MAX_CEILING / 2, -1.5])
            cube([(TITAN_BASE_OD / 2) - FORGING_WALL + 0.1, FRAME_MAX_CEILING, 1.5]);
        }
        
        // Concentric load distribution stiffener ring loops
        for (r_step = [TITAN_BASE_OD / 4, TITAN_BASE_OD / 3]) {
            difference() {
                translate([0, 0, -1.5]) cylinder(h = 1.5, r = r_step);
                translate([0, 0, -1.6]) cylinder(h = 1.7, r = r_step - FRAME_MAX_CEILING);
            }
        }
    }
}

// --- SECTION 2: DUAL OVERHEAD CREW INGRESS HATCH PLUGS ---
module SymmetricOverheadHatchFrame() {
    echo("CNC Toolpath: Cut Symmetrical Twin Hatch Portal Apertures");
    for (side = [-1, 1]) {
        scale([side, 1, 1])
        translate([22.0, 0, 65.0]) // Shifted outwards to clear the 2-seat layout center line
        rotate([0, 15, 0])          // 15-degree pitch matching the hull's taper
        difference() {
            // Main door pad reinforcement rim
            cube([28.0, 36.0, FRAME_MAX_CEILING * 4], center = true);
            // Crew pass-through clearance tunnel
            cube([24.0, 32.0, 2.0], center = true);
            // Recessed internal seat flange groove to host the ACDelco EPDM seals
            translate([0, 0, FRAME_MAX_CEILING * 2])
            cube([25.0, 33.0, 1.0], center = true);
        }
    }
}

// --- SECTION 3: RECESSED VIEWPORT HUBS WITH NASA PIN SPANNER SLOTS ---
module NASAPinSpannerLockRing(radius) {
    echo("CNC Toolpath: Engraving 8-Well NASA-KSC Pin Spanner Lock Ring Interface");
    collar_r = radius + 0.5;
    color("Gold")
    difference() {
        cylinder(h = 0.5, r = collar_r, center = true);
        cylinder(h = 0.7, r = radius, center = true); // Visual clear aperture
        
        // 8-Point uniform perimeter locking pin wells (3/16" diameter)
        for (idx = [0 : 45 : 360]) {
            rotate([0, 0, idx])
            translate([collar_r - 0.2, 0, 0])
            cylinder(h = 0.6, r = NASA_PIN_R, center = true);
        }
    }
}

module IntegratedTwinViewports() {
    echo("CNC Toolpath: Grinding Dual Windows with 38.5\" Curvature Arc Matrix");
    for (side = [-1, 1]) {
        translate([side * 16.0, TITAN_BASE_OD / 2 - 14.0, 80.0])
        rotate([12, 0, side * -5])
        union() {
            difference() {
                // Main receiving collar block welded to the 0.062" stringers
                cylinder(h = 2.0, r = 7.5, center = true);
                // Precision 38.5-inch radial sweep cut into Fused Silica panes
                translate([0, -WINDOW_ARC_R + 0.5, 0])
                cylinder(h = 3.5, r = WINDOW_ARC_R, center = true);
            }
            // Superimpose the NASA lock ring onto the window rim
            translate([0, 0, 1.0])
            NASAPinSpannerLockRing(radius = 6.0);
        }
    }
}

// --- SECTION 4: INTEGRATED EXTERNAL PROPULSION CLUSTER BRACKETS ---
module ElectroacousticThrusterMounts() {
    echo("CNC Toolpath: Carving 3 Symmetrical External Propulsion Pod Blocks");
    for (angle =) {
        rotate([0, 0, angle])
        translate([TITAN_BASE_OD / 2, 0, 0])
        difference() {
            // Main solid heavy propulsion bracket block
            cube([5.0, 12.0, 4.0], center = true);
            
            // Central Cymatic Wave Resonance Core Chamber (Processes SF6 Propellant)
            translate([1.5, 0, 0])
            cylinder(h = 4.2, r = THRUSTER_R, center = true);
            
            // Dual semi-circular snap-fit channels to seat micro LGM 10 canisters
            for (offset_y = [-4.0, 4.0]) {
                translate([-1.0, offset_y, 0])
                cylinder(h = 4.2, r = 1.25, center = true);
            }
        }
    }
}

// ============================================================================
// MASTER COMPLIANCE MODEL COMPOSITION ASSEMBLY
// ============================================================================
union() {
    // A. Primary Forging Foundation Block
    translate([0, 0, -2.0]) HeavyTitanBaseRing();
    translate([0, 0, -0.25]) TitanScaleFloorMatrix();
    
    // B. Internal Shell Cabin Reinforcements
    SymmetricOverheadHatchFrame();
    IntegratedTwinViewports();
    
    // C. External Attitude & Propulsion Control Arrays
    translate([0, 0, -2.0]) ElectroacousticThrusterMounts();
}

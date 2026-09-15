// ============================================================================
// PROJECT: TITAN GEMINI XVI / MERCURY MARK III 3D GEOMETRY MODEL
// CONFIGURATION: 120.0" FORGING BASE ENVELOPE / DUAL OVERHEAD APERTURES
// COMPLIANCE: 0.062" FRAME SKELETON CEILING / ZERO EXTERNAL FASTENER PORTS
// ============================================================================

$fn = 180; 

// --- MASTER MECHANICAL CONSTANTS ---
BASE_OD = 120.0;             // Titan Booster Skirt Interface Diameter
TOP_OD = 24.0;               // Apex Parachute Flange Diameter
CORE_HEIGHT = 135.0;         // Extended Conical Height of Capsule Can
HAT_THICKNESS = 0.062;       // Maximum Allowed Internal Framework Rib Wall
SKIN_THICKNESS = 0.025;      // Stamped Titanium Shell Base Sheet
WINDOW_RADIUS_ARC = 38.5;    // Cylindrical Curvature for Fused Silica Panes

module Mark3PressureHull() {
    // Generates the core airtight "Titanium Can" pressure vessel volume
    echo("Milling Inner Pressure Can. Thickness =", SKIN_THICKNESS);
    difference() {
        cylinder(h = CORE_HEIGHT, r1 = BASE_OD/2, r2 = TOP_OD/2, center = false);
        translate([0, 0, -0.1])
        cylinder(h = CORE_HEIGHT + 0.2, r1 = (BASE_OD/2) - SKIN_THICKNESS, r2 = (TOP_OD/2) - SKIN_THICKNESS, center = false);
    }
}

module IntegratedSkeletonRibCage() {
    // Patterns the dense vertical stringers and horizontal Z-frames
    echo("Milling Internal 0.062\" Honeycomb Grid Reinforcement");
    color("DarkSlateGray")
    union() {
        // 36 primary vertical hat-stringers to distribute launch G-forces uniformly
        for (rib = [0 : 10 : 360]) {
            rotate([0, 0, rib])
            translate([BASE_OD/2 - HAT_THICKNESS, -0.5, 0])
            rotate([0, -atan(((BASE_OD/2)-(TOP_OD/2))/CORE_HEIGHT), 0])
            cube([HAT_THICKNESS, 1.0, CORE_HEIGHT * 1.1]);
        }
        // Horizontal reinforcing rings distributed at load stations along the height axis
        for (z_pos = [15.0, 45.0, 75.0, 105.0]) {
            translate([0, 0, z_pos])
            difference() {
                current_r = (BASE_OD/2) - (((BASE_OD/2)-(TOP_OD/2)) * (z_pos/CORE_HEIGHT));
                cylinder(h = 1.5, r = current_r, center = true);
                cylinder(h = 1.7, r = current_r - HAT_THICKNESS, center = true);
            }
        }
    }
}

module CurvedTwinViewports() {
    // Generates the symmetric observation windows ground to the 38.5" radius arc
    for (side = [-1, 1]) {
        scale()
        translate([side * 16.0, BASE_OD/2 - 12.0, 80.0]) // Adjusted for dual-crew centerline alignment
        rotate([0, 12, 0]) 
        difference() {
            cylinder(h = 2.0, r = 8.5, center = true);
            // Dynamic tool-path swipe to curve the pane interface perfectly
            translate([0, -WINDOW_RADIUS_ARC + 0.5, 0])
            cylinder(h = 3.0, r = WINDOW_RADIUS_ARC, center = true);
        }
    }
}

// ============================================================================
// FABRICATION SYNCHRONIZATION VIEWPORT
// ============================================================================
union() {
    color("LightBlue", 0.6) Mark3PressureHull();
    IntegratedSkeletonRibCage();
    CurvedTwinViewports();
}

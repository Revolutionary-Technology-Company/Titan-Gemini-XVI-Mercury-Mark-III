// ============================================================================
// MODULE: DUAL OVERHEAD HATCH EXTERNAL HEAT-SHIELDED FAIRING HINGES
// REPOSITORY PATH: src/hatch_hinges.scad
// ARCHITECTURE: TWO-SEATER TITAN-GEMINI INTEGRATED OUTER HULL HOUSING
// COMPLIANCE: ZERO FASTERNER DESIGN / 0.025" STAMPED PANEL STEP MOUNTS
// ============================================================================

$fn = 120; // Maintain micro-smooth bearing paths for high-G launch dynamics

// --- MECHANICAL HINGE DESIGN LOGIC (INCHES) ---
SKIN_THICKNESS = 0.025;      // Base sheet thickness for stamped pressure panels
HINGE_PIN_RADIUS = 0.250;    // 1/2" diameter heavy-shear solid structural pivot pin
FAIRING_WIDTH = 3.00;        // Width of the external aerodynamic hinge hood
FAIRING_LENGTH = 8.00;       // Length of the solid mounting strip base block

module AerodynamicHingeFairingHood() {
    // Generates a single teardrop-profile thermal fairing housing to shield the pivot pins
    echo("CNC Toolpath: Patterning Aerodynamic René-41 Hinge Thermal Hood Profile");
    
    color("DarkSlateGray")
    difference() {
        union() {
            // Main solid streamlined teardrop housing block
            cube([FAIRING_WIDTH, FAIRING_LENGTH, 2.5], center = true);
            // Bullet-nose radius entry blend
            translate([0, -FAIRING_LENGTH / 2, 0])
            cylinder(h = 2.5, r = FAIRING_WIDTH / 2, center = true);
        }
        
        // Transverse bore hole to accept the heavy quick-release locking hinge pin
        rotate([0, 90, 0])
        translate([0, FAIRING_LENGTH / 4, 0])
        cylinder(h = FAIRING_WIDTH + 0.2, r = HINGE_PIN_RADIUS, center = true);
        
        // Lower recessed 0.025" step-down welding shoulder lip
        translate([0, 0, -1.25])
        cube([FAIRING_WIDTH + 0.1, FAIRING_LENGTH + 0.1, SKIN_THICKNESS * 2], center = true);
    }
}

module ApplySymmetricHatchHinges(capsule_top_radius) {
    // Spawns the four master hinge points symmetrically across the dual overhead canopy frames
    for (side = [-1, 1]) {
        for (hinge_pair = [-12.0, 12.0]) {
            scale([side, 1, 1])
            translate([34.0, hinge_pair, capsule_top_radius + 4.5]) // Clamps flush on outer door track
            rotate([0, 12, 0]) // Matches the 12-degree conical pitch tilt of the hull can
            AerodynamicHingeFairingHood();
        }
    }
}

// ============================================================================
// CNC WORKSTATION FIELD VERIFICATION VIEWPORT DISPLAY
// ============================================================================
// Simulates structural check layout on the outer Mark III canister crown
ApplySymmetricHatchHinges(capsule_top_radius = 12.0);

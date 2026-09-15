// ============================================================================
// MODULE: TITAN GEMINI XVI / MERCURY MARK III HATCH COMPRESSION LINKAGES
// REPOSITORY PATH: src/hatch_linkages.scad
// CONFIGURATION: CENTRAL DRIVE SPINDLE & SLIDING REGISTRY LOCK ARMS
// COMPLIANCE: ZERO FASTENERS / 0.062" MAXIMUM SKELETON PROXIMITY FLOOR
// ============================================================================

$fn = 120; // Crisp curve definition for precise slide alignment checks

// --- MECHANICAL LINKAGE SPECS (INCHES) ---
SKELETON_MAX_CEILING = 0.062; // Regulated framing thickness baseline
HUB_RADIUS = 3.50;           // Radius of central rotational transmission cam
ARM_WIDTH = 1.125;           // Width of solid titanium slider arm stock
ARM_THICKNESS = 0.1875;      // 3/16" thick heavy shear load link bars
SLIDE_TRAVEL = 1.25;         // Linear stroke displacement when handle is thrown

module CentralLinkageRotationalSpindle() {
    // High-torque rotational cam hub centered on the interior hatch door face
    echo("CNC Toolpath: Face-Milling Central Latch Transmission Spindle Hub Core");
    color("Gold")
    difference() {
        cylinder(h = 0.75, r = HUB_RADIUS, center = true);
        
        // Coarse helical socket thread to mesh with internal astronaut manual handle
        cylinder(h = 0.80, r = 1.25, center = true);
        
        // 4 eccentric driver pins holes (90-degree offsets) to actuate link slider rods
        for (pin_angle = [0 : 90 : 270]) {
            rotate([0, 0, pin_angle])
            translate([HUB_RADIUS - 0.75, 0, 0])
            cylinder(h = 1.0, r = 0.1875, center = true); // 3/16" link connection pins
        }
    }
}

module LinearCompressionLockArms() {
    // Symmetrical sliding locking wedges designed to project straight out into frame slots
    echo("CNC Toolpath: Patterning Symmetrical Sliding Latch Arm Link Bars");
    color("Silver")
    for (dir = [0 : 90 : 270]) {
        rotate([0, 0, dir])
        translate([HUB_RADIUS - 0.25 + SLIDE_TRAVEL, -ARM_WIDTH / 2, -ARM_THICKNESS / 2])
        union() {
            // Main solid linkage beam body transfer link
            cube([14.0, ARM_WIDTH, ARM_THICKNESS]);
            
            // Beveled Engagement Tip: Applies a progressive mechanical pinch force to lock the door
            translate([13.5, 0, -0.05])
            rotate([0, -10, 0]) // 10-degree wedge slope to clamp the ACDelco gasket flat
            cube([0.75, ARM_WIDTH, ARM_THICKNESS + 0.1]);
        }
    }
}

// ============================================================================
// CNC WORKSTATION FIELD VERIFICATION VIEWPORT DISPLAY
// ============================================================================
// Visualizes latch module alignment inside the upper cabin frame environment
union() {
    CentralLinkageRotationalSpindle();
    LinearCompressionLockArms();
}

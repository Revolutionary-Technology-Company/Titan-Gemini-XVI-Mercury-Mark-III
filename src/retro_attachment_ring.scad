// ============================================================================
// MODULE: TITAN GEMINI XVI MODULAR AFT RETROGRADE SECTION ATTACHMENT RING
// REPOSITORY PATH: src/retro_attachment_ring.scad
// GEOMETRY SCALE: 120.0" BOOSTER BASELINE ENVELOPE (ZERO-FASTENER METHOD)
// COMPLIANCE: 1.50" SEWER-PLATE THICKNESS BOUNDARY CEILING (DOC ENFORCED)
// ============================================================================

$fn = 240; // Max circular fidelity for smooth tool-path tracking on CNC vertical lathes

// --- MECHANICAL ENGINE CONSTANTS (INCHES) ---
TITAN_BASE_OD = 120.0;       // Historical Titan booster skirt diameter (10 Feet)
FORGING_WALL_CEILING = 1.50; // Approved "Sewer Plate" heavy ring thickness floor
SKIN_SHEET_THICKNESS = 0.025; // Pliable stamped titanium panel base sheet
RETRO_RING_HEIGHT = 4.5;     // Vertical length of the modular structural ring block
MARMON_TRACK_W = 0.750;      // Sizing track for heavy pyrotechnic separation clamps
MARMON_TRACK_D = 0.250;      // Precision depth of the retention lip profile

module CNCMachinedRetroAttachmentRing() {
    echo("CNC Toolpath: Turning 120-Inch Retrograde Section Adapter Interface Ring");
    
    color("Silver")
    difference() {
        // 1. Primary raw solid titanium-alloy forging block ring blank
        cylinder(h = RETRO_RING_HEIGHT, r = TITAN_BASE_OD / 2, center = true);
        
        // 2. Central hollow bore clearing space for the internal capsule can skin line
        translate([0, 0, -0.1])
        cylinder(h = RETRO_RING_HEIGHT + 0.5, r = (TITAN_BASE_OD / 2) - FORGING_WALL_CEILING, center = true);
        
        // 3. UPPER STEP RECEIVER SHELF: Milled recess to seat and flush-weld thin 0.025" skins
        translate([0, 0, (RETRO_RING_HEIGHT / 2) - 0.5])
        cylinder(h = 0.51, r = (TITAN_BASE_OD / 2) - SKIN_SHEET_THICKNESS);
        
        // 4. EXTERNAL MARMON LOCKING GROOVE: Carved into outer face for booster separation hooks
        translate([0, 0, -(RETRO_RING_HEIGHT / 4)])
        difference() {
            cylinder(h = MARMON_TRACK_W, r = (TITAN_BASE_OD / 2) + 0.1, center = true);
            cylinder(h = MARMON_TRACK_W + 0.2, r = (TITAN_BASE_OD / 2) - MARMON_TRACK_D, center = true);
        }
        
        // 5. WEIGHT-REDUCTION POCKET MATRIX: Blind holes milled inside non-structural regions
        for (pocket = [0 : 15 : 360]) {
            rotate([0, 0, pocket])
            translate([(TITAN_BASE_OD / 2) - (FORGING_WALL_CEILING / 2), 0, 0])
            cylinder(h = RETRO_RING_HEIGHT - 1.0, r = 0.375, center = true);
        }
    }
}

// ============================================================================
// CNC WORKSTATION FIELD VERIFICATION VIEWPORT DISPLAY
// ============================================================================
// Simulates the completed 120-inch retro adapter configuration ready for TIG
translate([0, 0, 0])
CNCMachinedRetroAttachmentRing();

// Needle selector for the LK150 knitting machine

/* [Selected needles on each side:] */
// This is the actual shape of the selector.

// Selected needles on the left side. 1 means a toot, 0 means a space
selected1 = [0,1,1,0,1,1,0,1,1,0,1,1,0,1,1,0,1,1,0,1,1,0,1,1,0]; //[0:1]
// The triangle shaped thing at the end of the first and last tooth
spikes1   = [0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0]; //[0:1]
// Selected needles on the right side. 1 means a toot, 0 means a space
selected2 = [1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1]; //[0:1]
// The triangle shaped thing at the end of the first and last tooth
spikes2   = [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1]; //[0:1]


/* [Hidden] */
// Constant values for the needle selector

// You may want to modify theese if you want to adapt it to another machine
needle_spacing = 6.5; // Distance between the center of two needles 6.5 mm on the LK150
needle_width = 6;     // Width of the needle / comb tooth


// You do not want to modify theese...
needle_width_difference = needle_spacing - needle_width; // spacing - width
selector_length = 10;       // Comb tooth length, 10 mm
thickness = 2.55;           // Thickness of the comb
depth = 1.6;                // Thickness of the thinnest part
selector_body_width = 18;   // Width of the comb body
spike_width = 4;            // Width of the spike (that triangle thing at the end of the first and last tooth
spike_length = 2;           // Length of the spike
spike_thickness = depth;    // Thickness of the spike = thinnest part
$fn = 96;
diff = needle_width / 2 - needle_width / 2 * cos(180 / $fn);

module comb_tooth(left, right, spike, bottom) {
    union() {
        difference() {
            y_translate = left ? 0 : needle_width_difference / 2;
            width = needle_width;
            width1 = right ? width + needle_width_difference / 2 : width;
            width2 = left ? width1 + needle_width_difference / 2 : width1;
            translate([0, y_translate, 0]) {
                cube([selector_length, width2, thickness]);
            }
            
            translate([selector_length / 2, needle_spacing / 2, thickness + needle_width / 2 - (thickness - depth) - diff]) {
                rotate([90, 360 / $fn / 2, 90]) {
                    cylinder(h = selector_length + 0.01, d = needle_width, center = true);
                }
            }
        }
        if (spike) {
            translate([0, 0, 0]) {
                triangle_points = [
                    [bottom ? selector_length : 0, needle_spacing / 2 - spike_width / 2],
                    [bottom ? selector_length : 0, needle_spacing / 2 + spike_width / 2],
                    [bottom ? selector_length + spike_length : - spike_length, needle_spacing / 2]
                ];
                linear_extrude(height = depth) {
                    polygon(points = triangle_points);
                }
            }
        }
    }
}

union() {
    for(i=[0:len(selected1)]) {
        if (selected1[i]) {
            translate([-9.99, i * needle_spacing, 0]) {
                comb_tooth(selected1[i-1],selected1[i+1], spikes1[i], 0);
            }
        }
        if (selected2[i]) {
            translate([selector_body_width, i * needle_spacing, 0]) {
                comb_tooth(selected2[i-1],selected2[i+1], spikes2[i], 1);
            }
        }

    }
    translate([0,(needle_width_difference) / 2, 0]) {
        cube([selector_body_width, needle_spacing * len(selected1) - (needle_width_difference), thickness]);
        }

}

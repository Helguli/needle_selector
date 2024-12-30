include <needle_selector_constants.scad>

selected1 = [0,1,1,0,1,1,0,1,1,0,1,1,0,1,1,0,1,1,0,1,1,0,1,1,0];
spikes1   = [0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0];
selected2 = [1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1,0,0,1];
spikes2   = [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1];

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
                rotate([90, 22.5, 90]) {
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

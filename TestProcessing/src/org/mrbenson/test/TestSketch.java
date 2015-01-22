package org.mrbenson.test;

import processing.core.PApplet;

public class TestSketch extends PApplet {
	public static void main(String args[]) {
		PApplet.main(new String[] { "--present", "org.mrbenson.test.TestSketch" });
	}

	public void setup() {
		size(800, 600);
		background(0);
	}

	public void draw() {
		stroke(255);
		if (mousePressed) {
			line(mouseX, mouseY, pmouseX, pmouseY);
		}
	}
}

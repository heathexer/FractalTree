private float fractionLength = .9;
private int smallestBranch = 10;
private double branchAngle = .25;
ArrayList<ArrayList<Branch>> branches = new ArrayList<ArrayList<Branch>>();
private double str = 1;
public void setup() {
	size(800, 800);
	noLoop();
	rotate(PI);
	branches.add(new ArrayList<Branch>());
	branches.get(0).add(new Branch(1.5*PI, 100, 400, 780));
	tree(8);
}
public void draw() {
	str = 8;
	for(int i = 0; i < branches.size(); i++) {
		strokeWeight((float)str);
		for(int j = 0; j < branches.get(i).size(); j++) {
			branches.get(i).get(j).show();
		}
		str *= .75;
	}
}

class Branch {
  double angle;
  float x1, y1, l, x2, y2;
  Branch(double a, float l, float sx, float sy) {
    a = a%TWO_PI;
		angle = a;
		this.l = l;
    x1 = sx;
    y1 = sy;
    x2 = sx+(float)(Math.cos(a)*l);
    y2 = sy+(float)(Math.sin(a)*l);
  }
  public void show() {
    line(x1, y1, x2, y2);
  }
	Branch forkL() {
		return new Branch(angle-branchAngle+((Math.random()-.5)*.2), l*fractionLength, x2, y2);
	}
	Branch forkR() {
		return new Branch(angle+branchAngle+((Math.random()-.5)*.2), l*fractionLength, x2, y2);
	}
}

public void tree(int level) {
	for(int i = 1; i <= level; i++) {
		branches.add(new ArrayList<Branch>());
		ArrayList c = branches.get(i);
		for(int j = 0; j < branches.get(i-1).size(); j++) {
			c.add(branches.get(i-1).get(j).forkR());
			c.add(branches.get(i-1).get(j).forkL());
		}
	}
}

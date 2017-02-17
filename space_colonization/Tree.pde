class Tree {
  PVector root_pos;
  ArrayList<Leaf> leaves = new ArrayList<Leaf>();
  ArrayList<Branch> branches = new ArrayList<Branch>();
  float min_dist, max_dist;
    
  Tree(PVector root_pos, float min_dist, float max_dist) {
    this.root_pos = root_pos;
    this.min_dist = min_dist;
    this.max_dist = max_dist;
    
    for (int i = 0; i < 500; i++) {
      leaves.add(new Leaf(new PVector(0, 0), new PVector(width, height - height / 3)));
    }
    
    Branch root = new Branch(null, root_pos, new PVector(0, -1));
    this.branches.add(root);
    
    boolean found = false;
    Branch current = root;
    while (!found) {
      for (Leaf l : leaves) {
        float dist = PVector.dist(current.pos, l.pos);
        if (dist < max_dist) {
          found = true;
          break;
        }
      }
      
      if (!found) {
        current = current.next();
        branches.add(current);
      }
    }
  }
  
  void grow() {
    for (Leaf l : leaves) {
      Branch closest = null;
      float closest_dist = Float.MAX_VALUE;
      for (Branch b : branches) {
        float dist = PVector.dist(b.pos, l.pos);
        
        if (dist <= this.min_dist) {
          l.reached = true;
          closest = null;
          break;
        } else if (dist > this.max_dist) {
          continue;
        } else if (closest == null || dist < closest_dist) {
          closest = b;
          closest_dist = dist;
        }
      }
      
      if (closest != null) {
        PVector dir = PVector.sub(l.pos, closest.pos);
        dir.normalize();
        closest.dir.add(dir);
        closest.count++;
      }
    }
    
    for (int i = this.leaves.size() - 1; i >= 0; i--) {
      if (this.leaves.get(i).reached) {
        this.leaves.remove(i);
      }
    }
    
    ArrayList<Branch> newBranches = new ArrayList<Branch>();
    for (Branch b : branches) {
      if (b.count > 0) {
        b.dir.div(b.count);
        newBranches.add(b.next());
        b.reset();
      }
    }
    this.branches.addAll(newBranches);
  }
  
  void show() {
    for (Leaf l : this.leaves) {
      l.show();
    }
    
    for (Branch b : this.branches) {
      b.show();
    }
  }
}
 JSONObject data;

void setup() {
  size(600, 400);
  data = loadJSONObject("birds.json");
}

void draw() {
  background(51);
  
  JSONArray birds = (JSONArray)data.get("birds");
  print(birds);
}
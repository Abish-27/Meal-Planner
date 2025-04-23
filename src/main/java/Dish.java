public class Dish {
	private int dishID;
	private String  dishName;
	private int calorieCount;
	private boolean veg;
	private String type;

	
	Dish(int i, String n, int c, boolean v, String t){
		dishID = i;
		dishName = n;
		calorieCount = c;
		veg = v;
		type = t;
	}
	
	//Accessor methods
	public int getDishId() {return dishID;}
	public String getDishName() {return dishName;}
	public int getCalorieCount() {return calorieCount;}
	public boolean isVeg() {return veg;}
	public String getType() {return type;}
	
	//Mutator Methods
	public void setDishId(int i) {dishID = i;}
	public void setDishName(String n) {dishName = n;}
	public void setCalorieCount(int c) {calorieCount = c;}
	public void setVeg(boolean v) {veg = v;}
	public void setType(String t) {type = t;}
	

}


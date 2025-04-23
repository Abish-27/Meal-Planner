

public class Meal {
	private int dishID;
	private String  dishName;
	private String time;
	private String day;

	
	Meal(int i, String n, String d, String t){
		dishID = i;
		dishName = n;
		day = d;
		time = t;
	}
	
	//Accessor methods
	public int getDishId() {return dishID;}
	public String getDishName() {return dishName;}
	public String getDay() {return day;}
	public String getTime() {return time;}
	
	//Mutator Methods
	public void setDishId(int i) {dishID = i;}
	public void setDishName(String n) {dishName = n;}
	public void setDay(String d) {day = d;}
	public void setTime(String t) {time = t;}
	

}







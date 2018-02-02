package pocket.beans;

import java.util.*;

public class ExpenseDetail {
	
	private int expenseId;
	private int groupId;
	private String addedById;
	private String paidById;
	private ArrayList<String> paidForId;
	private HashMap<String,Double> amount;
	private String name;
	private Date addedDate;
	private String category;
	private String image; 
	private String activationFlag;
	private double totalAmount;
	private Date sysCreationDate;
	private String note;
	
	public ExpenseDetail() {
		super();
	}

	public ExpenseDetail(int expenseId, int groupId, String addedById,
			String paidById, ArrayList<String> paidForId, HashMap<String,Double> amount, String name,
			Date addedDate, String category, String image,
			String activationFlag, double totalAmount, Date sysCreationDate,
			String note) {
		super();
		this.expenseId = expenseId;
		this.groupId = groupId;
		this.addedById = addedById;
		this.paidById = paidById;
		this.paidForId = paidForId;
		this.amount = amount;
		this.name = name;
		this.addedDate = addedDate;
		this.category = category;
		this.image = image;
		this.activationFlag = activationFlag;
		this.totalAmount = totalAmount;
		this.sysCreationDate = sysCreationDate;
		this.note = note;
	}

	public int getExpenseId() {
		return expenseId;
	}

	public void setExpenseId(int expenseId) {
		this.expenseId = expenseId;
	}

	public int getGroupId() {
		return groupId;
	}

	public void setGroupId(int groupId) {
		this.groupId = groupId;
	}

	public String getAddedById() {
		return addedById;
	}

	public void setAddedById(String addedById) {
		this.addedById = addedById;
	}

	public String getPaidById() {
		return paidById;
	}

	public void setPaidById(String paidById) {
		this.paidById = paidById;
	}

	public ArrayList<String> getPaidForId() {
		return paidForId;
	}

	public void setPaidForId(ArrayList<String> paidForId) {
		this.paidForId = paidForId;
	}

	public HashMap<String,Double> getAmount() {
		return amount;
	}

	public void setAmount(HashMap<String,Double> amount) {
		this.amount = amount;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Date getAddedDate() {
		return addedDate;
	}

	public void setAddedDate(Date addedDate) {
		this.addedDate = addedDate;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getActivationFlag() {
		return activationFlag;
	}

	public void setActivationFlag(String activationFlag) {
		this.activationFlag = activationFlag;
	}

	public double getTotalAmount() {
		return totalAmount;
	}

	public void setTotalAmount(double totalAmount) {
		this.totalAmount = totalAmount;
	}

	public Date getSysCreationDate() {
		return sysCreationDate;
	}

	public void setSysCreationDate(Date sysCreationDate) {
		this.sysCreationDate = sysCreationDate;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public static final Map<Integer, String> monthEnum;
	static {
	 Map<Integer, String> temp= new HashMap<Integer, String>();
	temp.put(1,"January");
	temp.put(2,"February");
	temp.put(3,"March");
	temp.put(4,"April");
	temp.put(5,"May");
	temp.put(6,"June");
	temp.put(7,"July");
	temp.put(8,"August");
	temp.put(9,"September");
	temp.put(10,"October");
	temp.put(11,"November");
	temp.put(12,"December");
	monthEnum = Collections.unmodifiableMap(temp);
	}
		
}
package models;

public class CartRow {
	private Product product;
	private int cart_quantity;
	private int cart_subtotal;
	public Product getProduct() {
		return product;
	}
	public void setProduct(Product product) {
		this.product = product;
	}
	public int getCart_quantity() {
		return cart_quantity;
	}
	public void setCart_quantity(int car_quantity) {
		this.cart_quantity = car_quantity;
	}
	public int getCart_subtotal() {
		return cart_subtotal;
	}
	public void setCart_subtotal(int cart_subtotal) {
		this.cart_subtotal = cart_subtotal;
	}
	
	
}

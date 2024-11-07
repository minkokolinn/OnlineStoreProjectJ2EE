package models;

import java.util.Date;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name = "orders")
public class Order{

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@Column(unique = true)
	private String ordernumber;
	
	@Temporal(value = TemporalType.DATE)
	private Date orderdate;
	
	private String contactphone;
	
	@Column(columnDefinition = "TEXT")
	private String contactaddress;
	
	private String paymenttype;
	
	private int total;
	
	private String merchant;
	
	private String cardno;
	
	private String deliverytype;
	
	private boolean isdelivered;
	
	@OneToOne
	@JoinColumn(name = "user_id")
	private User user;
	
	@OneToMany(cascade = CascadeType.ALL)
	@JoinColumn(name = "order_id")
	private Set<OrderDetail> orderDetails;

	public int getId() {
		return id;
	}


	public String getOrdernumber() {
		return ordernumber;
	}

	public void setOrdernumber(String ordernumber) {
		this.ordernumber = ordernumber;
	}

	public Date getOrderdate() {
		return orderdate;
	}

	public void setOrderdate(Date orderdate) {
		this.orderdate = orderdate;
	}

	public String getContactphone() {
		return contactphone;
	}

	public void setContactphone(String contactphone) {
		this.contactphone = contactphone;
	}

	public String getContactaddress() {
		return contactaddress;
	}

	public void setContactaddress(String contactaddress) {
		this.contactaddress = contactaddress;
	}

	public String getPaymenttype() {
		return paymenttype;
	}

	public void setPaymenttype(String paymenttype) {
		this.paymenttype = paymenttype;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public String getMerchant() {
		return merchant;
	}

	public void setMerchant(String merchant) {
		this.merchant = merchant;
	}

	public String getCardno() {
		return cardno;
	}

	public void setCardno(String cardno) {
		this.cardno = cardno;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Set<OrderDetail> getOrderDetails() {
		return orderDetails;
	}

	public void setOrderDetails(Set<OrderDetail> orderDetails) {
		this.orderDetails = orderDetails;
	}


	public String getDeliverytype() {
		return deliverytype;
	}


	public void setDeliverytype(String deliverytype) {
		this.deliverytype = deliverytype;
	}


	public boolean isIsdelivered() {
		return isdelivered;
	}


	public void setIsdelivered(boolean isdelivered) {
		this.isdelivered = isdelivered;
	}


	@Override
	public String toString() {
		return "Order [id=" + id + ", ordernumber=" + ordernumber + ", orderdate=" + orderdate + ", contactphone="
				+ contactphone + ", contactaddress=" + contactaddress + ", paymenttype=" + paymenttype + ", total="
				+ total + ", merchant=" + merchant + ", cardno=" + cardno + ", deliverytype=" + deliverytype
				+ ", isdelivered=" + isdelivered + ", user=" + user + ", orderDetails=" + orderDetails + "]";
	}
	
	
	
}

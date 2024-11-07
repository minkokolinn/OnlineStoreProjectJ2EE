package controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import daos.AccountDao;
import daos.OrderDao;
import daos.OrderDetailDao;
import daos.ProductDao;
import models.CartRow;
import models.Order;
import models.OrderDetail;
import utility.Utility;

/**
 * Servlet implementation class CheckoutController
 */
@WebServlet("/checkout")
public class CheckoutController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CheckoutController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		
		if (request.getParameter("shippingMethod")==null || request.getParameter("hiddenTotal")==null || request.getParameter("shippingMethod").equals("") || request.getParameter("hiddenTotal").equals("") || session.getAttribute("cart")==null || new AccountDao().checkUserAuth(request)==0) {
			response.sendRedirect("cart");
		}else {
			request.getRequestDispatcher("checkout.jsp").forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String contactPhone = request.getParameter("contactPhone");
		String contactAddress = request.getParameter("contactAddress");
		String bankInfo = request.getParameter("bankInfo");
		String cardNo = request.getParameter("cardNo");
		int total = Integer.parseInt(request.getParameter("hiddenTotal"));
		String deliveryMethod = request.getParameter("shippingMethod");
		String paymentType = request.getParameter("paymentType");
		
		Order o = new Order();
		String generatedOrderNumber = Utility.generateOrderNumber();
		o.setOrdernumber(generatedOrderNumber);
		Date dateobj=null;
		try {
			dateobj = new SimpleDateFormat("yyyy-MM-dd").parse(new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		o.setOrderdate(dateobj);
		o.setContactphone(contactPhone);
		o.setContactaddress(contactAddress);
		o.setTotal(total);
		o.setMerchant(bankInfo);
		o.setCardno(cardNo);
		o.setDeliverytype(deliveryMethod);
		o.setIsdelivered(false);
		o.setPaymenttype(paymentType);
		o.setUser(new AccountDao().getUserByID(new AccountDao().checkUserAuth(request)));
		
		int createdId = new OrderDao().insertOrder(o);
		if (createdId==0) {
			request.setAttribute("error", "Failed in order stage");
			request.getRequestDispatcher("error.jsp").forward(request, response);
		}else {
			HttpSession session = request.getSession();
			List<CartRow> cartRows = (List<CartRow>)session.getAttribute("cart");
			for(CartRow row: cartRows) {
				OrderDetail od = new OrderDetail();
				od.setQuantity(row.getCart_quantity());
				od.setPrice(row.getCart_subtotal());
				od.setOrder(new OrderDao().getOrderByID(createdId));
				od.setProduct(row.getProduct());
				if (new OrderDetailDao().insertOrderDetail(od)) {
					System.out.println("success");
				}else {
					System.out.println("fail");
				}
			}
			HttpSession session1 = request.getSession();
			session1.invalidate();
			request.setAttribute("success", "Ordered successfully... Your order number is "+generatedOrderNumber);
			request.getRequestDispatcher("success.jsp").forward(request, response);
		}
		
		
		
	}

}

package controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import daos.AccountDao;
import daos.ProductDao;
import models.CartRow;
import models.Product;

/**
 * Servlet implementation class AddToCartController
 */
@WebServlet("/productdetail")
public class AddToCartController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddToCartController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		if (request.getParameter("pidtodetail")==null) {
			response.sendRedirect("product");
		}else {
			request.getRequestDispatcher("productdetail.jsp").forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	
		int id = Integer.parseInt(request.getParameter("pidtocart"));
		if (new AccountDao().checkUserAuth(request)==0) {
			request.setAttribute("error", "Please Login first to add this item!!!");	
			request.getRequestDispatcher("productdetail.jsp?pidtodetail="+id).forward(request, response);
		}else {
			Product cartProduct = new ProductDao().getProductByID(id);
			int cartQuantity = Integer.parseInt(request.getParameter("cartQuantity"));
			int cartSubTotal = cartProduct.getPrice()*cartQuantity;
			CartRow cartRow = new CartRow();
			cartRow.setProduct(cartProduct);
			cartRow.setCart_quantity(cartQuantity);
			cartRow.setCart_subtotal(cartSubTotal);
			
			HttpSession session = request.getSession();

			if (session.getAttribute("cart") == null) {
				List<CartRow> cart = new ArrayList<CartRow>();
				cart.add(cartRow);
				session.setAttribute("cart", cart);
			} else {
				List<CartRow> cart = (List<CartRow>) session.getAttribute("cart");
				cart.add(cartRow);
				session.setAttribute("cart", cart);
			}
			
			response.sendRedirect("productdetail?pidtodetail"+id);
		}
		
	}

}

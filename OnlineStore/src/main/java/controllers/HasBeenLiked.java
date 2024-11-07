package controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import daos.AccountDao;
import daos.LikeProductDao;

/**
 * Servlet implementation class HasBeenLiked
 */
@WebServlet("/hasbeenliked")
public class HasBeenLiked extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HasBeenLiked() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		int user_id = new AccountDao().checkUserAuth(request);
		int product_id = Integer.parseInt(request.getParameter("productId"));
		
		String result = "";
		if (new LikeProductDao().hasbeenLiked(user_id, product_id)) {
			result = "liked";
		}else {
			result = "unliked";
		}
		response.setContentType("text/plain");
		response.getWriter().print(result);
	}

}

package controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import daos.AccountDao;
import daos.LikeProductDao;
import daos.ProductDao;

/**
 * Servlet implementation class LikeUnlikeController
 */
@WebServlet("/likeunlike")
public class LikeUnlikeController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LikeUnlikeController() {
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
		String status = request.getParameter("status");
		System.out.println(status);
		String fntype = request.getParameter("fntype");
		System.out.println(fntype);
		String pid = request.getParameter("pid");
		System.out.println(pid);
		
		int totalCount=0;
		if (fntype.equals("like")) {
			totalCount=new LikeProductDao().likeAction(Integer.parseInt(pid),new AccountDao().getUserByID(new AccountDao().checkUserAuth(request)));
		}
		if (fntype.equals("unlike")) {
			totalCount=new LikeProductDao().UnlikeAction(Integer.parseInt(pid),new AccountDao().getUserByID(new AccountDao().checkUserAuth(request)));
		}
		response.setContentType("text/plain");
		response.getWriter().print(totalCount);
	}

}

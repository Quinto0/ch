package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;

import entity.UserInfo;
import mapper.UserInfoMapper;
import utils.Utils;

/**
 * @Description 处理用户注册请求
 * @author refuel
 * @version v1.0
 */
@WebServlet("/register")
public class UserRegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//获取注册数据
		String name = request.getParameter("name");
		String password = request.getParameter("password");
		Long phone = Long.parseLong(request.getParameter("phone"));
		String email = request.getParameter("email");
		Character gender =request.getParameter("gender").charAt(0);
		UserInfo user = new UserInfo(name, password, phone, email, gender);
		//加载配置文件
		SqlSession sqlSession = Utils.getSqlSession();
		UserInfoMapper mapper = sqlSession.getMapper(UserInfoMapper.class);
		int result = mapper.insertUserInfo(user);
		System.out.println(result);
		if(result==1) {
			response.sendRedirect("login.jsp");
		}else {
			request.setAttribute("msg", "注册失败，请重新注册");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}

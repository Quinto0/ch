package servlet;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;

import entity.UserInfo;
import mapper.UserInfoMapper;
import utils.Utils;

/**
 * @Description 处理用户登录请求
 * @author refuel
 * @version v1.0
 */
@WebServlet("/login")
public class UserLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@SuppressWarnings("unchecked")
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {

			// 获取到登录数据
			String name = request.getParameter("name");
			String password = request.getParameter("pwd");
			// 封装到实体类中
			UserInfo user = new UserInfo(name, password);
			
			// 查询是否有该用户
			SqlSession sqlSession = Utils.getSqlSession();
			UserInfoMapper mapper = sqlSession.getMapper(UserInfoMapper.class);
			List<UserInfo> list = mapper.selectByNamePwd(user);
			
			if (list.isEmpty()) {				
				request.setAttribute("msg", "登录失败,用户名或密码错误!");
				request.getRequestDispatcher("login.jsp").forward(request, response);
			} else {
						
				//每个浏览器第二个用户登录后将之前的session销毁
				request.getSession().invalidate();
				
				// 获得到ServletCOntext中存的Map集合.
				Map<UserInfo, HttpSession> userMap = (Map<UserInfo, HttpSession>) getServletContext()
						.getAttribute("userMap");
				// 判断用户是否已经在map集合中'
				if(userMap.containsKey(user)){
					// 说用map中有这个用户.
					HttpSession session = userMap.get(user);
					// 将这个session销毁.
					session.invalidate();
				}
				
				//只要往session对象一存就绑定了，监听器HttpSessionBandingListener作用的对象就执行相应方法
				request.getSession().setAttribute("user", user);					
				// 登录成功重定向到聊天界面
				response.sendRedirect("chat.jsp");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}

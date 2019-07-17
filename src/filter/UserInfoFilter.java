package filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;

/**
 * @Description 过滤器类
 * @author refuel
 * @version v1.0
 */
@WebFilter("/*")
public class UserInfoFilter implements Filter {

	/**
	 * @Description 设置请求与响应的编码集用来解决乱码问题
	 * @param request
	 * @param response
	 * @param chain
	 * @throws IOException
	 * @throws ServletException
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		chain.doFilter(request, response);
	}
	public void init(FilterConfig fConfig) throws ServletException {
	}
	public UserInfoFilter() {
	}
	public void destroy() {
	}
}

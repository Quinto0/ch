package listener;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSession;

import entity.UserInfo;

/**
 * @Description 监听器类
 * @author refuel
 * @version v1.0
 */
@WebListener
public class UserCountListener implements ServletContextListener {

    public void contextDestroyed(ServletContextEvent sce)  { 
    }

    /**
     * @Description ServletContext一创建就会执行这个方法
     * @param sce
     */
    public void contextInitialized(ServletContextEvent sce)  { 
    	//创建map存储用户列表
    	Map<UserInfo,HttpSession> userMap = new HashMap<>();
    	sce.getServletContext().setAttribute("userMap", userMap);
    }
	
}

package entity;

import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionBindingListener;

/**
 * @Description 用户信息实体类
 * @author refuel
 * @version v1.0
 */
public class UserInfo implements HttpSessionBindingListener {
	private Integer id;
	private String name;
	private String password;
	private Long phone;
	private String email;
	private Character gender;

	public UserInfo() {
	}
	public UserInfo(String name, String password) {
		this.name = name;
		this.password = password;
	}
	public UserInfo(String name, String password, Long phone, String email, Character gender) {
		this.name = name;
		this.password = password;
		this.phone = phone;
		this.email = email;
		this.gender = gender;
	}
	public UserInfo(Integer id, String name, String password, Long phone, String email, Character gender) {
		this.id = id;
		this.name = name;
		this.password = password;
		this.phone = phone;
		this.email = email;
		this.gender = gender;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Long getPhone() {
		return phone;
	}

	public void setPhone(Long phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Character getGender() {
		return gender;
	}

	public void setGender(Character gender) {
		this.gender = gender;
	}
	

	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime * result + ((name == null) ? 0 : name.hashCode());
		result = prime * result + ((password == null) ? 0 : password.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		UserInfo other = (UserInfo) obj;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		if (name == null) {
			if (other.name != null)
				return false;
		} else if (!name.equals(other.name))
			return false;
		if (password == null) {
			if (other.password != null)
				return false;
		} else if (!password.equals(other.password))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "UserInfo [id=" + id + ", name=" + name + ", password=" + password + ", phone=" + phone + ", email="
				+ email + ", gender=" + gender + "]";
	}

	/**
	 * @Description javabean与session绑定时执行
	 * @param event
	 */
	@Override
	public void valueBound(HttpSessionBindingEvent event) {
		// 通过event事件对象获取session
		HttpSession session = event.getSession();
		// 从getServletContext获取到人员列表的map集合
		Map<UserInfo, HttpSession> userMap = (Map<UserInfo, HttpSession>) session.getServletContext()
				.getAttribute("userMap");
		//将用户和对应的session存到map集合中
		userMap.put(this, session);
	}

	/**
	 * @Description javabean与session解除绑定时执行
	 * @param event
	 */
	@Override
	public void valueUnbound(HttpSessionBindingEvent event) {
		// 通过event事件对象获取session
		HttpSession session = event.getSession();
		// 从getServletContext获取到人员列表的map集合
		Map<UserInfo, HttpSession> userMap = (Map<UserInfo, HttpSession>) session.getServletContext()
				.getAttribute("userMap");
		//将用户和对应的session移除map集合中
		userMap.remove(this);
	}

}

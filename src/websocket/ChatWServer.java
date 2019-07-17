package websocket;

import java.io.IOException;
import java.net.URI;
import java.util.concurrent.CopyOnWriteArraySet;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpSession;
import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

import utils.Utils;

/**
 * @Description WebSocket服务器端
 * @author refuel
 * @version v1.0
 */
@ServerEndpoint("/chatt/{param}") // 声明webSocket的名字
public class ChatWServer {
	private Session session;
	// 连接的客户端名称
	private String clientName;
	// 初始化集合（线程安全），用来存放每个客户端对应的服务器端的WebSocket对象
	private static CopyOnWriteArraySet<ChatWServer> serverSet = new CopyOnWriteArraySet<>();

	/**
	 * @Description 当客户端连接成功后执行调用的方法
	 * @param session
	 */
	@OnOpen
	public void onOPen(Session session, @PathParam("param") String param) {
		System.out.println(param + "连接成功");
		// 客户端连接成功后给session赋值
		this.session = session;
		clientName = param;
		// 连接成功后把当前对象加入集合
		serverSet.add(this);
	}

	/**
	 * @Description 接收客户端发送的消息
	 * @param str 发送的消息
	 */
	@OnMessage
	public void onMessage(String str) {
		try {
			System.out.println("客户端发送的数据为：" + str);
			// 判断是私聊还是群发
			String flag = str.substring(0, 1);
			// 私聊
			if (".".equals(flag)) {
				String username = null;				
				// 正则表达式取出要发送的用户
				Pattern p = Pattern.compile("<a>([u4e00-\\u9fa5]{0,}|\\w+{0,})</a>");
				Matcher m = p.matcher(str);
				if (m.find()) {
					username = m.group(1);
				}
				// 将用户名改成我
				String str1 = str.replaceFirst("<a>" + username + "</a>", "我");
				// 重新组装的字符串
				String strfull = "[" + Utils.getCurrentTime() + "]"+str1.substring(0);
				boolean tag=false;
				for (ChatWServer client : serverSet) {
					if (username.equals(client.clientName)) {
						tag = true;
						client.session.getBasicRemote().sendText(strfull);
					}
				}
				if(!tag) {
					System.out.println("该用户不存在，请重新输入");
				}
			} else {
				// 群聊
				String time = Utils.getCurrentTime();
				str = "[" + time + "]" + str;

				for (ChatWServer server : serverSet) {
					// 将数据发送给每个客户端
					server.session.getBasicRemote().sendText(str);
				}

			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * @Description 发生错误时调用的方法
	 * @param error
	 */
	public void onError(Throwable error) {
		System.out.println("有错误");
		error.printStackTrace();
	}

	/**
	 * @Description 关闭连接时调用的方法
	 *
	 */
	@OnClose
	public void onClose() {
		// 关闭时从当前集合移除
		serverSet.remove(this);
		System.out.println("连接关闭");
	}
}

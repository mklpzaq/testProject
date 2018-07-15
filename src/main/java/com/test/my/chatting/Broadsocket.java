package com.test.my.chatting;

import java.io.IOException;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

@ServerEndpoint("/broadcasting")
public class Broadsocket {

	private static Set<Session> clients = Collections.synchronizedSet(new HashSet<Session>());

	@OnMessage
	public void onMessage(String message, Session session) throws IOException {
		System.out.println("onMessage1 : " + message);
		synchronized (clients) {
			// Iterate over the connected sessions
			// and broadcast the received message
			System.out.println("synchronized(client) - message : " + message);
			for (Session client : clients) {
				if (!client.equals(session)) {
					System.out.println("foreach-message : " + message);
					client.getBasicRemote().sendText(message);
				}
			}
		}
	}

	@OnOpen
	public void onOpen(Session session) {
		// Add session to the connected sessions set
		System.out.println("onOpen : " + session);
		clients.add(session);
	}

	@OnClose
	public void onClose(Session session) {
		// Remove session from the connected sessions set
		System.out.println("onClose : " + session);
		clients.remove(session);
	}
}
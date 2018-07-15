package com.test.my.chatting;

import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ChattingController {
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@RequestMapping(value = "/chatting", method = RequestMethod.GET)
	public ModelAndView chatting(Locale locale, Model model) {
		logger.debug("GET chatting ChattingController");
		
		ModelAndView mv = new ModelAndView("chatting/chatting");
		
		
		return mv;
	}
}

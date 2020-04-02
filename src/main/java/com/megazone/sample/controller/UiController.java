package com.megazone.sample.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;


@EnableAutoConfiguration
@RefreshScope
@RestController
public class UiController {

    private static final Logger logger = LoggerFactory.getLogger(UiController.class);

    @Value("${uri.gateway}")
    String GATEWAY;

    @Value("${uri.registry}")
    String REGISTRY;


    @Autowired
    private RestTemplate restTemplate;


    @RequestMapping("/")
    public ModelAndView index() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("index");
        return mv;
    }


    @RequestMapping(value = {"/view"}, method = RequestMethod.GET)
    public ModelAndView view(HttpServletRequest httpServletRequest, ModelAndView model) {
        model.setViewName("index");
        return model;
    }


    @RequestMapping(value = {"/r/users"}, method = RequestMethod.GET)
    public String r_users(HttpServletRequest httpServletRequest, ModelAndView model) {
        //Registry
        String REGISTRY_URI = REGISTRY + "/r/users";
        logger.info(REGISTRY_URI);
        ResponseEntity res = restTemplate.getForEntity(REGISTRY_URI, String.class);
        logger.info(res.toString());
        return res.getBody().toString();
    }


    @RequestMapping(value = {"/g/users"}, method = RequestMethod.GET)
    @ResponseBody
    public String g_users(HttpServletRequest httpServletRequest) {
        //Gateway
        RestTemplate rTemplate = new RestTemplate();
        String GATEWAY_URI = GATEWAY + "/g/users";
        logger.info(GATEWAY_URI);
        ResponseEntity res = rTemplate.getForEntity(GATEWAY_URI, String.class);
        logger.info(res.toString());
        return res.getBody().toString();
    }




}

package com.javaex.controller;

import com.javaex.service.PrideService;
import com.javaex.vo.PrideVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.util.Map;

@Controller
@RequestMapping("/pride")
public class PrideController {

    private final PrideService service;
    public PrideController(PrideService service){ this.service = service; }

    @GetMapping("/list") public String list(){ return "pride/pridemain"; }

    @ResponseBody
    @GetMapping("/api")
    public Map<String,Object> api(@RequestParam(defaultValue="0") int page,
                                  @RequestParam(defaultValue="12") int size){
        return service.page(page, size);
    }

    @GetMapping("/teampage/postWriteForm")
    public String writeForm(Model model){
        model.addAttribute("pride", new PrideVO());
        return "teampage/postWriteForm";
    }

    @PostMapping("/write")
    public String write(@ModelAttribute PrideVO pride){
        service.write(pride);
        return "redirect:/pride/list";
    }

    @GetMapping("/detail/{id}")
    public String detail(@PathVariable("id") Long teamPostNo, Model model){
        model.addAttribute("pride", service.get(teamPostNo));
        return "pride/detail";
    }
}

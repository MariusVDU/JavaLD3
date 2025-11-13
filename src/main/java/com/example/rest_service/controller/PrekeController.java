package com.example.rest_service.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.rest_service.model.Preke;
import com.example.rest_service.service.PrekeService;

@Controller
@RequestMapping("/prekes")
public class PrekeController {
    
    @Autowired
    private PrekeService prekeService;
    
    // READ - List all prekes
    @GetMapping
    public String listPrekes(Model model) {
        List<Preke> prekes = prekeService.getAllPrekes();
        model.addAttribute("prekes", prekes);
        return "prekes/list";
    }
    
    // CREATE - Show form for new preke
    @GetMapping("/new")
    public String showNewPrekeForm(Model model) {
        model.addAttribute("preke", new Preke());
        model.addAttribute("isEdit", false);
        return "prekes/form";
    }
    
    // CREATE - Save new preke
    @PostMapping
    public String savePreke(@ModelAttribute("preke") Preke preke, 
                           RedirectAttributes redirectAttributes) {
        try {
            prekeService.savePreke(preke);
            redirectAttributes.addFlashAttribute("successMessage", 
                "Prekė sėkmingai sukurta!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", 
                "Klaida kuriant prekę: " + e.getMessage());
        }
        return "redirect:/prekes";
    }
    
    // UPDATE - Show form to edit preke
    @GetMapping("/edit/{id}")
    public String showEditPrekeForm(@PathVariable("id") Integer id, Model model) {
        Optional<Preke> preke = prekeService.getPrekeById(id);
        
        if (preke.isPresent()) {
            model.addAttribute("preke", preke.get());
            model.addAttribute("isEdit", true);
            return "prekes/form";
        }
        
        return "redirect:/prekes";
    }
    
    // UPDATE - Update preke
    @PostMapping("/{id}")
    public String updatePreke(@PathVariable("id") Integer id, 
                             @ModelAttribute("preke") Preke preke,
                             RedirectAttributes redirectAttributes) {
        try {
            prekeService.updatePreke(id, preke);
            redirectAttributes.addFlashAttribute("successMessage", 
                "Prekė sėkmingai atnaujinta!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", 
                "Klaida atnaujinant prekę: " + e.getMessage());
        }
        return "redirect:/prekes";
    }
    
    // DELETE - Delete preke
    @PostMapping("/delete/{id}")
    public String deletePreke(@PathVariable("id") Integer id, 
                             RedirectAttributes redirectAttributes) {
        try {
            boolean deleted = prekeService.deletePreke(id);
            if (deleted) {
                redirectAttributes.addFlashAttribute("successMessage", 
                    "Prekė sėkmingai ištrinta!");
            } else {
                redirectAttributes.addFlashAttribute("errorMessage", 
                    "Klaida trinant prekę!");
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", 
                "Klaida trinant prekę: " + e.getMessage());
        }
        return "redirect:/prekes";
    }
    
    // READ - View single preke
    @GetMapping("/view/{id}")
    public String viewPreke(@PathVariable("id") Integer id, Model model) {
        Optional<Preke> preke = prekeService.getPrekeById(id);
        
        if (preke.isPresent()) {
            model.addAttribute("preke", preke.get());
            return "prekes/view";
        }
        
        return "redirect:/prekes";
    }
    
    // SEARCH - Search prekes
    @GetMapping("/search")
    public String searchPrekes(@RequestParam(required = false) String pavadinimas,
                              @RequestParam(required = false) Double minKaina,
                              @RequestParam(required = false) Double maxKaina,
                              Model model) {
        List<Preke> prekes;
        
        if (pavadinimas != null && !pavadinimas.isEmpty()) {
            prekes = prekeService.searchByPavadinimas(pavadinimas);
        } else if (minKaina != null && maxKaina != null) {
            prekes = prekeService.findByKainaRange(minKaina, maxKaina);
        } else {
            prekes = prekeService.getAllPrekes();
        }
        
        model.addAttribute("prekes", prekes);
        return "prekes/list";
    }
    
    // Low stock alert
    @GetMapping("/low-stock")
    public String showLowStock(@RequestParam(defaultValue = "20") Integer threshold, 
                              Model model) {
        List<Preke> lowStockPrekes = prekeService.findLowStock(threshold);
        model.addAttribute("prekes", lowStockPrekes);
        model.addAttribute("lowStockMode", true);
        return "prekes/list";
    }
}

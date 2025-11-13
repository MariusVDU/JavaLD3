package com.example.rest_service.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.rest_service.model.Preke;
import com.example.rest_service.repository.PrekeRepository;

@Service
@Transactional
public class PrekeService {
    
    @Autowired
    private PrekeRepository prekeRepository;
    
    // CREATE or UPDATE
    public Preke savePreke(Preke preke) {
        return prekeRepository.save(preke);
    }
    
    // READ - Get all prekes
    public List<Preke> getAllPrekes() {
        return prekeRepository.findAll();
    }
    
    // READ - Get preke by ID
    public Optional<Preke> getPrekeById(Integer id) {
        return prekeRepository.findById(id);
    }
    
    // UPDATE
    public Preke updatePreke(Integer id, Preke prekeDetails) {
        Optional<Preke> optionalPreke = prekeRepository.findById(id);
        
        if (optionalPreke.isPresent()) {
            Preke preke = optionalPreke.get();
            preke.setPavadinimas(prekeDetails.getPavadinimas());
            preke.setKaina(prekeDetails.getKaina());
            preke.setKiekis(prekeDetails.getKiekis());
            return prekeRepository.save(preke);
        }
        
        throw new RuntimeException("Prekė su ID " + id + " nerasta");
    }
    
    // DELETE
    public boolean deletePreke(Integer id) {
        try {
            prekeRepository.deleteById(id);
            return true;
        } catch (Exception e) {
            return false;
        }
    }
    
    // Search by pavadinimas
    public List<Preke> searchByPavadinimas(String pavadinimas) {
        return prekeRepository.findByPavadinimasContainingIgnoreCase(pavadinimas);
    }
    
    // Find by kaina range
    public List<Preke> findByKainaRange(Double minKaina, Double maxKaina) {
        return prekeRepository.findByKainaBetween(minKaina, maxKaina);
    }
    
    // Find low stock items
    public List<Preke> findLowStock(Integer threshold) {
        return prekeRepository.findByKiekisLessThan(threshold);
    }
}

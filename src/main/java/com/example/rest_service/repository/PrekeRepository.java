package com.example.rest_service.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.rest_service.model.Preke;

@Repository
public interface PrekeRepository extends JpaRepository<Preke, Integer> {
    
    // Find by pavadinimas containing (case insensitive)
    List<Preke> findByPavadinimasContainingIgnoreCase(String pavadinimas);
    
    // Find by kaina range
    List<Preke> findByKainaBetween(Double minKaina, Double maxKaina);
    
    // Find by kiekis greater than
    List<Preke> findByKiekisGreaterThan(Integer kiekis);
    
    // Find by kiekis less than (low stock)
    List<Preke> findByKiekisLessThan(Integer kiekis);
}

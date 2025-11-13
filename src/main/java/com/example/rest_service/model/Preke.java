package com.example.rest_service.model;

import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.PrePersist;
import jakarta.persistence.Table;

@Entity
@Table(name = "PrekeLD2")
public class Preke {
    
    @Id
    @Column(name = "uniqID")
    private Integer uniqID;
    
    @Column(nullable = false)
    private String pavadinimas;
    
    @Column(nullable = false)
    private Double kaina;
    
    @Column(nullable = false)
    private Integer kiekis;
    
    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;
    
    // Constructors
    public Preke() {
    }
    
    public Preke(Integer uniqID, String pavadinimas, Double kaina, Integer kiekis) {
        this.uniqID = uniqID;
        this.pavadinimas = pavadinimas;
        this.kaina = kaina;
        this.kiekis = kiekis;
    }
    
    @PrePersist
    protected void onCreate() {
        if (createdAt == null) {
            createdAt = LocalDateTime.now();
        }
    }
    
    // Getters and Setters
    public Integer getUniqID() {
        return uniqID;
    }
    
    public void setUniqID(Integer uniqID) {
        this.uniqID = uniqID;
    }
    
    public String getPavadinimas() {
        return pavadinimas;
    }
    
    public void setPavadinimas(String pavadinimas) {
        this.pavadinimas = pavadinimas;
    }
    
    public Double getKaina() {
        return kaina;
    }
    
    public void setKaina(Double kaina) {
        this.kaina = kaina;
    }
    
    public Integer getKiekis() {
        return kiekis;
    }
    
    public void setKiekis(Integer kiekis) {
        this.kiekis = kiekis;
    }
    
    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
    
    @Override
    public String toString() {
        return "Preke{" +
                "uniqID=" + uniqID +
                ", pavadinimas='" + pavadinimas + '\'' +
                ", kaina=" + kaina +
                ", kiekis=" + kiekis +
                ", createdAt=" + createdAt +
                '}';
    }
}

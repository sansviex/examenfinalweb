package com.example.demo.repository;

import com.example.demo.model.AuditTrail;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface AuditTrailRepository extends JpaRepository<AuditTrail, Long> {
    List<AuditTrail> findByUserId(Long userId);
    List<AuditTrail> findByEntityAffected(String entityAffected);
} 